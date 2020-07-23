# class htcondor::config::apel
#
# This class configures the
# APEL Accounting for the HTCondor CE
#
# from https://twiki.cern.ch/twiki/bin/view/LCG/HtCondorCeAccounting
class htcondor_ce::config::apel{
  $apel_ce_config      = $::htcondor_ce::apel_ce_config
  $apel_condor_config  = $::htcondor_ce::apel_condor_config
  $apel_output_dir     = $::htcondor_ce::apel_output_dir
  $apel_scaling_attr   = $::htcondor_ce::apel_scaling_attr
  $apel_mysql_root_pw  = $::htcondor_ce::apel_mysql_root_pw
  $apel_mysql_db       = $::htcondor_ce::apel_mysql_db
  $apel_mysql_user     = $::htcondor_ce::apel_mysql_user
  $apel_mysql_password = $::htcondor_ce::apel_mysql_password
  $apel_use_test_queue = $::htcondor_ce::apel_use_test_queue

  $goc_site_name       = $::htcondor_ce::goc_site_name


  file{$apel_ce_config:
    ensure => present,
    owner   => 'condor',
    group   => 'condor',
    mode    => '0644',
    content => template("${module_name}/51-ce-apel.conf.erb"),
    require => Package['htcondor-ce-apel'],
  }

  file{$apel_condor_config:
    ensure => present,
    owner   => 'condor',
    group   => 'condor',
    mode    => '0644',
    content => template("${module_name}/51-condor-apel.conf.erb"),
    require => Package['htcondor-ce-apel'],
  }

  ## MySQL settings (apelparser)
  class { '::mysql::server':
    root_password           => $mysql_root_pw,
    remove_default_accounts => true,
    restart                 => true
  }

  mysql::db { $apel_mysql_db:
    user     => $apel_mysql_user,
    password => $apel_mysql_password,
    host     => 'localhost',
    grant    => ['ALL'],
    sql      => '/usr/share/apel/client.sql'
}

  ## setup cron jobs for blah and batch parsing
  ## setup config for ssmsend
  ## setup cron jobs for ssmsend
}
