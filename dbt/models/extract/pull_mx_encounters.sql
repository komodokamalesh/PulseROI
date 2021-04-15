{{
  config(
    materialized='table', 
    transient=true
  	)
}}


--pull sample? of mx claims with service line information
--note: need to review QA

select
e.claim_date
,e.upk_key2
,e.encounter_key
,e.visit_id
,e.sources as sources_array
,e.patient_state
,e.hcp_1_npi
,e.hco_1_npi
,e.total_claim_charge_amount
,e.payer_kh_id
,e.payer_kh_id_impute_flag
,e.bill_type_code
,e.payer_channel
,e.statement_from
,e.statement_to
,e.discharge_status_code
,e.claim_type_code
,e.admit_type_code
,s.value:line_charge as line_charge
,s.value:ndc as ndc
,s.value:date_of_service as date_of_service
,s.value:service_from as sl_service_from	
,s.value:service_to	as sl_service_to
,s.value:procedure as procedure
,s.value:modifier_1	as modifier_1
,s.value:modifier_2	as modifier_2
,s.value:modifier_3	as modifier_3
,s.value:modifier_4	as modifier_4
,s.value:units as units
,s.value:place_of_service as place_of_service
,s.value:diagnosis_code_1 as diagnosis_code_1
,s.value:diagnosis_code_2 as diagnosis_code_2
,s.value:diagnosis_code_3 as diagnosis_code_3
,s.value:diagnosis_code_4 as diagnosis_code_4
,s.value:revenue_code as revenue_code
,s.value:emergency_indicator as emergency_indicator
,s.value:hco_s_1_npi as hco_s_1_npi
,s.value:hcp_s_1_npi as hcp_s_1_npi	
,s.value:hcp_s_2_npi as hcp_s_2_npi		
,s.value:service_line_number as service_line_number 
,array_contains('rowley'::variant, sources_array) as source_rowley
,array_contains('fleming-salk'::variant, sources_array) as source_fsalk
,array_contains('fleming-peso'::variant, sources_array) as source_fpeso
,array_contains('fleming-nightingale'::variant, sources_array) as source_fnight
from {{source('encounters', 'mx')}} as e,
lateral flatten(input=>e.service_lines) as s
where claim_date between {{var('analysis_start_date')}} and {{var('analysis_end_date')}}
