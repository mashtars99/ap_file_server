-- ------------------------------
-- OPTION
-- ------------------------------

OPTION IMPORT;

-- ------------------------------
-- TABLE: airline
-- ------------------------------

DEFINE TABLE airline TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD key ON airline TYPE string ASSERT string::len($value) > 0 PERMISSIONS FULL;
DEFINE FIELD name ON airline TYPE string ASSERT string::len($value) > 0 PERMISSIONS FULL;

DEFINE INDEX unique_airline_key ON airline FIELDS key UNIQUE;


-- ------------------------------
-- TABLE: airport
-- ------------------------------

DEFINE TABLE airport TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD code ON airport TYPE string ASSERT string::len($value) > 0 PERMISSIONS FULL;
DEFINE FIELD country_code ON airport TYPE option<string | null> DEFAULT NULL PERMISSIONS FULL;
DEFINE FIELD country_long_code ON airport TYPE option<string | null> DEFAULT NULL PERMISSIONS FULL;
DEFINE FIELD country_name ON airport TYPE option<string | null> DEFAULT NULL PERMISSIONS FULL;
DEFINE FIELD description ON airport TYPE option<string | null> DEFAULT NULL PERMISSIONS FULL;
DEFINE FIELD latitude ON airport TYPE option<string | null> DEFAULT NULL PERMISSIONS FULL;
DEFINE FIELD longitude ON airport TYPE option<string | null> DEFAULT NULL PERMISSIONS FULL;
DEFINE FIELD name ON airport TYPE string ASSERT string::len($value) > 0 PERMISSIONS FULL;

DEFINE INDEX unique_airport_code ON airport FIELDS code UNIQUE;


-- ------------------------------
-- TABLE: bank
-- ------------------------------

DEFINE TABLE bank TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD abbr ON bank TYPE option<string | null> PERMISSIONS FULL;
DEFINE FIELD name ON bank TYPE string PERMISSIONS FULL;



-- ------------------------------
-- TABLE: bank_account
-- ------------------------------

DEFINE TABLE bank_account TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD account_no ON bank_account TYPE string PERMISSIONS FULL;
DEFINE FIELD asset_account ON bank_account TYPE record<gl_account> PERMISSIONS FULL;
DEFINE FIELD bank ON bank_account TYPE record<bank> PERMISSIONS FULL;
DEFINE FIELD iban ON bank_account TYPE option<string | null> PERMISSIONS FULL;
DEFINE FIELD title ON bank_account TYPE string PERMISSIONS FULL;



-- ------------------------------
-- TABLE: bank_account_deposit
-- ------------------------------

DEFINE TABLE bank_account_deposit TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD account ON bank_account_deposit TYPE record<bank_account> PERMISSIONS FULL;
DEFINE FIELD amount ON bank_account_deposit TYPE int PERMISSIONS FULL;
DEFINE FIELD description ON bank_account_deposit TYPE string PERMISSIONS FULL;
DEFINE FIELD reference ON bank_account_deposit TYPE string PERMISSIONS FULL;
DEFINE FIELD transaction ON bank_account_deposit TYPE record<transaction> PERMISSIONS FULL;



-- ------------------------------
-- TABLE: bank_account_withdrawl
-- ------------------------------

DEFINE TABLE bank_account_withdrawl TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD account ON bank_account_withdrawl TYPE record<bank_account> PERMISSIONS FULL;
DEFINE FIELD amount ON bank_account_withdrawl TYPE int PERMISSIONS FULL;
DEFINE FIELD description ON bank_account_withdrawl TYPE string PERMISSIONS FULL;
DEFINE FIELD reference ON bank_account_withdrawl TYPE string PERMISSIONS FULL;
DEFINE FIELD transaction ON bank_account_withdrawl TYPE record<transaction> PERMISSIONS FULL;



-- ------------------------------
-- TABLE: candidate_profile
-- ------------------------------

