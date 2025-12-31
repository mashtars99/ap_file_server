-- ------------------------------
-- OPTION
-- ------------------------------

OPTION IMPORT;

-- ------------------------------
-- FUNCTIONS
-- ------------------------------

DEFINE FUNCTION fn::accounting::add_payment($entity: record<entity>, $method: object, $type: string, $amount: int, $reference: string, $description: string, $date: string) {
IF ($amount <= 0) { THROW 'Amount must be greater then 0'; };
LET $tx_type = IF ($type == 'sent') { RETURN 'payment_made'; } ELSE IF ($type == 'received') { RETURN 'payment_received'; } ELSE { THROW 'invalid payment type'; };
LET $tx = (CREATE ONLY transaction CONTENT { created_at: fn::utils::now(), date: <datetime> $date, type: $tx_type });
LET $var_entity = (SELECT * FROM ONLY $entity);
LET $asset_account = IF ($method['method'] == 'bank') { RETURN $method['account']; } ELSE IF ($method['method'] == 'cash') { RETURN (SELECT VALUE id FROM ONLY gl_account WHERE type = 'asset' AND name = 'Cash' LIMIT 1); } ELSE { THROW 'invalid payment method'; };
CREATE ONLY gl_account_entry CONTENT { account: $asset_account, decr: IF ($type == 'received') { 0 } ELSE { $amount }, description: $description, incr: IF ($type == 'received') { $amount } ELSE { 0 }, reference: $reference, transaction: $tx.id };
SELECT * FROM gl_account_entry WHERE account.name = 'Cash';
LET $account = $entity.account;
LET $gl_entry = (CREATE ONLY sl_account_entry CONTENT { account: $account, decr: IF ($type == 'received') { $amount } ELSE { 0 }, description: $description, incr: IF ($type == 'received') { 0 } ELSE { $amount }, reference: $reference, transaction: $tx.id });
SELECT * FROM sl_account_entry;
RETURN (SELECT * FROM ONLY $gl_entry);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::accounting::delete_transaction($tx: record<transaction>) {
DELETE gl_account_entry WHERE transaction = $tx;
DELETE sl_account_entry WHERE transaction = $tx;
DELETE $tx;
RETURN true;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::accounting::purchase_item($item_id: record<item>, $details: object, $date: string) {
LET $item = (SELECT * FROM ONLY $item_id);
IF (!$item) { THROW 'invalid request'; };
IF ($item.is_service = true) { THROW 'can not purchase service item'; };
LET $pmt = $details.payment_method;
LET $tx = (CREATE ONLY transaction CONTENT { created_at: fn::utils::now(), date: <datetime> $date, type: 'purchase' });
CREATE ONLY gl_account_entry CONTENT { account: $item.cogs_account, decr: 0, description: $details.description, incr: <int> $details.amount, reference: $details.reference, transaction: $tx.id };
LET $account = IF ($pmt['method'] == 'bank') { RETURN $pmt['account']; } ELSE IF ($pmt['method'] == 'cash') { RETURN (SELECT VALUE id FROM ONLY gl_account WHERE type = 'asset' AND name = 'Cash' LIMIT 1); } ELSE IF ($pmt.entity) { RETURN $pmt.entity; } ELSE { THROW 'invalid payment method'; };
LET $res = IF ($pmt.entity) {
LET $entity = (SELECT * FROM ONLY $pmt.entity);
RETURN (CREATE ONLY sl_account_entry CONTENT { account: $entity.account, decr: <int> $details.amount, description: $details.description, incr: 0, reference: $details.reference, transaction: $tx.id });
} ELSE { RETURN (CREATE ONLY gl_account_entry CONTENT { account: $account, decr: <int> $details.amount, description: $details.description, incr: 0, reference: $details.reference, transaction: $tx.id }); };
RETURN (SELECT * FROM ONLY $res);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::accounting::sell_item($entity_id: record<entity>, $item_id: record<item>, $sales_details: object, $purchase_details: option<object | null>, $date: string) {
LET $item = (SELECT * FROM ONLY $item_id);
LET $entity = (SELECT * FROM ONLY $entity_id);
IF !$item OR !$entity { THROW 'invalid reqeust'; };
LET $tx = (CREATE ONLY transaction CONTENT { created_at: fn::utils::now(), date: <datetime> $date, type: 'sale' });
CREATE ONLY gl_account_entry CONTENT { account: $item.income_account, decr: 0, description: $sales_details.description, incr: <int> $sales_details.amount, reference: $sales_details.reference, transaction: $tx.id };
CREATE ONLY sl_account_entry CONTENT { account: $entity.account, decr: 0, description: $sales_details.description, incr: <int> $sales_details.amount, reference: $sales_details.reference, transaction: $tx.id };
IF ($purchase_details) { fn::accounting::purchase_item($purchase_details.item_id, $purchase_details, type::string($date)) };
} PERMISSIONS FULL;
DEFINE FUNCTION fn::activate_entity($e: record<entity>) { RETURN (UPDATE ONLY $e SET status = 'active'); } PERMISSIONS FULL;
DEFINE FUNCTION fn::active_vp_by_template($pt: record<pipeline_template>) { RETURN (SELECT count() AS count, stages[WHERE status = 'active'].name[0] AS stage FROM pipeline WHERE template = $pt GROUP BY stage); } PERMISSIONS FULL;
DEFINE FUNCTION fn::add_bank($name: string, $abbr: string) { RETURN (CREATE ONLY bank CONTENT { abbr: $abbr, name: $name }); } PERMISSIONS FULL;
DEFINE FUNCTION fn::add_bank_account($bank: record<bank>, $title: string, $account_no: string, $iban: option<string | null>) {
LET $var_bank = (SELECT * FROM ONLY $bank);
LET $asset_acc = (CREATE ONLY gl_account CONTENT { name: 'bank:' + $bank.name + ':' + $title, type: 'asset' });
LET $banks_account = (SELECT * FROM ONLY gl_account WHERE name = 'Banks' AND type = 'asset' LIMIT 1);
RELATE $asset_acc -> gl_subaccount_of -> $banks_account;
RETURN (CREATE ONLY bank_account CONTENT { account_no: $account_no, asset_account: $asset_acc.id, bank: $var_bank.id, iban: $iban, title: $title });
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_bank_account_deposit($bank_account: record<bank_account>, $amount: int, $ref: string, $desc: string) {
LET $tx = (CREATE ONLY transaction CONTENT { created_at: fn::utils::now(), date: fn::utils::now(), type: 'bank_deposit' });
LET $var_bank_account = (SELECT * FROM ONLY $bank_account);
LET $gl_bank_account = $var_bank_account.asset_account;
LET $gl_cash_account = (SELECT * FROM ONLY gl_account WHERE type = 'asset' AND name = 'Cash' LIMIT 1);
LET $bca = (CREATE ONLY bank_account_deposit CONTENT { account: $bank_account, amount: $amount, description: $desc, reference: $ref, transaction: $tx.id });
CREATE ONLY gl_account_entry CONTENT { account: $gl_cash_account.id, decr: $amount, description: $desc, incr: 0, ref: $ref, transaction: $tx.id };
LET $result = (CREATE ONLY gl_account_entry CONTENT { account: $gl_bank_account.id, decr: 0, description: $desc, incr: $amount, ref: $ref, transaction: $tx.id });
RETURN (SELECT * FROM ONLY $bca.id);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_bank_account_withdrawal($bank_account: record<bank_account>, $amount: int, $ref: string, $desc: string) {
LET $tx = (CREATE ONLY transaction CONTENT { created_at: fn::utils::now(), date: fn::utils::now(), type: 'bank_withdrawal' });
LET $var_bank_account = (SELECT * FROM ONLY $bank_account);
LET $gl_bank_account = $var_bank_account.asset_account;
LET $gl_cash_account = (SELECT * FROM ONLY gl_account WHERE type = 'asset' AND name = 'Cash' LIMIT 1);
LET $bca = (CREATE ONLY bank_account_withdrawl CONTENT { account: $bank_account, amount: $amount, description: $desc, reference: $ref, transaction: $tx.id });
CREATE ONLY gl_account_entry CONTENT { account: $gl_cash_account.id, decr: 0, description: $desc, incr: $amount, ref: $ref, transaction: $tx.id };
LET $result = (CREATE ONLY gl_account_entry CONTENT { account: $gl_bank_account.id, decr: $amount, description: $desc, incr: 0, ref: $ref, transaction: $tx.id });
RETURN (SELECT * FROM ONLY $bca.id);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_candidate_profile($givenName: string, $surname: string, $fatherGivenName: string, $fatherSurname: string, $placeOfBirth: string, $dateOfBirth: string, $passportNumber: string, $passportIssuePlace: string, $passportIssueDate: string, $passportExpiryDate: string, $meritalStatus: string, $religion: string, $gender: string, $cnic: string, $image: string, $notes: string) {
LET $prof = (CREATE ONLY candidate_profile CONTENT { cnic: string::trim($cnic), dob: <datetime> $dateOfBirth, father_given_name: string::trim($fatherGivenName), father_surname: string::trim($fatherSurname), gender: $gender, given_name: string::trim($givenName), merital_status: string::trim($meritalStatus), notes: $notes, passport_expiry_date: <datetime> $passportExpiryDate, passport_issue_date: <datetime> $passportIssueDate, passport_issue_place: string::trim($passportIssuePlace), passport_number: string::trim($passportNumber), picture: $image, place_of_birth: string::trim($placeOfBirth), religion: string::trim($religion), surname: string::trim($surname) });
RETURN (SELECT * FROM ONLY $prof);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_capital($amount: int, $method: object, $date: string, $description: string) {
LET $asset_account = IF ($method['method'] == 'bank') { RETURN $method['account']; } ELSE IF ($method['method'] == 'cash') { RETURN (SELECT VALUE id FROM ONLY gl_account WHERE type = 'asset' AND name = 'Cash' LIMIT 1); } ELSE { THROW 'invalid payment method'; };
LET $tx = (CREATE ONLY transaction CONTENT { created_at: fn::utils::now(), date: <datetime> $date, type: 'equity_add_capital' });
CREATE ONLY gl_account_entry CONTENT { account: $asset_account, decr: 0, description: $description, incr: $amount, reference: '', transaction: $tx.id };
LET $capital = (SELECT * FROM ONLY gl_account WHERE type = 'equity' AND name = 'OwnerCapital' LIMIT 1);
LET $res = (CREATE ONLY gl_account_entry CONTENT { account: $capital.id, decr: 0, description: $description, incr: $amount, reference: '', transaction: $tx.id });
RETURN (SELECT *, transaction[*] AS tx FROM ONLY $res);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_drawing($amount: int, $method: object, $date: string, $description: string) {
LET $asset_account = IF ($method['method'] == 'bank') { RETURN $method['account']; } ELSE IF ($method['method'] == 'cash') { RETURN (SELECT VALUE id FROM ONLY gl_account WHERE type = 'asset' AND name = 'Cash' LIMIT 1); } ELSE { THROW 'invalid payment method'; };
LET $tx = (CREATE ONLY transaction CONTENT { created_at: fn::utils::now(), date: <datetime> $date, type: 'equity_drawing' });
CREATE ONLY gl_account_entry CONTENT { account: $asset_account, decr: $amount, description: $description, incr: 0, reference: '', transaction: $tx.id };
LET $drawing = (SELECT * FROM ONLY gl_account WHERE type = 'equity' AND name = 'OwnerDraw' LIMIT 1);
LET $res = (CREATE ONLY gl_account_entry CONTENT { account: $drawing.id, decr: 0, description: $description, incr: $amount, reference: '', transaction: $tx.id });
RETURN (SELECT *, transaction[*] AS tx FROM ONLY $res);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_entity($name: string, $balance: option<int | null>, $address: option<string | null>, $contacts: option<array<string> | null>, $picture: option<string | null>, $balance_as_of: option<string | null>, $type: string) {
LET $account = (CREATE ONLY sl_account);
LET $var_customer = (CREATE ONLY entity CONTENT { account: $account.id, address: $address, contacts: $contacts, name: $name, picture: $picture, type: $type });
IF $balance {
LET $tx = (CREATE ONLY transaction CONTENT { created_at: fn::utils::now(), date: <datetime> $balance_as_of, type: 'opening_balance' });
IF $balance < 0 { CREATE ONLY sl_account_entry CONTENT { account: $account.id, decr: $balance, description: 'opening balance', incr: 0, reference: '', transaction: $tx.id }; } ELSE { CREATE ONLY sl_account_entry CONTENT { account: $account.id, decr: 0, description: 'opening balance', incr: $balance, reference: '', transaction: $tx.id }; };
};
RETURN (SELECT * FROM ONLY $var_customer);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_expense($account: record<gl_account>, $amount: int, $method: object, $description: string, $ref: string, $date: string) {
LET $tx = (CREATE ONLY transaction CONTENT { created_at: fn::utils::now(), date: <datetime> $date, type: 'expense' });
LET $asset_account = IF ($method['method'] == 'bank') { RETURN $method['account']; } ELSE IF ($method['method'] == 'cash') { RETURN (SELECT VALUE id FROM ONLY gl_account WHERE type = 'asset' AND name = 'Cash' LIMIT 1); } ELSE { THROW 'invalid payment method'; };
CREATE gl_account_entry CONTENT { account: $asset_account, decr: $amount, description: $description, incr: 0, reference: $ref, transaction: $tx.id };
LET $res = (CREATE ONLY gl_account_entry CONTENT { account: $account, decr: 0, description: $description, incr: $amount, referene: $ref, transaction: $tx.id });
RETURN (SELECT *, transaction[*] AS tx FROM ONLY $res);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_expense_account($name: string) { RETURN (CREATE ONLY gl_account CONTENT { meta: { type: 'custom' }, name: $name, type: 'expense' }); } PERMISSIONS FULL;
DEFINE FUNCTION fn::add_focal_person($name: string, $ref: string, $contacts: string) {
LET $fp = (CREATE ONLY focal_person CONTENT { contacts: $contacts, name: $name, reference: $ref });
RETURN (SELECT * FROM ONLY $fp);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_folder($name: string, $ffor: record) {
LET $folder = (CREATE ONLY folder CONTENT { name: $name });
LET $folder_id = $folder.id;
RELATE $folder_id -> folder_belongs_to -> $ffor;
RETURN $folder;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_folder_file($identifier: string, $meta: object, $folder: record<folder>) {
LET $file = (CREATE ONLY file CONTENT { folder: $folder, identifier: $identifier, metadata: $meta, name: $meta.name });
LET $file_id = $file.id;
RETURN $file;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_item($name: string, $purchase_description: string, $sale_description: string, $is_service: bool) {
LET $asset_account = (CREATE ONLY gl_account CONTENT { name: rand::ulid(), type: 'asset' });
LET $income_account = (CREATE ONLY gl_account CONTENT { name: rand::ulid(), type: 'income' });
LET $contra_income_account = (CREATE ONLY gl_account CONTENT { name: rand::ulid(), type: 'contra_income' });
LET $expense_account = (CREATE ONLY gl_account CONTENT { name: rand::ulid(), type: 'expense' });
LET $contra_expense_account = (CREATE ONLY gl_account CONTENT { name: rand::ulid(), type: 'contra_expense' });
RETURN (CREATE ONLY item CONTENT { asset_account: $asset_account.id, cogs_account: $expense_account.id, contra_cogs_account: $contra_expense_account.id, contra_income_account: $contra_income_account.id, income_account: $income_account.id, is_service: $purchased, name: $name, purchase_description: $purchase_description, sale_description: $sale_description });
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_pipeline_template($name: string, $stages: array<object>) {
LET $template = (CREATE ONLY pipeline_template CONTENT { name: $name });
FOR $obj IN $stages { CREATE pipeline_template_stage CONTENT { description: $obj.description, name: $obj.name, order: $obj.index, tasks: $obj.tasks, template: $template.id }; };
RETURN fn::pipelines::get_template_full($template.id);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_sv_document($document_no: string, $sponsor_id: string, $sponsor_name: string, $sponsor_name_arabic: string, $sponsor_address: string, $focal_person: record<focal_person>, $jobs: array<object>) {
LET $doc = (CREATE ONLY saudi_visas_document CONTENT { document_number: string::trim($document_no), focal_person: $focal_person, sponsor_address: string::trim($sponsor_address), sponsor_id: string::trim($sponsor_id), sponsor_name_arabic: string::trim($sponsor_name_arabic), sponsor_name_english: string::trim($sponsor_name) });
FOR $obj IN $jobs { CREATE ONLY svd_job CONTENT { embassy: $obj.embassy, job: (SELECT * FROM ONLY $obj.job_id), jobs_count: $obj.jobs_count, svd: $doc.id }; };
RETURN fn::get_full_svd($doc.id);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_svd_job($svd: record<saudi_visas_document>, $saudi_job: record<saudi_job>, $jobs_count: int, $embassy: string) {
CREATE ONLY svd_job CONTENT { embassy: $embassy, job: (SELECT * FROM ONLY $saudi_job), jobs_count: $jobs_count, svd: $svd };
RETURN fn::get_full_svd($svd);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_svp($profile_id: record<candidate_profile>, $svd: record<saudi_visas_document>, $svd_job_id: record<svd_job>, $pipeline_template_id: record<pipeline_template>) {
LET $svd_job = (SELECT * FROM ONLY $svd_job_id);
LET $svp_assigned_jobs = (SELECT * FROM svp_assigned_job WHERE svd = $svd AND svd_job = $svd_job.id AND status != 'cancelled');
IF ($svp_assigned_jobs == NULL OR array::len($svp_assigned_jobs) == $svd_job.jobs_count) { THROW 'no available jobs'; };
LET $case = (SELECT * FROM saudi_visa_process WHERE profile = $profile_id AND status == 'active');
IF $case { THROW 'There is already an active case for this profile'; };
LET $svp_assign_job = (CREATE ONLY svp_assigned_job CONTENT { svd: $svd, svd_job: $svd_job.id });
LET $profile = (SELECT * FROM ONLY $profile_id);
LET $item = (SELECT * FROM ONLY item WHERE name == 'svp' LIMIT 1);
LET $pipeline = fn::pipelines::create_pipeline($pipeline_template_id);
IF (!$pipeline) { THROW 'error while creating pipeline'; };
LET $process = (CREATE ONLY saudi_visa_process CONTENT { assigned_job: $svp_assign_job.id, item_unit: $unit.id, pipeline: $pipeline.id, profile: $profile.id, svd: $svd });
RETURN (SELECT * FROM ONLY $process);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_ticket($pnr: string, $passengers: array<object>, $sectors: array<object>) { RETURN (CREATE ONLY ticket CONTENT { created_at: fn::utils::now(), passengers: $passengers, pnr: $pnr, refunded: false, sectors: $sectors }); } PERMISSIONS FULL;
DEFINE FUNCTION fn::complete_svd($svd_id: record<saudi_visas_document>) {
LET $svd = (SELECT * FROM ONLY $svd_id);
IF (!$svd) { THROW 'invalid request'; };
LET $svd_jobs = (SELECT * FROM svd_job WHERE svd = $svd_id);
LET $svd_jobs_count = math::sum(array::map($svd_jobs, |$a: any| $a.jobs_count));
LET $svp_cases = (SELECT * FROM saudi_visa_process WHERE svd = $svd_id AND status = 'completed');
IF (array::len($svp_cases) < $svd_jobs_count) { THROW 'There are still pending cases/unassigned jobs'; };
LET $svd_updated = (UPDATE ONLY $svd_id MERGE { completed: true });
RETURN fn::get_full_svd($svd_updated.id);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::create_mapping($template: record<template>, $resource: string, $mappings: object) {
LET $mp = (CREATE ONLY resource_template_mapping CONTENT { mapping: $mappings, resource: $resource, template: $template });
RETURN (SELECT * FROM ONLY $mp);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::daily_payments($d: string) {
LET $dt = time::floor(<datetime> $d, 1d);
LET $recv = (SELECT transaction.date AS date, math::sum(decr) AS total FROM sl_account_entry WHERE transaction.type == 'payment_received' AND time::floor(transaction.date, 1d) == $dt GROUP BY transaction.date);
LET $paid = (SELECT transaction.date AS date, math::sum(decr) AS total FROM sl_account_entry WHERE transaction.type == 'payment_made' AND time::floor(transaction.date, 1d) == $dt GROUP BY transaction.date);
LET $recv = (SELECT * FROM ONLY $recv LIMIT 1);
LET $paid = (SELECT * FROM ONLY $paid LIMIT 1);
RETURN { paid: $paid.total ?? 0, received: $recv.total ?? 0 };
} PERMISSIONS FULL;
DEFINE FUNCTION fn::daily_revenue($date: string) {
LET $dt = <datetime> $date;
RETURN (SELECT account.name AS account_name, math::sum(incr - decr) AS amount FROM gl_account_entry WHERE account.type = 'income' AND time::year(transaction.date) == time::year($dt) AND time::month(transaction.date) == time::month($dt) AND time::day(transaction.date) == time::day($dt) GROUP BY account_name);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::delete_focal_person($fp: record<focal_person>) {
LET $foc = (SELECT * FROM ONLY $fp);
IF (!$foc) { THROW 'invalid request'; };
LET $docs = (SELECT * FROM saudi_visas_document WHERE focal_person = $fp);
IF (array::len($docs) > 0) { THROW 'Documents belong to this focal person'; };
DELETE $fp;
RETURN true;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::delete_item($item_id: record<item>) {
LET $item = (SELECT *, asset_account[*], income_account[*], contra_income_account[*], cogs_account[*], contra_cogs_account[*] FROM ONLY $item_id);
IF ($item.asset_account.balance != 0 OR $item.income_account.balance != 0 OR $item.contra_income_account.balance != 0 OR $item.cogs_account.balance != 0 OR $item.contra_cogs_account.balance != 0) { THROW 'item with transactions can not be deleted'; };
DELETE $item_id;
RETURN true;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::delete_mapping($id: record<resource_template_mapping>) {
DELETE $id;
RETURN true;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::delete_svd($svdId: record<saudi_visas_document>) {
LET $svd = (SELECT * FROM ONLY $svdId);
IF (!$svd) { THROW 'Invalid requrest'; };
LET $svps = (SELECT * FROM saudi_visa_process WHERE svd = $svdId);
IF (array::len($svps) > 0) { THROW 'There are cases belonging to this document'; };
DELETE svp_assigned_job WHERE svd = $svdId;
DELETE $svdId;
RETURN true;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::edit_candidate_profile($id: record<candidate_profile>, $givenName: string, $surname: string, $fatherGivenName: string, $fatherSurname: string, $placeOfBirth: string, $dateOfBirth: string, $passportNumber: string, $passportIssuePlace: string, $passportIssueDate: string, $passportExpiryDate: string, $meritalStatus: string, $religion: string, $gender: string, $cnic: string, $image: string, $notes: string) {
LET $old = (SELECT * FROM ONLY $id);
IF (!$old) { THROW 'invalid request'; };
LET $prof = (UPDATE ONLY $id MERGE { cnic: $cnic, dob: <datetime> $dateOfBirth, father_given_name: $fatherGivenName, father_surname: $fatherSurname, gender: $gender, given_name: $givenName, merital_status: $meritalStatus, notes: $notes, passport_expiry_date: <datetime> $passportExpiryDate, passport_issue_date: <datetime> $passportIssueDate, passport_issue_place: $passportIssuePlace, passport_number: $passportNumber, picture: $image, place_of_birth: $placeOfBirth, religion: $religion, surname: $surname });
RETURN (SELECT * FROM ONLY $prof);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::edit_focal_person($id: record<focal_person>, $name: string, $ref: string, $contacts: string) {
LET $fp = (UPDATE ONLY $id MERGE { contacts: $contacts, name: $name, reference: $ref });
RETURN (SELECT * FROM ONLY $fp);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::edit_item($item: record<item>, $sales_desc: string, $purc_desc: string) {
UPDATE $item MERGE { purchase_description: $purc_desc, sale_description: $sales_desc };
RETURN (SELECT * FROM ONLY $item);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::edit_svd($svd_id: record<saudi_visas_document>, $name_arabic: string, $name_english: string, $addr: string) {
LET $svd = (SELECT * FROM ONLY $svd_id);
IF (!$svd) { THROW 'invalid request'; };
LET $svd_updated = (UPDATE ONLY $svd_id MERGE { sponsor_address: $addr, sponsor_name_arabic: $name_arabic, sponsor_name_english: $name_english });
RETURN fn::get_full_svd($svd_updated.id);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::files::rename_file($file: record<file>, $name: string) {
IF (string::len($name) == 0) { THROW 'name is required'; };
IF (string::matches('[<>:"/\\|?*]', $name)) { THROW 'invalid name, name should not contain special characters.'; };
RETURN (UPDATE ONLY $file SET name = $name);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::get_active_svds_full() {
LET $svds = (SELECT *, focal_person[*], (SELECT * FROM svd_job WHERE svd = $parent.id) AS jobs, { assigned_jobs: (SELECT * FROM svp_assigned_job WHERE svd = $parent.id) } AS extra FROM saudi_visas_document WHERE completed = false ORDER BY created_at DESC
);
RETURN $svds;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::get_all_items() { RETURN (SELECT * FROM item); } PERMISSIONS FULL;
DEFINE FUNCTION fn::get_all_svds_full() {
LET $svds = (SELECT *, focal_person[*], (SELECT * FROM svd_job WHERE svd = $parent.id) AS jobs, { assigned_jobs: (SELECT * FROM svp_assigned_job WHERE svd = $parent.id) } AS extra FROM saudi_visas_document ORDER BY created_at DESC
);
RETURN $svds;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::get_all_svps_full() {
LET $svps = (SELECT *, (SELECT *, (SELECT *, transaction[*] FROM item_unit_part WHERE unit = $parent.id) AS parts FROM ONLY $parent.item_unit) AS item_unit, (SELECT *, svd_job[*] FROM ONLY $parent.assigned_job) AS assigned_job, (fn::get_full_svd($parent.svd)) AS svd, profile[*] FROM saudi_visa_process WHERE status = 'active' ORDER BY created_at DESC
);
RETURN $svps;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::get_cash_in_banks() {
LET $balances = (SELECT asset_account.balance AS balance FROM bank_account);
LET $result = array::reduce($balances, |$a: any, $b: any| $a.balance + $b.balance);
RETURN $result.balance ?? 0;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::get_cash_on_hand() {
LET $acc = (SELECT * FROM ONLY gl_account WHERE name = 'Cash' AND type = 'asset' LIMIT 1);
RETURN $acc.balance;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::get_folder_files($folder: record<folder>) { RETURN (SELECT * FROM file WHERE folder = $folder); } PERMISSIONS FULL;
DEFINE FUNCTION fn::get_folders($ref: record) { RETURN (SELECT VALUE folders FROM ONLY (SELECT <-folder_belongs_to<-folder AS folders FROM ONLY $ref)); } PERMISSIONS FULL;
DEFINE FUNCTION fn::get_full_svd($svd_id: record<saudi_visas_document>) {
LET $svd = (SELECT *, focal_person[*], (SELECT * FROM svd_job WHERE svd = $parent.id) AS jobs, { assigned_jobs: (SELECT * FROM svp_assigned_job WHERE svd = $parent.id) } AS extra FROM ONLY $svd_id);
RETURN $svd;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::get_full_svp($svp_id: record<saudi_visa_process>) {
LET $svp = (SELECT *, (SELECT *, (SELECT *, transaction[*] FROM item_unit_part WHERE unit = $parent.id) AS parts FROM ONLY $parent.item_unit) AS item_unit, (SELECT *, svd_job[*] FROM ONLY $parent.assigned_job) AS assigned_job, (fn::get_full_svd($parent.svd)) AS svd, profile[*] FROM ONLY $svp_id);
RETURN $svp;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::get_subaccounts($acc: record<gl_account>) {
LET $res = (SELECT <-gl_subaccount_of<-gl_account AS subs FROM ONLY $acc.id);
RETURN (SELECT *, $acc AS parent FROM $res['subs']);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::inactivate_entity($entity: record<entity>) {
LET $var_entity = (SELECT * FROM ONLY $entity);
LET $customer_acc = (SELECT * FROM ONLY $var_entity.account);
IF (!$customer_acc) { THROW 'invalid entity'; };
IF ($customer_acc AND $customer_acc.balance != 0) { THROW 'can not inactivate entity with balance'; };
RETURN (UPDATE ONLY $entity SET status = 'inactive');
} PERMISSIONS FULL;
DEFINE FUNCTION fn::monthly_payments($m: string) {
LET $dt = <datetime> $m;
LET $dt = time::now();
LET $recv = (SELECT time::month(transaction.date) AS month, math::sum(incr) AS total FROM sl_account_entry WHERE transaction.type == 'payment_made' AND time::year(transaction.date) == time::year($dt) AND time::month(transaction.date) == time::month($dt) GROUP BY month);
LET $paid = (SELECT time::month(transaction.date) AS month, math::sum(incr) AS total FROM sl_account_entry WHERE transaction.type == 'payment_received' AND time::year(transaction.date) == time::year($dt) AND time::month(transaction.date) == time::month($dt) GROUP BY month);
LET $recv = (SELECT * FROM ONLY $recv LIMIT 1);
LET $paid = (SELECT * FROM ONLY $paid LIMIT 1);
RETURN { paid: $paid.total ?? 0, received: $recv.total ?? 0 };
} PERMISSIONS FULL;
DEFINE FUNCTION fn::monthly_revenue($m: string) {
LET $dt = <datetime> $m;
RETURN (SELECT account.name AS account_name, math::sum(incr - decr) AS amount FROM gl_account_entry WHERE account.type == 'income' AND time::month(transaction.date) == time::month($dt) AND time::year(transaction.date) == time::year($dt) GROUP BY account_name);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::months_payments_by_year($y: int) { RETURN (SELECT time::month(transaction.date) AS month, math::sum(amount) AS total FROM payment_receipt WHERE time::year(transaction.date) == $y GROUP BY month); } PERMISSIONS FULL;
DEFINE FUNCTION fn::months_revenue_by_year($y: int) { RETURN (SELECT time::month(transaction.date) AS month, math::sum(incr - decr) AS amount FROM gl_account_entry WHERE account.type == 'income' AND time::year(transaction.date) == $y GROUP BY month); } PERMISSIONS FULL;
DEFINE FUNCTION fn::next_svp_no() { RETURN (SELECT * FROM count((SELECT * FROM saudi_visa_process)))[0] + 1; } PERMISSIONS FULL;
DEFINE FUNCTION fn::pipelines::change_task_status($id: record<stage_task>, $status: bool) {
LET $task = (SELECT * FROM ONLY $id);
IF !$id { THROW 'invalid task'; };
UPDATE ONLY $id MERGE { done: $status };
RETURN true;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::pipelines::complete_stage($id: record<stage>) {
LET $stage = (SELECT *, template_stage.order AS order FROM ONLY $id);
IF !$stage { THROW 'invalid stage'; };
LET $arr = (SELECT *, template_stage.order AS ord FROM stage WHERE pipeline = $stage.pipeline ORDER BY ord
);
LET $total_stages = array::len($arr);
IF ($stage.order == $total_stages - 1) { UPDATE ONLY $stage.pipeline MERGE { current_stage: NULL, finished: true }; } ELSE IF ($stage.order < $total_stages - 1) {
LET $next = (SELECT * FROM ONLY $arr WHERE ord = ($stage.order + 1) LIMIT 1);
UPDATE ONLY $stage.pipeline SET current_stage = $next.id;
};
UPDATE ONLY $id MERGE { completed: true };
RETURN true;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::pipelines::create_pipeline($template_id: record<pipeline_template>) {
LET $template = fn::pipelines::get_template_full($template_id);
IF !$template { THROW 'invalid pipeline template'; };
LET $pipeline = (CREATE ONLY pipeline CONTENT { template: $template_id });
FOR $stg IN $template.stages {
LET $stage = (CREATE ONLY stage CONTENT { pipeline: $pipeline.id, template_stage: $stg.id });
FOR $tsk IN $stg.tasks { CREATE ONLY stage_task CONTENT { description: $tsk.description, name: $tsk.name, stage: $stage.id }; };
};
UPDATE ONLY $pipeline MERGE { current_stage: (SELECT * FROM ONLY stage WHERE pipeline = $pipeline.id AND template_stage.order = 0 LIMIT 1).id };
RETURN fn::pipelines::get_pipeline_full($pipeline.id);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::pipelines::get_all_templates_full() { RETURN (SELECT *, array::len((SELECT id FROM pipeline WHERE template = $parent.id)) AS active_pipelines, (SELECT * FROM pipeline_template_stage WHERE template = $parent.id ORDER BY order
) AS stages FROM pipeline_template); } PERMISSIONS FULL;
DEFINE FUNCTION fn::pipelines::get_pipeline_full($id: record<pipeline>) { RETURN (SELECT *, template.name AS template_name, (SELECT *, template_stage[*], (SELECT * FROM stage_task WHERE stage = $parent.id) AS tasks FROM stage WHERE pipeline = $id ORDER BY template_stage.order
) AS stages, IF current_stage { fn::pipelines::get_pipeline_stage_full(current_stage) } AS current_stage FROM ONLY $id); } PERMISSIONS FULL;
DEFINE FUNCTION fn::pipelines::get_pipeline_stage_full($id: record<stage>) { RETURN (SELECT *, template_stage[*], (SELECT * FROM stage_task WHERE stage = $id) AS tasks FROM ONLY $id); } PERMISSIONS FULL;
DEFINE FUNCTION fn::pipelines::get_template_full($id: record<pipeline_template>) {
LET $count = (SELECT id FROM pipeline WHERE template = $id GROUP ALL);
RETURN (SELECT *, array::len($count) AS active_pipelines, (SELECT * FROM pipeline_template_stage WHERE template = $id ORDER BY order
) AS stages FROM ONLY $id);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::pipelines::template_report($template_id: record<pipeline_template>) { RETURN (SELECT count() AS cases, current_stage.template_stage AS stage FROM pipeline WHERE template = $template_id GROUP BY stage); } PERMISSIONS FULL;
DEFINE FUNCTION fn::pipelines::update_template($template_id: record<pipeline_template>, $name: string | null) {
LET $template = (SELECT * FROM ONLY $template_id);
IF (!$template) { THROW 'invalid template'; };
UPDATE ONLY $template_id MERGE { name: $name ?? $template.name };
RETURN fn::pipelines::get_template_full($template_id);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::pipelines::update_template_stage($stage_id: record<pipeline_template_stage>, $name: string | null, $description: string | null) {
LET $template_stage = (SELECT * FROM ONLY $stage_id);
IF (!$template_stage) { THROW 'invalid stage'; };
UPDATE ONLY $stage_id MERGE { description: $description ?? $template_stage.description, name: $name ?? $template_stage.name };
RETURN fn::pipelines::get_template_full($template_stage.template);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::pipelines::update_template_stage_tasks($stage_id: record<pipeline_template_stage>, $tasks: array<object>) {
LET $template_stage = (SELECT * FROM ONLY $stage_id);
IF (!$template_stage) { THROW 'invalid stage'; };
UPDATE ONLY $stage_id MERGE { tasks: $tasks };
RETURN fn::pipelines::get_template_full($template_stage.template);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::remove_job_from_svd_job($svd_job_id: record<svd_job>, $remove_count: int) {
LET $svd_job = (SELECT * FROM ONLY $svd_job_id);
LET $assigned_jobs = (SELECT * FROM svp_assigned_job WHERE svd_job = $svd_job.id);
LET $available_jobs = $svd_job.jobs_count - array::len($assigned_jobs);
IF ($available_jobs < $remove_count) { THROW 'not enough jobs'; };
UPDATE ONLY $svd_job_id MERGE { jobs_count: $svd_job.jobs_count - $remove_count };
LET $svd_job = (SELECT * FROM ONLY $svd_job.id);
IF ($svd_job.jobs_count == 0) { DELETE $svd_job.id; };
RETURN fn::get_full_svd($svd_job.svd);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::reporting::balance_sheet() {
LET $assets_total = (SELECT VALUE total FROM ONLY (SELECT math::sum(balance) AS total FROM ONLY gl_account WHERE type = 'asset' GROUP ALL));
LET $bank_balances = (SELECT asset_account.balance AS balance FROM bank_account);
LET $banks_total = array::fold($bank_balances, 0, |$prev: any, $a: any| $prev + $a.balance);
LET $cash = (SELECT VALUE balance FROM ONLY gl_account WHERE name = 'Cash' LIMIT 1);
LET $recievable_balances = (SELECT account.balance AS balance FROM entity WHERE type = 'customer');
LET $receivable = array::fold($recievable_balances, 0, |$prev: any, $a: any| $prev + $a.balance);
LET $payable_balances = (SELECT -1 * account.balance AS balance FROM entity WHERE type = 'vendor');
LET $payable = array::fold($payable_balances, 0, |$prev: any, $a: any| $prev + $a.balance);
RETURN { assets: { banks: $banks_total, cash: $cash, receivable: $receivable, total: $assets_total + $receivable }, liabilities: { payable: $payable, total: $payable } };
} PERMISSIONS FULL;
DEFINE FUNCTION fn::reporting::customer_account_balance_till($customer_id: record<entity>, $dt: string) {
LET $customer = (SELECT * FROM ONLY $customer_id);
LET $account = $customer.customer_account;
LET $date = time::floor(<datetime> $dt, 1d);
LET $b = (SELECT *, math::sum(incr - decr) AS balance FROM ONLY sl_account_entry WHERE account = $account AND time::floor(transaction.date, 1d) < $date GROUP ALL ORDER BY transaction.date DESC
 LIMIT 1);
RETURN IF ($b == NONE) { RETURN 0; } ELSE { RETURN $b.balance; };
} PERMISSIONS FULL;
DEFINE FUNCTION fn::reporting::customer_statement($std: string, $edt: string, $customer: record<entity>) {
LET $startDate = time::floor(<datetime> $std, 1d);
LET $endDate = time::floor(<datetime> $edt, 1d);
LET $customer = (SELECT * FROM ONLY $customer);
LET $account = $customer.account;
RETURN (SELECT *, transaction[*] AS tx FROM sl_account_entry WHERE account = $account AND time::floor(transaction.date, 1d) >= $starDate AND time::floor(transaction.date, 1d) <= $endDate ORDER BY transaction.date DESC
);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::reporting::income_statement($start: string, $end: string) {
LET $start_date = time::floor(<datetime> $start, 1d);
LET $end_date = time::floor(<datetime> $end, 1d);
LET $income_accounts = (SELECT income_account FROM item);
LET $income_accounts = array::map($income_accounts, |$acc: any| $acc.income_account);
LET $sum = (SELECT account, math::sum(incr - decr) AS total FROM gl_account_entry WHERE account INSIDE $income_accounts AND time::floor(transaction.date, 1d) >= $start_date AND time::floor(transaction.date, 1d) <= $end_date GROUP BY account);
LET $sum = array::map($sum, |$val: any| $val.total);
LET $op_rev = math::sum($sum);
LET $cogs_accounts = (SELECT cogs_account FROM item);
LET $cogs_accounts = array::map($cogs_accounts, |$acc: any| $acc.cogs_account);
LET $sum = (SELECT account, math::sum(incr - decr) AS total FROM gl_account_entry WHERE account INSIDE $cogs_accounts AND time::floor(transaction.date, 1d) >= $start_date AND time::floor(transaction.date, 1d) <= $end_date GROUP BY account);
LET $sum = array::map($sum, |$val: any| $val.total);
LET $op_exp = math::sum($sum);
RETURN { cogs: $op_exp, revenue: $op_rev };
} PERMISSIONS FULL;
DEFINE FUNCTION fn::reporting::item_wise_income_statement($start: string, $end: string) {
LET $start_date = time::floor(<datetime> $start, 1d);
LET $end_date = time::floor(<datetime> $end, 1d);
LET $data = (SELECT name, income_account, transaction, (SELECT account, math::sum(incr - decr) AS total FROM ONLY gl_account_entry WHERE account = $parent.income_account AND time::floor(transaction.date, 1d) >= $start_date AND time::floor(transaction.date, 1d) <= $end_date GROUP BY account) AS revenue, (SELECT account, math::sum(incr - decr) AS total FROM ONLY gl_account_entry WHERE account = $parent.cogs_account AND time::floor(transaction.date, 1d) >= $start_date AND time::floor(transaction.date, 1d) <= $end_date GROUP BY account) AS cogs FROM item);
RETURN array::map($data, |$v: any| { { cogs: $v.cogs.total ?? 0, name: $v.name, revenue: $v.revenue.total ?? 0 } });
} PERMISSIONS FULL;
DEFINE FUNCTION fn::reporting::payable_statement() { RETURN (SELECT *, -1 * account.balance AS balance FROM entity WHERE status == 'active' AND type = 'vendor'); } PERMISSIONS FULL;
DEFINE FUNCTION fn::reporting::receivable_statement() { RETURN (SELECT *, account.balance AS balance FROM entity WHERE status == 'active' AND type = 'customer'); } PERMISSIONS FULL;
DEFINE FUNCTION fn::reporting::vendor_account_balance_till($vendor_id: record<entity>, $dt: string) {
LET $vendor = (SELECT * FROM ONLY $vendor_id);
LET $account = $vendor.vendor_account;
LET $date = time::floor(<datetime> $dt, 1d);
LET $b = (SELECT *, math::sum(incr - decr) AS balance FROM ONLY sl_account_entry WHERE account = $account AND time::floor(transaction.date, 1d) < $date GROUP ALL ORDER BY transaction.date DESC
 LIMIT 1);
RETURN IF ($b == NONE) { RETURN 0; } ELSE { RETURN $b.balance; };
} PERMISSIONS FULL;
DEFINE FUNCTION fn::reporting::vendor_statement($std: string, $edt: string, $vendor_id: record<entity>) {
LET $startDate = time::floor(<datetime> $std, 1d);
LET $endDate = time::floor(<datetime> $edt, 1d);
LET $vendor = (SELECT * FROM ONLY $vendor_id);
LET $account = $vendor.account;
RETURN (SELECT *, transaction[*] AS tx FROM sl_account_entry WHERE account = $account AND time::floor(transaction.date, 1d) >= $starDate AND time::floor(transaction.date, 1d) <= $endDate ORDER BY transaction.date DESC
);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::svp::get_critical_svps() {
LET $today = time::floor(time::now(), 1d);
LET $svps_tasks = (SELECT VALUE meta.svp AS svp FROM task WHERE meta.svp != NONE AND $today >= (time::floor(deadline, 1d) - (duration::from::days(last_critical_days))));
LET $svps = (SELECT *, (SELECT *, (SELECT *, transaction[*] FROM item_unit_part WHERE unit = $parent.id) AS parts FROM ONLY $parent.item_unit) AS item_unit, (SELECT *, svd_job[*] FROM ONLY $parent.assigned_job) AS assigned_job, (fn::get_full_svd($parent.svd)) AS svd, profile[*] FROM $svps_tasks);
RETURN $svps;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::svp_reports::focal_person_active_documents_report($fp_id: record<focal_person>) {
LET $docs = (SELECT VALUE id FROM saudi_visas_document WHERE focal_person.id = $fp_id);
RETURN (SELECT VALUE fn::svp_reports::get_document_report(id) FROM $docs);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::svp_reports::get_document_report($svd_id: record<saudi_visas_document>) {
LET $svd = fn::get_full_svd($svd_id);
IF !$svd { THROW 'invalid document'; };
LET $svps = fn::svps::get_all_svps_full_by_document($svd_id);
RETURN { svd: $svd, svps: $svps };
} PERMISSIONS FULL;
DEFINE FUNCTION fn::svps::cancel_svp($svp_id: record<saudi_visa_process>) {
LET $svp = (SELECT * FROM ONLY $svp_id);
IF !$svp { THROW 'visa process does not exists'; };
UPDATE ONLY $svp.assigned_job SET status = 'cancelled';
UPDATE ONLY $svp_id SET status = 'cancelled';
RETURN fn::get_full_svp($svp_id);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::svps::change_profile_status($prof: record<candidate_profile>, $status: string) { RETURN (UPDATE ONLY $prof SET status = $status); } PERMISSIONS FULL;
DEFINE FUNCTION fn::svps::complete_svp($svp_id: record<saudi_visa_process>) {
LET $svp = (SELECT * FROM ONLY $svp_id);
IF !$svp { THROW 'visa process does not exists'; };
LET $pipeline = (SELECT * FROM ONLY $svp.pipeline);
IF ($pipeline.finished == false) { THROW 'pipeline must be finished'; };
UPDATE ONLY $svp_id SET status = 'completed', created_at = time::now();
RETURN fn::get_full_svp($svp_id);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::svps::delete_profile($prof: record<candidate_profile>) {
LET $svp = (SELECT * FROM saudi_visa_process WHERE profile = $prof);
IF (array::len($svp) != 0) { THROW 'can not delete profile, profile has assigned a case'; };
DELETE $prof;
RETURN true;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::svps::delete_svp($svp_id: record<saudi_visa_process>) {
LET $svp = (SELECT * FROM ONLY $svp_id);
IF !$svp { THROW 'visa process does not exists'; };
DELETE $svp.assigned_job;
IF ($svp.pipeline) { DELETE $svp.pipeline; };
DELETE $svp_id;
RETURN true;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::svps::get_all_completed_svps_full() {
LET $svps = (SELECT *, (SELECT *, (SELECT *, transaction[*] FROM item_unit_part WHERE unit = $parent.id) AS parts FROM ONLY $parent.item_unit) AS item_unit, (SELECT *, svd_job[*] FROM ONLY $parent.assigned_job) AS assigned_job, (fn::get_full_svd($parent.svd)) AS svd, profile[*] FROM saudi_visa_process WHERE status = 'completed' ORDER BY completed_at DESC
);
RETURN $svps;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::svps::get_all_completed_uninvoiced_svps_full() {
LET $svps = (SELECT *, (SELECT *, (SELECT *, transaction[*] FROM item_unit_part WHERE unit = $parent.id) AS parts FROM ONLY $parent.item_unit) AS item_unit, (SELECT *, svd_job[*] FROM ONLY $parent.assigned_job) AS assigned_job, (fn::get_full_svd($parent.svd)) AS svd, profile[*] FROM saudi_visa_process WHERE status = 'completed' AND item_unit.invoiced = false ORDER BY created_at DESC
);
RETURN $svps;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::svps::get_all_svps_full() {
LET $svps = (SELECT *, (SELECT *, (SELECT *, transaction[*] FROM item_unit_part WHERE unit = $parent.id) AS parts FROM ONLY $parent.item_unit) AS item_unit, (SELECT *, svd_job[*] FROM ONLY $parent.assigned_job) AS assigned_job, (fn::get_full_svd($parent.svd)) AS svd, profile[*] FROM saudi_visa_process ORDER BY created_at DESC
);
RETURN $svps;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::svps::get_all_svps_full_by_document($svd_id: record<saudi_visas_document>) {
LET $svps = (SELECT *, (SELECT *, (SELECT *, transaction[*] FROM item_unit_part WHERE unit = $parent.id) AS parts FROM ONLY $parent.item_unit) AS item_unit, (SELECT *, svd_job[*] FROM ONLY $parent.assigned_job) AS assigned_job, (fn::get_full_svd($parent.svd)) AS svd, profile[*] FROM saudi_visa_process WHERE status = 'active' AND svd = $svd_id ORDER BY created_at DESC
);
RETURN $svps;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::tasks::add_category($name: string, $desc: string) { RETURN (CREATE ONLY task_category CONTENT { description: $desc, name: $name }); } PERMISSIONS FULL;
DEFINE FUNCTION fn::tasks::add_task($name: string, $desc: string, $category_id: record<task_category>, $deadline: string, $last_critical_days: int, $meta: object) { RETURN (CREATE ONLY task CONTENT { category: $category_id, deadline: <datetime> $deadline, description: $desc, last_critical_days: $last_critical_days, meta: $meta, name: $name }); } PERMISSIONS FULL;
DEFINE FUNCTION fn::tasks::complete_task($task_id: record<task>) {
DELETE $task_id;
RETURN true;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::tasks::get_categories() { RETURN (SELECT * FROM task_category); } PERMISSIONS FULL;
DEFINE FUNCTION fn::tasks::get_tasks() { RETURN (SELECT * FROM task ORDER BY deadline
); } PERMISSIONS FULL;
DEFINE FUNCTION fn::templates::add($name: string, $file_id: string, $vars: object) { RETURN (CREATE ONLY template CONTENT { created_at: fn::utils::now(), file_id: $file_id, name: $name, vars: $vars }); } PERMISSIONS FULL;
DEFINE FUNCTION fn::templates::delete($id: record<template>) {
LET $temp = (SELECT * FROM ONLY $id);
IF (!$temp) { THROW 'invalid request'; };
DELETE $id;
RETURN true;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::tickets::delete_ticket($id: record<ticket>) {
LET $tick = (SELECT * FROM ONLY $id);
IF !$tick { THROW 'invalid request'; };
DELETE $tick;
RETURN true;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::tickets::edit_ticket($id: record<ticket>, $pnr: string, $passengers: array<object>, $sectors: array<object>, $refund: bool) {
LET $tick = (SELECT * FROM ONLY $id);
IF !$tick { THROW 'invalid request'; };
RETURN (UPDATE ONLY $id CONTENT { passengers: $passengers, pnr: $pnr, refunded: $refund, sectors: $sectors });
} PERMISSIONS FULL;
DEFINE FUNCTION fn::tickets::get_all_pending() {
LET $today = time::floor(fn::utils::now(), 1d);
RETURN (SELECT * FROM ticket WHERE array::any(sectors, |$sector: any| time::floor(<datetime> $sector.departure_date, 1d) >= time::floor(fn::utils::now(), 1d)));
} PERMISSIONS FULL;
DEFINE FUNCTION fn::tickets::get_tickets_stats_by_month($month: int, $year: int) { RETURN (SELECT *, time::floor(created_at, 1d) AS date, count() FROM ticket WHERE time::month(created_at) = $month AND time::year(created_at) = $year GROUP BY date); } PERMISSIONS FULL;
DEFINE FUNCTION fn::tickets::get_tickets_stats_by_year($year: int) { RETURN (SELECT *, time::month(created_at) AS month, count() FROM ticket WHERE time::year(created_at) = $year GROUP BY month); } PERMISSIONS FULL;
DEFINE FUNCTION fn::uncomplete_svd($svd_id: record<saudi_visas_document>) {
LET $svd = (SELECT * FROM ONLY $svd_id);
IF (!$svd) { THROW 'invalid request'; };
LET $svd_updated = (UPDATE ONLY $svd_id MERGE { completed: false });
RETURN fn::get_full_svd($svd_updated.id);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::update_entity($entity: record<entity>, $name: string, $address: string, $contacts: array<string>, $status: string, $picture: option<string | null>, $entity_type: option<object | null>) {
IF ($entity_type.to_vendor == true AND $entity_type.to_customer == true) { THROW 'invalid request'; };
LET $var_entity = (SELECT * FROM ONLY $entity);
IF ($status != $var_entity.status) {
IF ($status == 'active') { fn::activate_entity($entity) };
IF ($status == 'inactive') { fn::inactivate_entity($entity) };
};
RETURN (UPDATE ONLY $entity MERGE { address: $address, contacts: $contacts, name: $name, picture: $picture });
} PERMISSIONS FULL;
DEFINE FUNCTION fn::utils::get_gl_account_balance_btw($account: record<gl_account>, $start: string, $end: string) {
LET $start_date = time::floor(<datetime> $start, 1d);
LET $end_date = time::floor(<datetime> $end, 1d);
LET $entries = (SELECT * FROM gl_account_entry WHERE account = $account AND transaction.date >= $star_date AND transaction.date <= $end_date ORDER BY transaction.date
);
LET $amounts = array::map($entries, |$ent: any| $ent.incr - $ent.decr);
LET $total = math::sum($amounts);
RETURN $total;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::utils::now() { RETURN time::now() + 5h; } PERMISSIONS FULL;
DEFINE FUNCTION fn::yearly_payments($y: int) {
LET $recv = (SELECT time::year(transaction.date) AS year, math::sum(incr) AS total FROM sl_account_entry WHERE transaction.type == 'payment_made' AND time::year(transaction.date) == $y GROUP BY year);
LET $paid = (SELECT time::year(transaction.date) AS year, math::sum(incr) AS total FROM sl_account_entry WHERE transaction.type == 'payment_received' AND time::year(transaction.date) == $y GROUP BY year);
LET $recv = (SELECT * FROM ONLY $recv LIMIT 1);
LET $paid = (SELECT * FROM ONLY $paid LIMIT 1);
RETURN { paid: $paid.total?, received: $recv.total };
} PERMISSIONS FULL;
DEFINE FUNCTION fn::yearly_revenue($y: int) { RETURN (SELECT account.name AS account_name, math::sum(incr - decr) AS amount FROM gl_account_entry WHERE account.type = 'income' AND time::year(transaction.date) == $y GROUP BY account_name); } PERMISSIONS FULL;

