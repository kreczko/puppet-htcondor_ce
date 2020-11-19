# Generating job_routes for HTCondor CE
class htcondor_ce::config::job_routes{
  $job_routes_base_settings = $::htcondor_ce::job_routes_base_settings
  $job_routes               = $::htcondor_ce::job_routes
  $job_routes_file          = '/etc/condor-ce/config.d/61-job-routes.conf'
  $job_routes_template      = $::htcondor_ce::job_routes_template

  file { $job_routes_file:
    ensure  => file,
    owner   => 'condor',
    group   => 'condor',
    mode    => '0644',
    content => template($job_routes_template),
  }

  File[$job_routes_file] ~> Exec['/usr/bin/condor_ce_reconfig']
}
