{{
  config(
    materialized='table', 
    transient='false'
  	)
}}


--aHUS trigger codes from example ticket
select * from SANDBOX_KRAO.EDA.aHUS_trigger_codes