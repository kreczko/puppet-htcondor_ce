# Generating job_routes for HTCondor CE
class htcondor_ce::config::job_routes{
  $job_routes = $::htcondor_ce::job_routes
  file { $job_routes:
    ensure  => file,
    owner   => 'condor',
    group   => 'condor',
    mode    => '0644',
    content => template($job_routes_template),
  }
}