DEFINE TABLE candidate_profile TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD cnic ON candidate_profile TYPE string PERMISSIONS FULL;
DEFINE FIELD created_at ON candidate_profile TYPE datetime DEFAULT fn::utils::now() PERMISSIONS FULL;
DEFINE FIELD dob ON candidate_profile TYPE string PERMISSIONS FULL;
DEFINE FIELD father_given_name ON candidate_profile TYPE string PERMISSIONS FULL;
DEFINE FIELD father_surname ON candidate_profile TYPE string PERMISSIONS FULL;
DEFINE FIELD gender ON candidate_profile TYPE string PERMISSIONS FULL;
DEFINE FIELD given_name ON candidate_profile TYPE string PERMISSIONS FULL;
DEFINE FIELD merital_status ON candidate_profile TYPE string PERMISSIONS FULL;
DEFINE FIELD notes ON candidate_profile TYPE string PERMISSIONS FULL;
DEFINE FIELD passport_expiry_date ON candidate_profile TYPE string PERMISSIONS FULL;
DEFINE FIELD passport_issue_date ON candidate_profile TYPE string PERMISSIONS FULL;
DEFINE FIELD passport_issue_place ON candidate_profile TYPE string PERMISSIONS FULL;
DEFINE FIELD passport_number ON candidate_profile TYPE string PERMISSIONS FULL;
DEFINE FIELD picture ON candidate_profile TYPE string PERMISSIONS FULL;
DEFINE FIELD place_of_birth ON candidate_profile TYPE string PERMISSIONS FULL;
DEFINE FIELD religion ON candidate_profile TYPE string PERMISSIONS FULL;
DEFINE FIELD status ON candidate_profile TYPE string DEFAULT 'active' ASSERT $value INSIDE ['active', 'inactive'] PERMISSIONS FULL;
DEFINE FIELD surname ON candidate_profile TYPE string PERMISSIONS FULL;

DEFINE INDEX unique_pp ON candidate_profile FIELDS passport_number UNIQUE;


-- ------------------------------
-- TABLE: country
-- ------------------------------

DEFINE TABLE country TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD code ON country TYPE string PERMISSIONS FULL;
DEFINE FIELD currency ON country TYPE string PERMISSIONS FULL;
DEFINE FIELD language ON country TYPE string PERMISSIONS FULL;
DEFINE FIELD name ON country TYPE string PERMISSIONS FULL;



-- ------------------------------
-- TABLE: entity
-- ------------------------------

DEFINE TABLE entity TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD account ON entity TYPE record<sl_account> PERMISSIONS FULL;
DEFINE FIELD address ON entity TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD contacts ON entity TYPE option<array<string>> DEFAULT [] PERMISSIONS FULL;
-- DEFINE FIELD contacts[*] ON entity TYPE string PERMISSIONS FULL;
DEFINE FIELD name ON entity TYPE string ASSERT string::len($value) > 4 PERMISSIONS FULL;
DEFINE FIELD picture ON entity TYPE option<string | null> PERMISSIONS FULL;
DEFINE FIELD status ON entity TYPE string DEFAULT 'active' ASSERT $value INSIDE ['active', 'inactive'] PERMISSIONS FULL;
DEFINE FIELD type ON entity TYPE string ASSERT $value INSIDE ['customer', 'vendor'] PERMISSIONS FULL;



-- ------------------------------
-- TABLE: file
-- ------------------------------

DEFINE TABLE file TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD folder ON file TYPE record<folder> PERMISSIONS FULL;
DEFINE FIELD identifier ON file TYPE string PERMISSIONS FULL;
DEFINE FIELD metadata ON file TYPE object PERMISSIONS FULL;
DEFINE FIELD name ON file TYPE string PERMISSIONS FULL;



-- ------------------------------
-- TABLE: focal_person
-- ------------------------------

DEFINE TABLE focal_person TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD contacts ON focal_person TYPE string PERMISSIONS FULL;
DEFINE FIELD created_at ON focal_person TYPE datetime DEFAULT fn::utils::now() PERMISSIONS FULL;
DEFINE FIELD name ON focal_person TYPE string PERMISSIONS FULL;
DEFINE FIELD reference ON focal_person TYPE string PERMISSIONS FULL;



-- ------------------------------
-- TABLE: folder
-- ------------------------------

DEFINE TABLE folder TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD name ON folder TYPE string PERMISSIONS FULL;



-- ------------------------------
-- TABLE: folder_belongs_to
-- ------------------------------

