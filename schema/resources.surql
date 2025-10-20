-- ------------------------------
-- OPTION
-- ------------------------------

OPTION IMPORT;

-- ------------------------------
-- FUNCTIONS
-- ------------------------------

DEFINE FUNCTION fn::_undo_transaction_accounting_entries($tx: record<transaction>) {
LET $var_gl_account_entries = (SELECT * FROM gl_account_entry WHERE transaction = $tx);
LET $var_sales_account_entries = (SELECT * FROM sales_account_entry WHERE transaction = $tx);
LET $var_purchase_account_entries = (SELECT * FROM purchase_account_entry WHERE transaction = $tx);
FOR $entry IN $var_gl_account_entries {
DELETE $entry;
IF $entry.incr != 0 { UPDATE $entry.account SET balance = balance - $entry.incr; };
IF $entry.decr != 0 { UPDATE $entry.account SET balance = balance + $entry.decr; };
};
FOR $entry IN $var_sales_account_entries {
DELETE $entry;
IF $entry.incr != 0 { UPDATE $entry.account SET balance = balance - $entry.incr; };
IF $entry.decr != 0 { UPDATE $entry.account SET balance = balance + $entry.decr; };
};
FOR $entry IN $var_purchase_account_entries {
DELETE $entry;
IF $entry.incr != 0 { UPDATE $entry.account SET balance = balance - $entry.incr; };
IF $entry.decr != 0 { UPDATE $entry.account SET balance = balance + $entry.decr; };
};
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
LET $tx = (CREATE ONLY transaction CONTENT { created_at: time::now(), date: time::now(), type: 'bank:deposit' });
LET $var_bank_account = (SELECT * FROM ONLY $bank_account);
LET $gl_bank_account = $var_bank_account.asset_account;
LET $gl_cash_account = (SELECT * FROM ONLY gl_account WHERE type = 'asset' AND name = 'Cash' LIMIT 1);
LET $bca = (CREATE ONLY bank_account_deposit CONTENT { account: $bank_account, amount: $amount, description: $desc, reference: $ref, transaction: $tx.id });
CREATE ONLY gl_account_entry CONTENT { account: $gl_cash_account.id, decr: $amount, description: $desc, incr: 0, ref: $ref, transaction: $tx.id };
LET $result = (CREATE ONLY gl_account_entry CONTENT { account: $gl_bank_account.id, decr: 0, description: $desc, incr: $amount, ref: $ref, transaction: $tx.id });
RETURN (SELECT * FROM ONLY $bca.id);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_bank_account_withdrawal($bank_account: record<bank_account>, $amount: int, $ref: string, $desc: string) {
LET $tx = (CREATE ONLY transaction CONTENT { created_at: time::now(), date: time::now(), type: 'bank:withdrawal' });
LET $var_bank_account = (SELECT * FROM ONLY $bank_account);
LET $gl_bank_account = $var_bank_account.asset_account;
LET $gl_cash_account = (SELECT * FROM ONLY gl_account WHERE type = 'asset' AND name = 'Cash' LIMIT 1);
LET $bca = (CREATE ONLY bank_account_withdrawl CONTENT { account: $bank_account, amount: $amount, description: $desc, reference: $ref, transaction: $tx.id });
CREATE ONLY gl_account_entry CONTENT { account: $gl_cash_account.id, decr: 0, description: $desc, incr: $amount, ref: $ref, transaction: $tx.id };
LET $result = (CREATE ONLY gl_account_entry CONTENT { account: $gl_bank_account.id, decr: $amount, description: $desc, incr: 0, ref: $ref, transaction: $tx.id });
RETURN (SELECT * FROM ONLY $bca.id);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_candidate_profile($givenName: string, $surname: string, $fatherGivenName: string, $fatherSurname: string, $placeOfBirth: string, $dateOfBirth: string, $passportNumber: string, $passportIssuePlace: string, $passportIssueDate: string, $passportExpiryDate: string, $meritalStatus: string, $religion: string, $gender: string, $cnic: string, $image: string, $notes: string) {
LET $prof = (CREATE ONLY candidate_profile CONTENT { cnic: $cnic, dob: <datetime> $dateOfBirth, father_given_name: $fatherGivenName, father_surname: $fatherSurname, gender: $gender, given_name: $givenName, merital_status: $meritalStatus, notes: $notes, passport_expiry_date: <datetime> $passportExpiryDate, passport_issue_date: <datetime> $passportIssueDate, passport_issue_place: $passportIssuePlace, passport_number: $passportNumber, picture: $image, place_of_birth: $placeOfBirth, religion: $religion, surname: $surname });
RETURN (SELECT * FROM ONLY $prof);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_capital($amount: int, $method: object, $date: string, $description: string) {
LET $asset_account = IF ($method['method'] == 'bank') { RETURN $method['account']; } ELSE IF ($method['method'] == 'cash') { RETURN (SELECT VALUE id FROM ONLY gl_account WHERE type = 'asset' AND name = 'Cash' LIMIT 1); } ELSE { THROW 'invalid payment method'; };
LET $tx = (CREATE ONLY transaction CONTENT { created_at: time::now(), date: <datetime> $date, type: 'equity:add_capital' });
CREATE ONLY gl_account_entry CONTENT { account: $asset_account, decr: 0, description: $description, incr: $amount, reference: '', transaction: $tx.id };
LET $capital = (SELECT * FROM ONLY gl_account WHERE type = 'equity' AND name = 'OwnerCapital' LIMIT 1);
LET $res = (CREATE ONLY gl_account_entry CONTENT { account: $capital.id, decr: 0, description: $description, incr: $amount, reference: '', transaction: $tx.id });
RETURN (SELECT *, transaction[*] AS tx FROM ONLY $res);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_customer($name: string, $balance: option<int | null>, $address: option<string | null>, $contacts: option<array<string> | null>, $picture: option<string | null>, $balance_as_of: option<string | null>, $is_vendor: bool) {
LET $customer_account = (CREATE ONLY sl_account);
LET $vendor_account = IF ($is_vendor) { RETURN (CREATE ONLY sl_account); };
LET $var_account = (CREATE ONLY sl_account);
LET $var_customer = (CREATE ONLY entity CONTENT { address: $address, contacts: $contacts, customer_account: $customer_account.id, name: $name, picture: $picture, vendor_account: $vendor_account.id });
IF $balance != NULL AND $balance != NONE {
LET $tx = (CREATE ONLY transaction CONTENT { created_at: time::now(), date: <datetime> $balance_as_of, type: 'customer:opening_balance' });
IF $balance < 0 { CREATE ONLY sl_account_entry CONTENT { account: $customer_account.id, decr: $balance, description: 'opening balance', incr: 0, reference: '', transaction: $tx.id }; } ELSE { CREATE ONLY sl_account_entry CONTENT { account: $customer_account.id, decr: 0, description: 'opening balance', incr: $balance, reference: '', transaction: $tx.id }; };
};
RETURN (SELECT * FROM ONLY $var_customer);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_drawing($amount: int, $method: object, $date: string, $description: string) {
LET $asset_account = IF ($method['method'] == 'bank') { RETURN $method['account']; } ELSE IF ($method['method'] == 'cash') { RETURN (SELECT VALUE id FROM ONLY gl_account WHERE type = 'asset' AND name = 'Cash' LIMIT 1); } ELSE { THROW 'invalid payment method'; };
LET $tx = (CREATE ONLY transaction CONTENT { created_at: time::now(), date: <datetime> $date, type: 'equity:add_drawing' });
CREATE ONLY gl_account_entry CONTENT { account: $asset_account, decr: $amount, description: $description, incr: 0, reference: '', transaction: $tx.id };
LET $drawing = (SELECT * FROM ONLY gl_account WHERE type = 'equity' AND name = 'OwnerDraw' LIMIT 1);
LET $res = (CREATE ONLY gl_account_entry CONTENT { account: $drawing.id, decr: 0, description: $description, id: [$tx.date, $tx.created_at, rand::ulid()], incr: $amount, reference: '', transaction: $tx.id });
RETURN (SELECT *, transaction[*] AS tx FROM ONLY $res);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_expense($account: record<gl_account>, $amount: int, $method: object, $description: string, $ref: string, $date: string) {
LET $tx = (CREATE ONLY transaction CONTENT { created_at: time::now(), date: <datetime> $date, type: 'expense:add' });
LET $asset_account = IF ($method['method'] == 'bank') THEN $method['account'] ELSE (SELECT VALUE id FROM ONLY gl_account WHERE type = 'asset' AND name = 'Cash' LIMIT 1) END;
CREATE gl_account_entry CONTENT { account: $asset_account, decr: $amount, description: $description, incr: 0, reference: $ref, transaction: $tx.id };
UPDATE $asset_account SET balance = balance - $amount;
LET $res = (CREATE ONLY gl_account_entry CONTENT { account: $account, decr: 0, description: $description, incr: $amount, referene: $ref, transaction: $tx.id });
UPDATE $account SET balance = balance + $amount;
RETURN (SELECT *, transaction[*] AS tx FROM ONLY $res);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_expense_account($name: string, $parent: record<gl_account>) {
LET $var_acc = (CREATE ONLY gl_account CONTENT { name: $name, type: 'expense' });
LET $var_acc_id = $var_acc.id;
RELATE $var_acc_id -> gl_subaccount_of -> $parent;
RETURN (SELECT *, $parent AS parent FROM ONLY $var_acc_id);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_focal_person($name: string, $addr: string, $contacts: string) {
LET $fp = (CREATE ONLY focal_person CONTENT { address: $addr, contacts: $contacts, name: $name });
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
DEFINE FUNCTION fn::add_invoice($customer: record<entity>, $date: string, $items: array<object>, $invoice_no: int, $inv_desc: option<string>) {
LET $var_tx = (CREATE ONLY transaction CONTENT { created_at: time::now(), date: <datetime> $date, type: 'customer:sales_on_credit' });
LET $var_invoice = (CREATE ONLY invoice CONTENT { customer: $customer, date: <datetime> $date, invoice_no: $invoice_no, line_items: [], transaction: $var_tx.id });
FOR $item IN $items {
LET $lt = fn::handle_invoice_line_items($item, $var_tx.id, $customer, $var_invoice);
UPDATE $var_invoice.id SET line_items = array::append(line_items, $lt.id);
};
RETURN (SELECT *, line_items[*][*] FROM ONLY $var_invoice.id);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_item($name: string, $purchase_description: string, $sale_description: string, $purchased: bool) {
LET $asset_account = (CREATE ONLY gl_account CONTENT { name: rand::ulid(), type: 'asset' });
LET $income_account = (CREATE ONLY gl_account CONTENT { name: rand::ulid(), type: 'income' });
LET $contra_income_account = (CREATE ONLY gl_account CONTENT { name: rand::ulid(), type: 'contra_income' });
LET $expense_account = (CREATE ONLY gl_account CONTENT { name: rand::ulid(), type: 'expense' });
LET $contra_expense_account = (CREATE ONLY gl_account CONTENT { name: rand::ulid(), type: 'contra_expense' });
RETURN (CREATE ONLY item CONTENT { asset_account: $asset_account.id, cogs_account: $expense_account.id, contra_cogs_account: $contra_expense_account.id, contra_income_account: $contra_income_account.id, income_account: $income_account.id, name: $name, purchase_description: $purchase_description, purchased: $purchased, sale_description: $sale_description });
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_item_unit($item_id: record<item>, $name: string, $description: string, $date: string, $parts: array<object>) {
LET $item = (SELECT * FROM ONLY $item_id);
IF ($item.name == 'svp' OR $item.name == 'tickets') { THROW 'can not add units to ' + $item.name; };
LET $var_tx = (CREATE ONLY transaction CONTENT { created_at: time::now(), date: <datetime> $date, type: 'vp:add_item' });
LET $unit = (CREATE ONLY item_unit CONTENT { date: <datetime> $date, description: $description, item: $item.id, name: $name });
FOR $obj IN $parts { fn::add_item_unit_part($unit.id, $obj.name, $obj.description, $obj.cost, $date, $obj.payment_method) };
RETURN (SELECT *, (SELECT * FROM item_unit_part WHERE unit = $parent.id) AS parts FROM ONLY $unit.id);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_item_unit_part($unit: record<item_unit>, $name: string, $description: string, $cost: int, $date: string, $payment_method: object) {
LET $unit = (SELECT * FROM ONLY $unit);
LET $item = (SELECT * FROM ONLY $unit.item);
IF ($unit.invoiced) { THROW 'can not add part, because unit is already sold'; };
LET $var_tx = (CREATE ONLY transaction CONTENT { created_at: time::now(), date: <datetime> $date, type: 'vp:add_unit_part' });
LET $part = (CREATE ONLY item_unit_part CONTENT { cost: $cost, description: $description, name: $name, payment_method: $payment_method, transaction: $var_tx.id, unit: $unit.id });
LET $asset_account = IF ($payment_method['method'] == 'bank') { RETURN $payment_method['account']; } ELSE IF ($payment_method['method'] == 'cash') { RETURN (SELECT VALUE id FROM ONLY gl_account WHERE type = 'asset' AND name = 'Cash' LIMIT 1); } ELSE IF ($payment_method['vendor']) { RETURN NULL; } ELSE { THROW 'invalid payment method'; };
CREATE ONLY gl_account_entry CONTENT { account: $item.asset_account, decr: 0, description: $description, incr: $cost, reference: $unit.name, transaction: $var_tx.id };
IF ($payment_method['vendor']) {
LET $var_vendor = (SELECT * FROM ONLY $payment_method['vendor']);
CREATE ONLY sl_account_entry CONTENT { account: $var_vendor.vendor_account, decr: 0, description: $description, incr: $cost, reference: $name, transaction: $var_tx.id };
} ELSE IF ($asset_account != NULL AND $asset_account != NONE) { CREATE ONLY gl_account_entry CONTENT { account: $asset_account, decr: $cost, description: $description, incr: 0, reference: $unit.name, transaction: $var_tx.id }; } ELSE { THROW 'account or vendor must be selected'; };
RETURN (SELECT * FROM ONLY $part);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_payment_receipt($customer: record<entity>, $method: object, $amount: int, $reference: string, $discount: int, $date: string, $receipt_no: int, $description: string) {
IF ($amount < 0) { THROW 'Amount must not be negative'; };
IF ($discount < 0) { THROW 'Discount must not be negative'; };
LET $tx = (CREATE ONLY transaction CONTENT { created_at: time::now(), date: <datetime> $date, type: 'customer:payment_received_from' });
IF $amount == 0 AND $discount == 0 { THROW 'amount or discount must be given'; };
LET $var_customer = (SELECT * FROM ONLY $customer);
LET $asset_account = IF ($method['method'] == 'bank') { RETURN $method['account']; } ELSE IF ($method['method'] == 'cash') { RETURN (SELECT VALUE id FROM ONLY gl_account WHERE type = 'asset' AND name = 'Cash' LIMIT 1); } ELSE { THROW 'invalid payment method'; };
LET $var_pr = (CREATE ONLY payment_receipt CONTENT { amount: $amount, customer: $customer, date: <datetime> $date, description: $description, discount: $discount, method: { account: $asset_account, method: $method['method'] }, receipt_no: $receipt_no, reference: $reference, transaction: $tx.id, tx: $tx });
IF ($amount != 0) { CREATE ONLY gl_account_entry CONTENT { account: $asset_account, decr: 0, description: 'payment received', incr: $amount, reference: 'payment receipt: ' + type::string($var_pr.receipt_no), transaction: $tx.id }; };
LET $account = $var_customer.customer_account;
CREATE ONLY sl_account_entry CONTENT { account: $account, decr: $amount + $discount, description: 'payment received', incr: 0, reference: type::string($var_pr.receipt_no), transaction: $tx.id };
IF ($discount != 0) {
LET $sales_discount_account = (SELECT * FROM ONLY gl_account WHERE type = 'contra_income' AND name = 'SalesDiscount' LIMIT 1);
CREATE ONLY gl_account_entry CONTENT { account: $sales_discount_account.id, decr: 0, description: 'payment received with discount', incr: $discount, reference: type::string($var_pr.receipt_no), transaction: $tx.id };
};
RETURN (SELECT * FROM ONLY $var_pr);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_payment_voucher($pvc_no: int, $vendor: record<entity>, $method: object, $amount: int, $discount: int, $reference: string, $desc: string, $date: string, $attachment: option<string | null>) {
IF ($amount < 0) { THROW 'Amount must not be negative'; };
IF ($discount < 0) { THROW 'Discount must not be negative'; };
LET $tx = (CREATE ONLY transaction CONTENT { created_at: time::now(), date: <datetime> $date, type: 'vendor:payment_received_to' });
LET $var_vendor = (SELECT * FROM ONLY $vendor);
LET $asset_account = IF ($method['method'] == 'bank') { RETURN $method['account']; } ELSE IF ($method['method'] == 'cash') { RETURN (SELECT VALUE id FROM ONLY gl_account WHERE type = 'asset' AND name = 'Cash' LIMIT 1); } ELSE { THROW 'invalid payment method'; };
LET $var_pvc = (CREATE ONLY payment_voucher CONTENT { amount: $amount, attachment: $attachment, description: $desc, discount: $discount, method: { account: $asset_account, method: $method['method'] }, reference: $reference, transaction: $tx.id, vendor: $vendor, voucher_no: $pvc_no });
IF ($amount != 0) { CREATE ONLY gl_account_entry CONTENT { account: $asset_account, decr: $amount, description: $desc, incr: 0, reference: 'payment voucher: ' + type::string($var_pvc.voucher_no), transaction: $tx.id }; };
LET $account = $var_vendor.vendor_account;
CREATE ONLY sl_account_entry CONTENT { account: $account, decr: $amount + $discount, description: $desc, incr: 0, reference: 'payment voucher: ' + type::string($var_pvc.voucher_no), transaction: $tx.id };
IF ($discount != 0) {
LET $purchase_discount_account = (SELECT * FROM ONLY gl_account WHERE type = 'contra_expense' AND name = 'PurchaseDiscount' LIMIT 1);
CREATE ONLY gl_account_entry CONTENT { account: $purchase_discount_account.id, decr: 0, description: 'payment voucher with discount', incr: $discount, reference: type::string($var_pvc.voucher_no), transaction: $tx.id };
};
RETURN (SELECT * FROM ONLY $var_pvc);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_pipeline_template($name: string, $stages: array<object>) {
LET $template = (CREATE ONLY pipeline_template CONTENT { name: $name });
FOR $obj IN $stages { CREATE pipeline_template_stage CONTENT { description: $obj.description, name: $obj.name, order: $obj.index, tasks: $obj.tasks, template: $template.id }; };
RETURN fn::pipelines::get_template_full($template.id);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_sales_return($customer: record, $date: string, $items: array<object>, $sr_no: int, $reference: string, $description: string) {
LET $tx = (CREATE ONLY transaction CONTENT { created_at: time::now(), date: <datetime> $date, type: 'customer:sales_return' });
LET $sr_total = fn::calc_sr_total($items) ?? 0;
LET $var_sr = (CREATE ONLY sales_return CONTENT { amount: $sr_total, customer: $customer, date: <datetime> $date, description: $description, items: [], reference: $reference, sales_return_no: $sr_no, transaction: $tx.id });
FOR $item IN $items { fn::handle_add_sr_item($tx, $customer, $item, { date: $date, description: $description, reference: $reference, sr_no: $sr_no }) };
RETURN (SELECT * FROM ONLY $var_sr.id);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_sv_document($document_no: string, $sponsor_id: string, $sponsor_name: string, $sponsor_name_arabic: string, $sponsor_address: string, $focal_person: record<focal_person>, $jobs: array<object>) {
LET $doc = (CREATE ONLY saudi_visas_document CONTENT { document_number: $document_no, focal_person: $focal_person, sponsor_address: $sponsor_address, sponsor_id: $sponsor_id, sponsor_name_arabic: $sponsor_name_arabic, sponsor_name_english: $sponsor_name });
FOR $obj IN $jobs { CREATE ONLY svd_job CONTENT { embassy: $obj.embassy, job: (SELECT * FROM ONLY $obj.job_id), jobs_count: $obj.jobs_count, svd: $doc.id }; };
RETURN fn::get_full_svd($doc.id);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_svd_job($svd: record<saudi_visas_document>, $saudi_job: record<saudi_job>, $jobs_count: int, $embassy: string) {
CREATE ONLY svd_job CONTENT { embassy: $embassy, job: (SELECT * FROM ONLY $saudi_job), jobs_count: $jobs_count, svd: $svd };
RETURN fn::get_full_svd($svd);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_svp($profile_id: record<candidate_profile>, $svd: record<saudi_visas_document>, $svd_job_id: record<svd_job>, $pipeline_template_id: record<pipeline_template>) {
LET $svd_job = (SELECT * FROM ONLY $svd_job_id);
LET $svp_assigned_jobs = (SELECT * FROM svp_assigned_job WHERE svd = $svd AND svd_job = $svd_job.id);
IF ($svp_assigned_jobs == NULL OR array::len($svp_assigned_jobs) == $svd_job.jobs_count) { THROW 'no available jobs'; };
LET $case = (SELECT * FROM saudi_visa_process WHERE profile = $profile_id);
IF $case { THROW 'There is already a case for this profile'; };
LET $svp_assign_job = (CREATE ONLY svp_assigned_job CONTENT { svd: $svd, svd_job: $svd_job.id });
LET $profile = (SELECT * FROM ONLY $profile_id);
LET $item = (SELECT * FROM ONLY item WHERE name == 'svp' LIMIT 1);
LET $unit = fn::svps::add_svp_item_unit($item.id, 'visa process for ' + $profile.passport_number, 'visa process for ' + $profile.passport_number, type::string(time::now()), []);
LET $pipeline = fn::pipelines::create_pipeline($pipeline_template_id);
IF (!$pipeline) { THROW 'error while creating pipeline'; };
LET $process = (CREATE ONLY saudi_visa_process CONTENT { assigned_job: $svp_assign_job.id, item_unit: $unit.id, pipeline: $pipeline.id, profile: $profile.id, svd: $svd });
RETURN (SELECT * FROM ONLY $process);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::add_ticket($name: string, $airline: string, $pnr: string, $sector: string, $departure_date: string, $arrival_date: string, $invoice: option<object>) { RETURN (CREATE ONLY ticket CONTENT { airline: $airline, arrival_date: <datetime> $arrival_date, departure_date: <datetime> $departure_date, invoice: $invoice, name: $name, pnr: $pnr, refunded: false, sector: $sector }); } PERMISSIONS FULL;
DEFINE FUNCTION fn::add_vendor($name: string, $address: option<string | null>, $contacts: option<array<string> | null>, $picture: option<string | null>, $balance: option<int | null>, $balance_as_of: option<string | null>, $is_customer: bool) {
LET $vendor_account = (CREATE ONLY sl_account);
LET $customer_account = IF ($is_customer) { RETURN (CREATE ONLY sl_account); };
LET $var_vendor = (CREATE ONLY entity CONTENT { account: $var_account.id, address: $address ?? '', contacts: $contacts ?? [], customer_account: $customer_account.id, name: $name, picture: $picture, vendor_account: $vendor_account.id });
IF $balance != NULL {
LET $tx = (CREATE ONLY transaction CONTENT { created_at: time::now(), date: <datetime> $balance_as_of, type: 'vendor:opening_balance' });
IF $balance < 0 { CREATE ONLY sl_account_entry CONTENT { account: $vendor_account.id, decr: $balance, description: 'opening balance', incr: 0, reference: '', transaction: $tx.id }; } ELSE { CREATE ONLY sl_account_entry CONTENT { account: $vendor_account.id, decr: 0, description: 'opening balance', incr: $balance, reference: '', transaction: $tx.id }; };
};
RETURN (SELECT * FROM ONLY $var_vendor);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::business::update_business($id: record<business>, $description: option<string | null>, $logo: option<string | null>, $contacts: option<array<string> | null>, $address: option<string | null>) { RETURN (UPDATE ONLY $id MERGE { address: $address ?? address, contact: $contacts ?? contacts, description: $description ?? description, logo: $logo ?? logo }); } PERMISSIONS FULL;
DEFINE FUNCTION fn::calc_invoice_total($line_items: array<object>) {
LET $vals = array::map($line_items, |$a: any| $a.amount);
RETURN (SELECT * FROM ONLY array::fold($vals, 0, |$prev: any, $next: any| $prev + ($next ?? 0)));
} PERMISSIONS FULL;
DEFINE FUNCTION fn::calc_sr_total($items: array<object>) {
LET $vals = array::map($items, |$a: any| $a.amount);
RETURN (SELECT * FROM ONLY array::reduce($vals, |$a: any, $b: any| $a + $b));
} PERMISSIONS FULL;
DEFINE FUNCTION fn::complete_pipeline_stage($pipeline: record<pipeline>, $stage: int, $date: string, $remarks: string) {
LET $var_pipeline = (SELECT * FROM ONLY $pipeline);
LET $var_stages = $var_pipeline.stages;
LET $var_stage = array::at($var_stages, $stage);
LET $new_updated_stage = { completed_at: time::now(), completion_date: <datetime> $date, description: $var_stage.description, name: $var_stage.name, remarks: $remarks, status: 'completed' };
LET $new_stages = array::remove($var_stages, $stage);
LET $new_stages = array::insert($new_stages, $new_updated_stage, $stage);
LET $next_stage = $stage + 1;
LET $last_stage = array::len($var_stages);
LET $new_stages = IF $next_stage <= $last_stage {
LET $var_next_stage = array::at($var_stages, $next_stage);
LET $new_updated_next_stage = { description: $var_next_stage.description, name: $var_next_stage.name, status: 'active' };
LET $new_next_stages = array::remove($new_stages, $next_stage);
LET $new_next_stages = array::insert($new_next_stages, $new_updated_next_stage, $next_stage);
RETURN $new_next_stages;
};
RETURN (UPDATE ONLY $pipeline SET stages = $new_stages);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::create_transaction($type: string, $date: option<string | null>) { RETURN (CREATE ONLY transaction CONTENT { created_at: time::now(), date: <datetime> $date ?? time::now(), type: $type }); } PERMISSIONS FULL;
DEFINE FUNCTION fn::daily_payments($d: string) {
LET $dt = <datetime> $d;
LET $recv = (SELECT transaction.date AS date, math::sum(amount) AS total FROM payment_receipt WHERE time::year(transaction.date) == time::year($dt) AND time::month(transaction.date) == time::month($dt) AND time::day(transaction.date) == time::day($dt) GROUP BY transaction.date);
LET $paid = (SELECT transaction.date AS date, math::sum(amount) AS total FROM payment_voucher WHERE time::year(transaction.date) == time::year($dt) AND time::month(transaction.date) == time::month($dt) AND time::day(transaction.date) == time::day($dt) GROUP BY transaction.date);
LET $recv = (SELECT * FROM ONLY $recv LIMIT 1);
LET $paid = (SELECT * FROM ONLY $paid LIMIT 1);
RETURN { paid: $paid.total ?? 0, received: $recv.total ?? 0 };
} PERMISSIONS FULL;
DEFINE FUNCTION fn::daily_revenue($date: string) {
LET $dt = <datetime> $date;
RETURN (SELECT account.name AS account_name, math::sum(incr - decr) AS amount FROM gl_account_entry WHERE account.type = 'income' AND time::year(transaction.date) == time::year($dt) AND time::month(transaction.date) == time::month($dt) AND time::day(transaction.date) == time::day($dt) GROUP BY account_name);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::delete_invoice($invoice_id: record<invoice>) {
LET $invoice = (SELECT * FROM ONLY $invoice_id);
FOR $lt IN $invoice.line_items { DELETE $lt; };
DELETE sl_account_entry WHERE transaction = $invoice.transaction;
DELETE gl_account_entry WHERE transaction = $invoice.transaction;
DELETE $invoice.id;
RETURN $invoice.id;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::delete_item($item_id: record<item>) {
LET $item = (SELECT *, asset_account[*], income_account[*], contra_income_account[*], cogs_account[*], contra_cogs_account[*] FROM ONLY $item_id);
IF ($item.name == 'svp' OR $item.name == 'tickets') { THROW 'can not delete ' + $item.name; };
IF ($item.asset_account.balance != 0 OR $item.income_account.balance != 0 OR $item.contra_income_account.balance != 0 OR $item.cogs_account.balance != 0 OR $item.contra_cogs_account.balance != 0) { THROW 'item with transactions can not be deleted'; };
DELETE $item_id;
RETURN true;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::delete_payment_receipt($pr_id: record<payment_receipt>) {
LET $pr = (SELECT * FROM ONLY $pr_id);
DELETE sl_account_entry WHERE transaction = $pr.transaction;
DELETE gl_account_entry WHERE transaction = $pr.transaction;
DELETE $pr.id;
RETURN $pr.id;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::delete_transaction($tx: record<transaction>) {
fn::_undo_transaction_accounting_entries($tx);
IF ($tx.type == 'customer:sales_on_credit') {
LET $var_invoice = (SELECT * FROM ONLY invoice WHERE transaction = $tx LIMIT 1);
FOR $itm IN $var_invoice.items { DELETE $itm._reference; };
DELETE $var_invoice.id;
} ELSE IF ($tx.type == 'customer:sales_return') {
LET $var_sr = (SELECT * FROM ONLY sales_return WHERE transaction = $tx LIMIT 1);
DELETE $var_sr;
} ELSE IF ($tx.type == 'customer:payment_received_from') {
LET $var_receipt = (SELECT * FROM ONLY payment_receipt WHERE transaction = $tx LIMIT 1);
DELETE $var_receipt;
} ELSE IF ($tx.type = 'vendor:payment_received_to') {
LET $var_pvoucher = (SELECT * FROM ONLY payment_voucher WHERE transaction = $tx LIMIT 1);
DELETE $var_pvoucher;
} ELSE IF ($tx.type == 'customer:opening_balance' OR $tx.type == 'vendor:opening_balance') { THROW 'can not delete opening balance'; };
DELETE $tx;
RETURN true;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::edit_item($item: record<item>, $sales_desc: string, $purc_desc: string) {
UPDATE $item MERGE { purchase_description: $purc_desc, sale_description: $sales_desc };
RETURN (SELECT * FROM ONLY $item);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::files::rename_file($file: record<file>, $name: string) {
IF (string::len($name) == 0) { THROW 'name is required'; };
IF (string::matches('[<>:"/\\|?*]', $name)) { THROW 'invalid name, name should not contain special characters.'; };
RETURN (UPDATE ONLY $file SET name = $name);
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
DEFINE FUNCTION fn::handle_add_sr_item($tx: object, $customer_id: record<customer>, $obj: object, $args: object) {
LET $item = (SELECT * FROM ONLY $obj.item);
LET $customer = (SELECT * FROM ONLY $customer_id);
CREATE ONLY sl_account_entry CONTENT { account: $customer.account, decr: $obj.to_customer.price * $obj.to_customer.quantity, description: $obj.to_customer.description, incr: 0, reference: type::string($args.sr_no), transaction: $tx.id };
IF $item.purchased {
LET $vendor = (SELECT * FROM ONLY $obj.vendor);
CREATE ONLY sl_account_entry CONTENT { account: $vendor.account, decr: $obj.from_vendor.price * $obj.from_vendor.quantity, description: $obj.from_vendor.description, incr: 0, reference: type::string($args.sr_no), transaction: $tx.id };
CREATE ONLY gl_account_entry CONTENT { account: $item.cogs_account, decr: $obj.from_vendor.price * $obj.from_vendor.quantity, description: $obj.from_vendor.description, incr: 0, reference: type::string($args.sr_no), transaction: $tx.id };
};
CREATE ONLY gl_account_entry CONTENT { account: $item.income_account, decr: $obj.to_customer.price * $obj.to_customer.quantity, description: $obj.from_vendor.description, incr: 0, reference: type::string($args.sr_no), transaction: $tx.id };
IF ($item.name == 'tickets') {
LET $ticket = (SELECT * FROM ONLY $obj.extra.ticket);
IF ($ticket.refunded) { THROW 'ticket already refunded'; };
UPDATE $ticket.id SET refunded = true;
};
} PERMISSIONS FULL;
DEFINE FUNCTION fn::handle_invoice_item_if_purchased($obj: object, $tx: record<transaction>, $args: object) {
LET $pd = $obj.purchase_details;
LET $vendor = (SELECT * FROM ONLY $pd.vendor);
LET $vendor_account = $vendor.vendor_account;
LET $item = (SELECT * FROM ONLY $obj.item);
CREATE ONLY sl_account_entry CONTENT { account: $vendor_account, decr: 0, description: $pd.description, incr: $pd.price * $pd.quantity, reference: $pd.reference ?? 'think in sur', transaction: $tx };
LET $cogs = ($pd.price * $pd.quantity);
CREATE gl_account_entry CONTENT { account: $item.cogs_account, decr: 0, description: $item.purchase_description, incr: $cogs, reference: 'invoice' + type::string($args.invoice.invoice_no), transaction: $tx };
} PERMISSIONS FULL;
DEFINE FUNCTION fn::handle_invoice_item_if_unit($obj: object, $tx: record<transaction>, $args: object) {
LET $unit = (SELECT * FROM ONLY $obj.assets_details.unit);
LET $parts = (SELECT * FROM item_unit_part WHERE unit == $unit.id);
LET $item = (SELECT * FROM ONLY $obj.item);
IF (!$unit) { THROW 'invalid item unit'; };
IF ($unit.invoiced) { THROW $unit.name + ' already invoiced'; };
LET $total_cost = array::fold($parts, 0, |$prev: any, $part: any| $prev + ($part.cost ?? 0));
CREATE ONLY gl_account_entry CONTENT { account: $item.asset_account, decr: $total_cost, description: $unit.description, incr: 0, reference: 'invoice: ' + type::string($args.invoice.invoice_no), transaction: $tx };
CREATE ONLY gl_account_entry CONTENT { account: $item.cogs_account, decr: 0, description: $unit.description, incr: $total_cost, reference: 'invoice: ' + type::string($args.invoice.invoice_no), transaction: $tx };
UPDATE $unit.id MERGE { invoice: $args.invoice.id, invoiced: true };
} PERMISSIONS FULL;
DEFINE FUNCTION fn::handle_invoice_line_items($obj: object, $tx: record<transaction>, $customer_id: record<entity>, $invoice: object) {
LET $customer = (SELECT * FROM ONLY $customer_id);
LET $var_customer_account = $customer.customer_account;
LET $sd = $obj.sales_details;
CREATE ONLY sl_account_entry CONTENT { account: $var_customer_account, decr: 0, description: $sd.description, incr: $sd.price * $sd.quantity, reference: type::string($invoice.invoice_no), transaction: $tx };
LET $item = (SELECT * FROM ONLY $obj.item);
LET $sd = $obj.sales_details;
LET $line_item = (CREATE ONLY line_item CONTENT { amount: $sd.quantity * $sd.price, description: $sd.description, discount: $sd.discount ?? 0, item: $item.id, price: $sd.price, quantity: $sd.quantity });
IF ($item.name == 'tickets') {
LET $ticket = $obj.extra.ticket;
LET $pdetails = $obj.purchase_details;
LET $vendor = (SELECT * FROM ONLY $pdetails.vendor);
fn::add_ticket($ticket.name, $ticket.airline, $ticket.pnr, $ticket.sector, $ticket.departure_date, $ticket.arrival_date, { cost: $pdetails.amount, customer: $customer, invoice_id: $invoice.id, price: $line_item.amount, vendor: $vendor });
};
IF ($item.purchased == true AND ($obj.assets_details == NULL OR $obj.assets_details == NONE)) { fn::handle_invoice_item_if_purchased($obj, $tx, { invoice: $invoice }) };
IF ($obj.assets_details != NULL AND $obj.assets_details != NONE) { fn::handle_invoice_item_if_unit($obj, $tx, { invoice: $invoice }) };
CREATE gl_account_entry CONTENT { account: $item.income_account, decr: 0, description: $item.description, incr: $line_item.amount, reference: 'invoice: ' + type::string($invoice.invoice_no), transaction: $tx };
IF ($obj.discount > 0) { CREATE gl_account_entry CONTENT { account: $item.contra_income_account, decr: 0, description: 'discount 1', incr: $obj.discount, reference: '', transaction: $tx }; };
IF ($item.purchased AND $obj.purchase_details.discount > 0) { CREATE gl_account_entry CONTENT { account: $item.contra_cogs_account, decr: 0, description: 'discount 2', incr: $obj.purchase_details.discount, reference: '', transaction: $tx }; };
RETURN $line_item;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::inactivate_entity($entity: record<entity>) {
LET $var_entity = (SELECT * FROM ONLY $entity);
LET $customer_acc = (SELECT * FROM ONLY $var_entity.customer_account);
LET $vendor_acc = (SELECT * FROM ONLY $var_entity.vendor_account);
IF (!$customer_acc AND !$vendor_acc) { THROW 'invalid entity'; };
IF ($customer_acc AND $customer_acc.balance != 0) { THROW 'can not inactivate entity with balance'; } ELSE IF ($vendor_acc AND $vendor_acc.balance != 0) { THROW 'can not inactivate entity with balance'; };
RETURN (UPDATE ONLY $entity SET status = 'inactive');
} PERMISSIONS FULL;
DEFINE FUNCTION fn::monthly_payments($m: string) {
LET $dt = <datetime> $m;
LET $recv = (SELECT transaction.date AS date, math::sum(amount) AS total FROM payment_receipt WHERE time::year(transaction.date) == time::year($dt) AND time::month(transaction.date) == time::month($dt) GROUP BY transaction.date);
LET $paid = (SELECT transaction.date AS date, math::sum(amount) AS total FROM payment_voucher WHERE time::year(transaction.date) == time::year($dt) AND time::month(transaction.date) == time::month($dt) GROUP BY transaction.date);
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
DEFINE FUNCTION fn::next_invoice_no() { RETURN (SELECT * FROM count((SELECT * FROM invoice)))[0] + 1; } PERMISSIONS FULL;
DEFINE FUNCTION fn::next_payment_receipt_no() { RETURN (SELECT * FROM count((SELECT * FROM payment_receipt)))[0] + 1; } PERMISSIONS FULL;
DEFINE FUNCTION fn::next_payment_voucher_no() { RETURN (SELECT * FROM count((SELECT * FROM payment_voucher)))[0] + 1; } PERMISSIONS FULL;
DEFINE FUNCTION fn::next_sr_no() { RETURN (SELECT * FROM count((SELECT * FROM sales_return)))[0] + 1; } PERMISSIONS FULL;
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
IF ($stage.order == $total_stages - 1) { UPDATE ONLY $stage.pipeline MERGE { finished: true }; } ELSE IF ($stage.order < $total_stages - 1) {
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
) AS stages, fn::pipelines::get_pipeline_stage_full(current_stage) AS current_stage FROM ONLY $id); } PERMISSIONS FULL;
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
DEFINE FUNCTION fn::refund_ticket($ticket_id: record<ticket>, $refund_from_vendor: int, $refund_to_customer: int) {
LET $ticket = (SELECT * FROM ONLY $ticket_id);
IF ($ticket == NULL OR $ticket == NONE) { THROW 'invalid ticket'; };
IF ($ticket.invoice == NULL OR $ticket.invoice == NONE) { THROW 'the ticket is not invoiced'; };
LET $item = (SELECT * FROM ONLY item WHERE name = 'tickets' LIMIT 1);
LET $tx = (CREATE ONLY transaction CONTENT { created_at: time::now(), date: time::now(), type: 'ticket::refund' });
CREATE ONLY sl_account_entry CONTENT { account: $ticket.invoice.vendor.vendor_account, decr: $refund_from_vendor, description: 'ticket refund', incr: 0, reference: 'think in sur', transaction: $tx.id };
CREATE ONLY sl_account_entry CONTENT { account: $ticket.invoice.customer.customer_account, decr: $refund_to_customer, description: 'ticket refund', incr: 0, reference: 'think in sur', transaction: $tx.id };
CREATE ONLY gl_account_entry CONTENT { account: $item.income_account, decr: $refund_to_customer, description: 'ticket refund', incr: 0, reference: 'think in sur', transaction: $tx.id };
CREATE ONLY gl_account_entry CONTENT { account: $item.cogs_account, decr: $refund_from_vendor, description: 'ticket refund', incr: 0, reference: 'think in sur', transaction: $tx.id };
UPDATE $ticket.id SET refunded = true;
RETURN (SELECT * FROM ONLY $ticket.id);
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
LET $balances = (SELECT asset_account.balance AS balance FROM item);
LET $units_total = array::fold($balances, 0, |$prev: any, $a: any| $prev + $a.balance);
LET $bank_balances = (SELECT asset_account.balance AS balance FROM bank_account);
LET $banks_total = array::fold($bank_balances, 0, |$prev: any, $a: any| $prev + $a.balance);
LET $cash = (SELECT VALUE balance FROM ONLY gl_account WHERE name = 'Cash' LIMIT 1);
LET $recievable_balances = (SELECT customer_account.balance AS balance FROM entity WHERE customer_account != NULL);
LET $receivable = array::fold($recievable_balances, 0, |$prev: any, $a: any| $prev + $a.balance);
LET $payable_balances = (SELECT vendor_account.balance AS balance FROM entity WHERE vendor_account != NULL);
LET $payable = array::fold($payable_balances, 0, |$prev: any, $a: any| $prev + $a.balance);
RETURN { assets: { banks: $banks_total, cash: $cash, items_units: $units_total, receivable: $receivable, total: $assets_total + $receivable }, liabilities: { payable: $payable, total: $payable } };
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
LET $account = $customer.customer_account;
RETURN (SELECT *, transaction[*] AS tx FROM sl_account_entry WHERE account = $account AND transaction.date >= $starDate AND transaction.date <= $endDate ORDER BY transaction.date
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
DEFINE FUNCTION fn::reporting::payable_statement() { RETURN (SELECT *, vendor_account.balance AS balance FROM entity WHERE status == 'active' AND vendor_account != NULL); } PERMISSIONS FULL;
DEFINE FUNCTION fn::reporting::receivable_statement() { RETURN (SELECT *, customer_account.balance AS balance FROM entity WHERE status == 'active' AND customer_account != NULL); } PERMISSIONS FULL;
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
LET $account = $vendor.vendor_account;
RETURN (SELECT *, transaction[*] AS tx FROM sl_account_entry WHERE account = $account AND transaction.date >= $starDate AND transaction.date <= $endDate ORDER BY transaction.date
);
} PERMISSIONS FULL;
DEFINE FUNCTION fn::svd_available_jobs($svd: record<saudi_visas_documents>) {} PERMISSIONS FULL;
DEFINE FUNCTION fn::svd_total_jobs($svd: record<saudi_visas_documents>) {} PERMISSIONS FULL;
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
DEFINE FUNCTION fn::svps::add_svp_item_unit($item_id: record<item>, $name: string, $description: string, $date: string, $parts: array<object>) {
LET $item = (SELECT * FROM ONLY $item_id);
LET $var_tx = (CREATE ONLY transaction CONTENT { created_at: time::now(), date: <datetime> $date, type: 'vp:add_item' });
LET $unit = (CREATE ONLY item_unit CONTENT { date: <datetime> $date, description: $description, item: $item.id, name: $name });
FOR $obj IN $parts { fn::add_item_unit_part($unit.id, $obj.name, $obj.description, $obj.cost, $date, $obj.payment_method) };
RETURN (SELECT *, (SELECT * FROM item_unit_part WHERE unit = $parent.id) AS parts FROM ONLY $unit.id);
} PERMISSIONS FULL;
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
LET $unit = (SELECT * FROM ONLY $svp.item_unit);
LET $uparts = (SELECT * FROM item_unit_part WHERE unit = $svp.item_unit);
IF (array::len($uparts) == 0) { DELETE $svp.item_unit; } ELSE IF ($unit.invoiced == false) { THROW 'can not delete process with balance'; };
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
DEFINE FUNCTION fn::svps::get_all_svps_full_by_document($svd_id: record<saudi_visas_document>) {
LET $svps = (SELECT *, (SELECT *, (SELECT *, transaction[*] FROM item_unit_part WHERE unit = $parent.id) AS parts FROM ONLY $parent.item_unit) AS item_unit, (SELECT *, svd_job[*] FROM ONLY $parent.assigned_job) AS assigned_job, (fn::get_full_svd($parent.svd)) AS svd, profile[*] FROM saudi_visa_process WHERE status = 'active' AND svd = $svd_id ORDER BY created_at DESC
);
RETURN $svps;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::svps::update_profile($prof: record<candidate_profile>, $hide: bool) { RETURN (UPDATE ONLY $prof SET hide = $hide); } PERMISSIONS FULL;
DEFINE FUNCTION fn::tasks::add_category($name: string, $desc: string) { RETURN (CREATE ONLY task_category CONTENT { description: $desc, name: $name }); } PERMISSIONS FULL;
DEFINE FUNCTION fn::tasks::add_task($name: string, $desc: string, $category_id: record<task_category>, $deadline: string, $last_critical_days: int, $meta: object) { RETURN (CREATE ONLY task CONTENT { category: $category_id, deadline: <datetime> $deadline, description: $desc, last_critical_days: $last_critical_days, meta: $meta, name: $name }); } PERMISSIONS FULL;
DEFINE FUNCTION fn::tasks::complete_task($task_id: record<task>) {
DELETE $task_id;
RETURN true;
} PERMISSIONS FULL;
DEFINE FUNCTION fn::tasks::get_categories() { RETURN (SELECT * FROM task_category); } PERMISSIONS FULL;
DEFINE FUNCTION fn::tasks::get_tasks() { RETURN (SELECT * FROM task ORDER BY deadline
); } PERMISSIONS FULL;
DEFINE FUNCTION fn::update_entity($entity: record<entity>, $name: string, $address: string, $contacts: array<string>, $status: string, $picture: option<string | null>, $entity_type: option<object | null>) {
IF ($entity_type.to_vendor == true AND $entity_type.to_customer == true) { THROW 'invalid request'; };
LET $var_entity = (SELECT * FROM ONLY $entity);
IF ($status != $var_entity.status) {
IF ($status == 'active') { fn::activate_entity($entity) };
IF ($status == 'inactive') { fn::inactivate_entity($entity) };
};
IF ($entity_type.to_vendor == true AND $var_entity.vendor_account) { THROW 'already a vendor'; } ELSE IF ($entity_type.to_vendor == true) {
LET $vendor_account = (CREATE ONLY sl_account);
UPDATE ONLY $entity SET vendor_account = $vendor_account.id;
};
IF ($entity_type.to_customer == true AND $var_entity.customer_account) { THROW 'alread a customer'; } ELSE IF ($entity_type.to_customer == true) {
LET $customer_account = (CREATE ONLY sl_account);
UPDATE ONLY $entity SET customer_account = $customer_account.id;
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
DEFINE FUNCTION fn::yearly_payments($y: int) {
LET $recv = (SELECT transaction.date AS date, math::sum(amount) AS total FROM payment_receipt WHERE time::year(transaction.date) == $y GROUP BY transaction.date);
LET $paid = (SELECT transaction.date AS date, math::sum(amount) AS total FROM payment_voucher WHERE time::year(transaction.date) == $y GROUP BY transaction.date);
LET $recv = (SELECT * FROM ONLY $recv LIMIT 1);
LET $paid = (SELECT * FROM ONLY $paid LIMIT 1);
RETURN { paid: $paid.total ?? 0, received: $recv.total ?? 0 };
} PERMISSIONS FULL;
DEFINE FUNCTION fn::yearly_revenue($y: int) { RETURN (SELECT account.name AS account_name, math::sum(incr - decr) AS amount FROM gl_account_entry WHERE account.type = 'income' AND time::year(transaction.date) == $y GROUP BY account_name); } PERMISSIONS FULL;

