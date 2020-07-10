# APEL accounting for HTCondor-CE
# from https://twiki.cern.ch/twiki/bin/view/LCG/HtCondorCeAccounting
class apel{
  $apel_scaling_attr = $htcondor_ce::apel_scaling_attr
  $packages = ['apel-client', 'apel-parser', 'htcondor-ce-apel']

  package{$packages:
    ensure=> present,
    install_options => ['--enablerepo', 'epel,UMD-4-updates,htcondor-development']
  }
}
