# class htcondor::config::apel
#
# This class configures the
# APEL Accounting for the HTCondor CE
#
# from https://twiki.cern.ch/twiki/bin/view/LCG/HtCondorCeAccounting
class htcondor_ce::config::apel{
  $apel_ce_config      = htcondor_ce::apel_ce_config
  $apel_condor_config  = htcondor_ce::apel_condor_config
  $apel_output_dir     = htcondor_ce::apel_output_dir
  $apel_scaling_attr   = htcondor_ce::apel_scaling_attr


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
    content => template("${module_name}/51-ce-condor.conf.erb"),
    require => Package['htcondor-ce-apel'],
  }

  ## setup cron jobs for blah and batch parsing
  ## setup config for ssmsend
  ## setup cron jobs for ssmsend
}
