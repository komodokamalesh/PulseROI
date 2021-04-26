## PULSE ROI DBT FLOW

### General Description
-This is the documentation for the dbt flow of the [Pulse ROI project](https://github.com/komodokamalesh/Pulse_ROI). The pipelines built by this flow pull a toy/demo data example from Komodo Health's snowflake server. The aim of the dbt is to produce a workable data set of a patient cohort and hcp activity for analysis and modeling on another platform like Jupyterhub.


### Flow:

The pipeline flow can be visualized with the dbt UI (see [dbt documentation](https://docs.getdbt.com/docs/introduction) for more details.)

Briefly, the flow starts with pulling codes for PNH and aHUS based on the example ticket that forms the basis of this analysis (for more details on the codes the tickets, see the [project concluence page](https://komodohealth.atlassian.net/wiki/spaces/CLI/pages/2124415473/Pulse+ROI+Analysis) through models/preceprocess/aHUS_codes.sql and models/preprocess/pnh_rx_codes.sql

With the codes loaded, pipeline then pulls out hcps that have had encounters related to aHUS over teh analysis window. The code is in models/extract/ahus_mx_encounters.sql and the analysis window is defined in dbt_project.yml

The pipe takes all the top hcps from ahus_mx_encounters.sql (extract/top_ahus_trigger_hcp) and then pulls encounters for these top hcps (extract/top_ahus_encounters_w_flags), adding flags for encounters with pnh codes.


