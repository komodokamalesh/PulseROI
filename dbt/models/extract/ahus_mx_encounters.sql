{{
  config(
    materialized='table', 
    transient=true
  	)
}}


--pull in encounters realted to ahus



select
e.claim_date
,e.upk_key2
,e.encounter_key
,e.hcp_1_npi
,e.hco_1_npi
,e.hcp_npi_array
,e.hco_npi_array
,e.diagnosis_array
,e.procedure_array
,e.ndc_array
from {{source('encounters', 'mx_lite')}} as e
where claim_date between {{var('analysis_start_date')}} and {{var('analysis_end_date')}}
and arrays_overlap (e.diagnosis_array, (select array_agg(code) from {{ref('aHUS_codes')}}))