DEFINE TABLE folder_belongs_to TYPE RELATION SCHEMALESS PERMISSIONS FULL;

-- DEFINE FIELD in ON folder_belongs_to TYPE record PERMISSIONS FULL;
-- DEFINE FIELD out ON folder_belongs_to TYPE record PERMISSIONS FULL;



-- ------------------------------
-- TABLE: gl_account
-- ------------------------------

DEFINE TABLE gl_account TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD balance ON gl_account TYPE int DEFAULT 0 PERMISSIONS FULL;
DEFINE FIELD meta ON gl_account TYPE option<object> DEFAULT {  } PERMISSIONS FULL;
DEFINE FIELD name ON gl_account TYPE string ASSERT string::len($value) > 1 PERMISSIONS FULL;
DEFINE FIELD type ON gl_account TYPE string ASSERT $value INSIDE ['asset', 'liability', 'equity', 'income', 'expense', 'contra_asset', 'contra_liability', 'contra_equity', 'contra_income', 'contra_expense'] PERMISSIONS FULL;

DEFINE INDEX unique_name_type ON gl_account FIELDS name, type UNIQUE;


-- ------------------------------
-- TABLE: gl_account_entry
-- ------------------------------

DEFINE TABLE gl_account_entry TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD account ON gl_account_entry TYPE record<gl_account> PERMISSIONS FULL;
DEFINE FIELD decr ON gl_account_entry TYPE int PERMISSIONS FULL;
DEFINE FIELD description ON gl_account_entry TYPE string DEFAULT '' PERMISSIONS FULL;
DEFINE FIELD incr ON gl_account_entry TYPE int PERMISSIONS FULL;
DEFINE FIELD reference ON gl_account_entry TYPE string DEFAULT '' PERMISSIONS FULL;
DEFINE FIELD transaction ON gl_account_entry TYPE record<transaction> PERMISSIONS FULL;


DEFINE EVENT update_gl_account_on_entry_creation ON gl_account_entry WHEN $event = 'CREATE' THEN {
IF $after.incr > 0 { UPDATE $after.account SET balance = balance + $after.incr; };
IF $after.decr > 0 { UPDATE $after.account SET balance = balance - $after.decr; };
};
DEFINE EVENT update_gl_account_on_entry_deletion ON gl_account_entry WHEN $event = 'DELETE' THEN {
IF $before.incr > 0 { UPDATE $before.account SET balance = balance - $before.incr; };
IF $before.decr > 0 { UPDATE $before.account SET balance = balance + $before.decr; };
};

-- ------------------------------
-- TABLE: gl_subaccount_of
-- ------------------------------

DEFINE TABLE gl_subaccount_of TYPE RELATION IN gl_account OUT gl_account SCHEMALESS PERMISSIONS FULL;

-- DEFINE FIELD in ON gl_subaccount_of TYPE record<gl_account> PERMISSIONS FULL;
-- DEFINE FIELD out ON gl_subaccount_of TYPE record<gl_account> PERMISSIONS FULL;



-- ------------------------------
-- TABLE: item
-- ------------------------------

DEFINE TABLE item TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD asset_account ON item TYPE record<gl_account> PERMISSIONS FULL;
DEFINE FIELD cogs_account ON item TYPE record<gl_account> PERMISSIONS FULL;
DEFINE FIELD contra_cogs_account ON item TYPE record<gl_account> PERMISSIONS FULL;
DEFINE FIELD contra_income_account ON item TYPE record<gl_account> PERMISSIONS FULL;
DEFINE FIELD income_account ON item TYPE record<gl_account> PERMISSIONS FULL;
DEFINE FIELD is_service ON item TYPE bool DEFAULT false PERMISSIONS FULL;
DEFINE FIELD name ON item TYPE string PERMISSIONS FULL;
DEFINE FIELD purchase_description ON item TYPE string DEFAULT '' PERMISSIONS FULL;
DEFINE FIELD sale_description ON item TYPE string DEFAULT '' PERMISSIONS FULL;



-- ------------------------------
-- TABLE: item_unit
-- ------------------------------

