# Repositories needed for HTCondor installation
class htcondor_ce::install::repositories {

  case $::osfamily {
    'RedHat'  : {
      yumrepo { 'htcondor-stable':
          descr    => "HTCondor Stable RPM Repository for Redhat Enterprise Linux ${facts['os']['release']['major']}",
          baseurl  => 'https://research.cs.wisc.edu/htcondor/yum/stable/8.8/rhel7',
          enabled  => 0,
          gpgcheck => 1,
          gpgkey   => 'http://research.cs.wisc.edu/htcondor/yum/RPM-GPG-KEY-HTCondor',
          before   => [Package['condor'], Package['htcondor-ce']],
        }

        yumrepo { 'wlcg':
          descr    => 'WLCG Repository',
          baseurl  => 'http://linuxsoft.cern.ch/wlcg/centos7/$basearch',
          enabled  => 0,
          gpgcheck => 1,
          gpgkey   => 'http://linuxsoft.cern.ch/wlcg/RPM-GPG-KEY-wlcg',
          before   => [Package['condor'], Package['htcondor-ce']],
        }

        yumrepo { 'epel':
          descr    => 'Extra Packages for Enterprise Linux 7 - $basearch',
          metalink => 'https://mirrors.fedoraproject.org/metalink?repo=epel-debug-7&arch=$basearch&infra=$infra&content=$contentdir',
          baseurl  => 'http://linuxsoft.cern.ch/wlcg/centos7/$basearch',
          enabled  => 0,
          gpgcheck => 1,
          gpgkey   => 'https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7',
          before   => [Package['condor'], Package['htcondor-ce']],
        }
    }
    default: {
      fail("This module currently doesn't support OSes other than CentOS 7")
    }
  }
}
