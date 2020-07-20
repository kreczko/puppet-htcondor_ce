# Generating job_routes for HTCondor CE
# JOB_ROUTER_ENTRIES = \
#    [ \
#      TargetUniverse = 5; \
#      name = "Local_Condor"; \
#      eval_set_AccountingGroup = strcat("group_u_", x509userproxyvoname, ".", Owner); \
#      delete_SUBMIT_Iwd = true; \
#      set_WantIOProxy = true; \
#      set_default_maxMemory = 3000; \
#    ]
class htcondor::config::job_routes{
  file { $job_routes:
    ensure  => file,
    owner   => 'condor',
    group   => 'condor',
    mode    => '0644',
    content => template($job_routes_template),
  }
}