DEFINE TABLE item_unit TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD date ON item_unit TYPE option<datetime> DEFAULT time::now() PERMISSIONS FULL;
DEFINE FIELD description ON item_unit TYPE string PERMISSIONS FULL;
DEFINE FIELD invoice ON item_unit TYPE option<record<invoice> | null> DEFAULT NULL PERMISSIONS FULL;
DEFINE FIELD invoiced ON item_unit TYPE option<bool> DEFAULT false PERMISSIONS FULL;
DEFINE FIELD item ON item_unit TYPE record<item> PERMISSIONS FULL;
DEFINE FIELD name ON item_unit TYPE string PERMISSIONS FULL;



-- ------------------------------
-- TABLE: item_unit_part
-- ------------------------------

DEFINE TABLE item_unit_part TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD cost ON item_unit_part TYPE int PERMISSIONS FULL;
DEFINE FIELD date ON item_unit_part TYPE option<datetime> DEFAULT time::now() PERMISSIONS FULL;
DEFINE FIELD description ON item_unit_part TYPE string PERMISSIONS FULL;
DEFINE FIELD name ON item_unit_part TYPE string PERMISSIONS FULL;
DEFINE FIELD payment_method ON item_unit_part TYPE object PERMISSIONS FULL;
DEFINE FIELD transaction ON item_unit_part TYPE record<transaction> PERMISSIONS FULL;
DEFINE FIELD unit ON item_unit_part TYPE record<item_unit> PERMISSIONS FULL;



-- ------------------------------
-- TABLE: pipeline
-- ------------------------------

DEFINE TABLE pipeline TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD current_stage ON pipeline TYPE option<record<stage> | null> DEFAULT NULL PERMISSIONS FULL;
DEFINE FIELD finished ON pipeline TYPE bool DEFAULT false PERMISSIONS FULL;
DEFINE FIELD template ON pipeline TYPE record<pipeline_template> PERMISSIONS FULL;



-- ------------------------------
-- TABLE: pipeline_template
-- ------------------------------

DEFINE TABLE pipeline_template TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD name ON pipeline_template TYPE string PERMISSIONS FULL;



-- ------------------------------
-- TABLE: pipeline_template_stage
-- ------------------------------

DEFINE TABLE pipeline_template_stage TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD description ON pipeline_template_stage TYPE string PERMISSIONS FULL;
DEFINE FIELD name ON pipeline_template_stage TYPE string PERMISSIONS FULL;
DEFINE FIELD order ON pipeline_template_stage TYPE int PERMISSIONS FULL;
DEFINE FIELD tasks ON pipeline_template_stage TYPE array<object> PERMISSIONS FULL;
-- DEFINE FIELD tasks[*] ON pipeline_template_stage TYPE object PERMISSIONS FULL;
DEFINE FIELD template ON pipeline_template_stage TYPE record<pipeline_template> PERMISSIONS FULL;



-- ------------------------------
-- TABLE: resource_template_mapping
-- ------------------------------

DEFINE TABLE resource_template_mapping TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD mapping ON resource_template_mapping TYPE object PERMISSIONS FULL;
DEFINE FIELD resource ON resource_template_mapping TYPE string PERMISSIONS FULL;
DEFINE FIELD template ON resource_template_mapping TYPE record<template> PERMISSIONS FULL;

DEFINE INDEX unique_template_resource ON resource_template_mapping FIELDS resource, template UNIQUE;


-- ------------------------------
-- TABLE: saudi_job
-- ------------------------------

DEFINE TABLE saudi_job TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD arabic_name ON saudi_job TYPE string PERMISSIONS FULL;
DEFINE FIELD code ON saudi_job TYPE string PERMISSIONS FULL;
DEFINE FIELD english_name ON saudi_job TYPE string PERMISSIONS FULL;



-- ------------------------------
-- TABLE: saudi_visa_process
-- ------------------------------

