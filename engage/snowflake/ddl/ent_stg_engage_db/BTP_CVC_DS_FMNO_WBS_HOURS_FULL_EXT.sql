USE ROLE ENT_ENGAGE_OWNER_{{ENVR}}_ROLE;
USE DATABASE ENT_STG_ENGAGE_{{DB_SUFFIX}};
USE SCHEMA LOAD_STG;

CREATE OR REPLACE EXTERNAL TABLE LOAD_STG.BTP_CVC_DS_FMNO_WBS_HOURS_FULL_EXT(
  MANDT VARCHAR AS (NULLIF(($1:MANDT::VARCHAR),'')),
  SRC_SYSTEM VARCHAR AS (NULLIF(($1:SRC_SYSTEM::VARCHAR),'')),
  PROJECT_CODE VARCHAR AS (NULLIF(($1:PROJECT_CODE::VARCHAR),'')),
  FMNO VARCHAR AS (NULLIF(($1:FMNO::VARCHAR),'')),
  PERIOD VARCHAR AS (NULLIF(($1:PERIOD::VARCHAR),'')),
  UPDATE_DATE VARCHAR AS (NULLIF(($1:UPDATE_DATE::VARCHAR),'')),
  ACTIVITY VARCHAR AS (NULLIF(($1:ACTIVITY::VARCHAR),'')),
  FINANCE_APPROVED_FLAG VARCHAR AS (NULLIF(($1:FINANCE_APPROVED_FLAG::VARCHAR),'')),
  ROLE_CATEGORY VARCHAR AS (NULLIF(($1:ROLE_CATEGORY::VARCHAR),'')),
  CLIENT_HOURS NUMBER AS ($1:CLIENT_HOURS::NUMBER(38,3)),
  HOURS NUMBER AS ($1:HOURS::NUMBER(38,3)),
  offset NUMBER AS ($1:offset::NUMBER),
  topic_name VARCHAR AS (NULLIF(($1:topic_name::VARCHAR),'')),
  topic_partition NUMBER AS ($1:topic_partition::NUMBER),
  topic_record_timestamp VARCHAR AS (NULLIF(($1:topic_record_timestamp::VARCHAR),'')),
  LOAD_DATE TIMESTAMP_NTZ(9) AS (TO_TIMESTAMP_NTZ((SPLIT_PART(SPLIT_PART(METADATA$FILENAME, '/', 5), '=', 2)) || (SPLIT_PART(SPLIT_PART(METADATA$FILENAME, '/', 6), '=', 2)), 'YYYY-MM-DD'))  
    )
PARTITION BY (LOAD_DATE)
LOCATION=@STG_ENGAGE/btp/full/formatted/fct-btphana.cvc-ds-fmno-wbs-hours/
FILE_FORMAT = FF.PARQUET_FORMAT;
