SELECT
CASE
WHEN infa_workflow_nm IN ( 'w_table_2_table_append_copy' ) THEN 'sp_table_2_table_load'
WHEN infa_workflow_nm IN ( 'w_dpl_partition_exchange', 'w_dcl_partition_exchange', 'w_prtn_xchg_btwn_2_prtnd_tbls' ) THEN
'sp_exchange_partition'
WHEN infa_workflow_nm IN ( 'w_tdat_table' ) THEN 'sp_stg2dat_load'
WHEN infa_workflow_nm IN ( 'w_sp_refresh_mv' ) THEN 'sp_refresh_mv'
ELSE 'X'
END oracle_sp,
ap.infa_fldr_nm AS informatica_folder,
ap.infa_workflow_nm AS informatica_workflow,
ap.proc_id AS abac_proc_id,
ap.proc_nm AS abac_proc_nm,
app.prop_nmspace AS abac_property_namespace,
app.prop_nm AS abac_property_name,
app.prop_valu AS abac_property_value
FROM
dbo.abac_proc ap
INNER JOIN dbo.abac_proc_prop_vw app
ON ap.proc_nm = app.proc_nm
WHERE
infa_workflow_nm IN ( 'w_table_2_table_append_copy',
'w_dpl_partition_exchange',
'w_dcl_partition_exchange',
'w_tdat_table',
'w_prtn_xchg_btwn_2_prtnd_tbls',
'w_sp_refresh_mv' )
AND infa_fldr_nm NOT IN ( 'edw_info_delivery', 'support', 'edw_data_presentation', 'edw_rdh' )
AND infa_fldr_nm LIKE '%edw%'
ORDER BY
ap.proc_nm,
app.prop_nm;