DEFINE TABLE saudi_visa_process TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD assigned_job ON saudi_visa_process TYPE record<svp_assigned_job> PERMISSIONS FULL;
DEFINE FIELD completed_at ON saudi_visa_process TYPE option<datetime | null> DEFAULT NULL PERMISSIONS FULL;
DEFINE FIELD created_at ON saudi_visa_process TYPE datetime DEFAULT fn::utils::now() PERMISSIONS FULL;
DEFINE FIELD invoiced ON saudi_visa_process TYPE option<bool> DEFAULT false PERMISSIONS FULL;
DEFINE FIELD item_unit ON saudi_visa_process TYPE record<item_unit> PERMISSIONS FULL;
DEFINE FIELD pipeline ON saudi_visa_process TYPE record<pipeline> PERMISSIONS FULL;
DEFINE FIELD profile ON saudi_visa_process TYPE record<candidate_profile> PERMISSIONS FULL;
DEFINE FIELD status ON saudi_visa_process TYPE option<string> DEFAULT 'active' ASSERT $value INSIDE ['active', 'completed', 'cancelled'] PERMISSIONS FULL;
DEFINE FIELD svd ON saudi_visa_process TYPE record<saudi_visas_document> PERMISSIONS FULL;



-- ------------------------------
-- TABLE: saudi_visas_document
-- ------------------------------

DEFINE TABLE saudi_visas_document TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD completed ON saudi_visas_document TYPE bool DEFAULT false PERMISSIONS FULL;
DEFINE FIELD created_at ON saudi_visas_document TYPE datetime DEFAULT fn::utils::now() PERMISSIONS FULL;
DEFINE FIELD document_number ON saudi_visas_document TYPE string PERMISSIONS FULL;
DEFINE FIELD focal_person ON saudi_visas_document TYPE record<focal_person> PERMISSIONS FULL;
DEFINE FIELD sponsor_address ON saudi_visas_document TYPE string DEFAULT '' PERMISSIONS FULL;
DEFINE FIELD sponsor_id ON saudi_visas_document TYPE string PERMISSIONS FULL;
DEFINE FIELD sponsor_name_arabic ON saudi_visas_document TYPE string PERMISSIONS FULL;
DEFINE FIELD sponsor_name_english ON saudi_visas_document TYPE string PERMISSIONS FULL;

DEFINE INDEX unique_document_number ON saudi_visas_document FIELDS document_number UNIQUE;


-- ------------------------------
-- TABLE: sl_account
-- ------------------------------

DEFINE TABLE sl_account TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD balance ON sl_account TYPE int DEFAULT 0 PERMISSIONS FULL;
DEFINE FIELD meta ON sl_account TYPE option<object> DEFAULT {  } PERMISSIONS FULL;



-- ------------------------------
-- TABLE: sl_account_entry
-- ------------------------------

DEFINE TABLE sl_account_entry TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD account ON sl_account_entry TYPE record<sl_account> PERMISSIONS FULL;
DEFINE FIELD decr ON sl_account_entry TYPE int PERMISSIONS FULL;
DEFINE FIELD description ON sl_account_entry TYPE string PERMISSIONS FULL;
DEFINE FIELD incr ON sl_account_entry TYPE int PERMISSIONS FULL;
DEFINE FIELD reference ON sl_account_entry TYPE string PERMISSIONS FULL;
DEFINE FIELD transaction ON sl_account_entry TYPE record<transaction> PERMISSIONS FULL;
DEFINE FIELD ulid ON sl_account_entry TYPE option<string> DEFAULT rand::ulid() PERMISSIONS FULL;


DEFINE EVENT update_sl_account_on_entry_creation ON sl_account_entry WHEN $event = 'CREATE' THEN {
IF $after.incr > 0 { UPDATE $after.account SET balance = balance + $after.incr; };
IF $after.decr > 0 { UPDATE $after.account SET balance = balance - $after.decr; };
};
DEFINE EVENT update_sl_account_on_entry_deletion ON sl_account_entry WHEN $event = 'DELETE' THEN {
IF $before.incr > 0 { UPDATE $before.account SET balance = balance - $before.incr; };
IF $before.decr > 0 { UPDATE $before.account SET balance = balance + $before.decr; };
};

-- ------------------------------
-- TABLE: stage
-- ------------------------------

DEFINE TABLE stage TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD completed ON stage TYPE option<bool> DEFAULT false PERMISSIONS FULL;
DEFINE FIELD pipeline ON stage TYPE record<pipeline> PERMISSIONS FULL;
DEFINE FIELD template_stage ON stage TYPE record<pipeline_template_stage> PERMISSIONS FULL;



