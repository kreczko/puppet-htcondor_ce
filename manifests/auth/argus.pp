# Class: htcondor_ce::auth
#
# This class installs and configures the
# authorization backend for HTCondorCE.
#
# Defaults to ARGUS
#
# Parameters:
#
class htcondor_ce::auth::argus {
  # general parameters
  $pep_callout      = '/etc/grid-security/gsi-pep-callout-condor.conf'
  $gsi_authz        = '/etc/grid-security/gsi-authz.conf'
  # used in $pep_callout template
  $argus_server     = $::htcondor_ce::argus_server
  $argus_port       = $::htcondor_ce::argus_port
  $argus_resourceid = $::htcondor_ce::argus_resourceid
  # validate inputs
  validate_string($argus_server)
  validate_integer($argus_port)
  validate_string($argus_resourceid)

  $argus_packages = [
    'argus-gsi-pep-callout',
    'lcas-plugins-basic',
    'lcas-plugins-voms',
    'lcmaps-plugins-basic',
    'lcmaps-plugins-c-pep',
    'lcmaps-plugins-verify-proxy',
    'lcmaps-plugins-voms',
  ]
  package { $argus_packages: ensure => present, }
  -> file { $pep_callout:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/gsi-pep-callout.erb"),
    require => Package['argus-gsi-pep-callout'],
  } -> file { $gsi_authz:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => "puppet:///modules/${module_name}/gsi-authz.conf",
    require => Package['argus-gsi-pep-callout'],
  }

}
