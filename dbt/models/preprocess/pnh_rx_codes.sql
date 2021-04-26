{{
  config(
    materialized='table', 
    transient='false'
  	)
}}


--pull in codes related to pnh  from 
select * from SANDBOX_KRAO.EDA.pnh_treatment_codes