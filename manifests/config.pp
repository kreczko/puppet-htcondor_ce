# Class: htcondor_ce::config
#
# This class configures a HTCondor Computing Element
#
# Parameters:
#
class htcondor_ce::config {
  $site_security       = '/etc/condor-ce/config.d/59-site-security.conf'
  $main_ce_config      = '/etc/condor-ce/config.d/60-configured-attributes.conf'
  $condor_mapfile      = '/etc/condor-ce/condor_mapfile'
  $ce_sysconfig        = '/etc/sysconfig/condor-ce'
  # general parameters used in manifest or more than one template
  $install_apel        = $::htcondor_ce::install_apel
  $install_bdii        = $::htcondor_ce::install_bdii
  $uid_domain          = $::htcondor_ce::uid_domain
  $use_static_shadow   = $::htcondor_ce::use_static_shadow
  # $site_security
  $gsi_regex           = $::htcondor_ce::gsi_regex
  $host_dn             = $::htcondor_ce::host_dn
  # $main_ce_config
  $condor_view_hosts   = $::htcondor_ce::condor_view_hosts
  $pool_collectors     = $::htcondor_ce::pool_collectors
  $pool_collector_str  = join(suffix($pool_collectors, ':9618'), ', ')

  file { $site_security:
    ensure  => file,
    owner   => 'condor',
    group   => 'condor',
    mode    => '0644',
    content => template("${module_name}/ce-site-security.conf.erb"),
  }

  file { $main_ce_config:
    ensure  => file,
    owner   => 'condor',
    group   => 'condor',
    mode    => '0644',
    content => template("${module_name}/60-configured-attributes.conf.erb"),
  }

  class {'::htcondor_ce::config::job_routes': }

  file { $condor_mapfile:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/condor_mapfile.erb"),
  }

  file { $ce_sysconfig:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => "puppet:///modules/${module_name}/sysconfig-condor-ce",
  }

  $config_files = [File[$main_ce_config], File[$site_security], File[$condor_mapfile]]

  exec { '/usr/bin/condor_ce_reconfig': refreshonly => true, }

  $config_files ~> Exec['/usr/bin/condor_ce_reconfig']

  if $install_bdii {
    class { '::htcondor_ce::config::bdii': }
  }

  if $use_static_shadow {
    class { '::htcondor_ce::config::shadow': }
  }

  if $install_apel {
    class { '::htcondor_ce::config::apel': }
  }

  class { '::htcondor_ce::config::certs': }

}