-- ------------------------------
-- TABLE: stage_task
-- ------------------------------

DEFINE TABLE stage_task TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD description ON stage_task TYPE string PERMISSIONS FULL;
DEFINE FIELD done ON stage_task TYPE bool DEFAULT false PERMISSIONS FULL;
DEFINE FIELD name ON stage_task TYPE string PERMISSIONS FULL;
DEFINE FIELD stage ON stage_task TYPE record<stage> PERMISSIONS FULL;



-- ------------------------------
-- TABLE: svd_job
-- ------------------------------

DEFINE TABLE svd_job TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD embassy ON svd_job TYPE string PERMISSIONS FULL;
DEFINE FIELD job ON svd_job TYPE object PERMISSIONS FULL;
DEFINE FIELD jobs_count ON svd_job TYPE int PERMISSIONS FULL;
DEFINE FIELD svd ON svd_job TYPE record<saudi_visas_document> PERMISSIONS FULL;



-- ------------------------------
-- TABLE: svp_assigned_job
-- ------------------------------

DEFINE TABLE svp_assigned_job TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD status ON svp_assigned_job TYPE option<string> DEFAULT 'assigned' ASSERT $value INSIDE ['assigned', 'cancelled', 'issued'] PERMISSIONS FULL;
DEFINE FIELD svd ON svp_assigned_job TYPE record<saudi_visas_document> PERMISSIONS FULL;
DEFINE FIELD svd_job ON svp_assigned_job TYPE record<svd_job> PERMISSIONS FULL;



-- ------------------------------
-- TABLE: task
-- ------------------------------

DEFINE TABLE task TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD category ON task TYPE record<task_category> PERMISSIONS FULL;
DEFINE FIELD deadline ON task TYPE datetime PERMISSIONS FULL;
DEFINE FIELD description ON task TYPE string PERMISSIONS FULL;
DEFINE FIELD last_critical_days ON task TYPE int PERMISSIONS FULL;
DEFINE FIELD meta ON task TYPE object PERMISSIONS FULL;
DEFINE FIELD name ON task TYPE string ASSERT string::len($value) > 0 PERMISSIONS FULL;



-- ------------------------------
-- TABLE: task_category
-- ------------------------------

DEFINE TABLE task_category TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD description ON task_category TYPE string PERMISSIONS FULL;
DEFINE FIELD name ON task_category TYPE string ASSERT string::len($value) > 0 PERMISSIONS FULL;



-- ------------------------------
-- TABLE: template
-- ------------------------------

DEFINE TABLE template TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD created_at ON template TYPE datetime PERMISSIONS FULL;
DEFINE FIELD file_id ON template TYPE string ASSERT string::len($value) != 0 PERMISSIONS FULL;
DEFINE FIELD name ON template TYPE string ASSERT string::len($value) != 0 PERMISSIONS FULL;
DEFINE FIELD vars ON template TYPE object PERMISSIONS FULL;

DEFINE INDEX unique_template_name ON template FIELDS name UNIQUE;


-- ------------------------------
-- TABLE: ticket
-- ------------------------------

DEFINE TABLE ticket TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD created_at ON ticket TYPE datetime DEFAULT time::now() PERMISSIONS FULL;
DEFINE FIELD passengers ON ticket TYPE array<object> PERMISSIONS FULL;
-- DEFINE FIELD passengers[*] ON ticket TYPE object PERMISSIONS FULL;
DEFINE FIELD pnr ON ticket TYPE string PERMISSIONS FULL;
DEFINE FIELD refunded ON ticket TYPE bool DEFAULT false PERMISSIONS FULL;
DEFINE FIELD sectors ON ticket TYPE array<object> PERMISSIONS FULL;
-- DEFINE FIELD sectors[*] ON ticket TYPE object PERMISSIONS FULL;



-- ------------------------------
-- TABLE: transaction
-- ------------------------------

DEFINE TABLE transaction TYPE NORMAL SCHEMALESS PERMISSIONS FULL;

DEFINE FIELD created_at ON transaction TYPE datetime PERMISSIONS FULL;
DEFINE FIELD date ON transaction TYPE datetime PERMISSIONS FULL;
DEFINE FIELD type ON transaction TYPE string PERMISSIONS FULL;



