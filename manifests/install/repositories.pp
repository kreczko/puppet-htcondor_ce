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
          before   => [Package['htcondor-ce']],
      }

      yumrepo { 'htcondor-development':
          descr    => "HTCondor Development RPM Repository for ${facts['os']['release']['major']}",
          baseurl  => 'https://research.cs.wisc.edu/htcondor/yum/development/rhel7',
          enabled  => 0,
          gpgcheck => 1,
          gpgkey   => 'http://research.cs.wisc.edu/htcondor/yum/RPM-GPG-KEY-HTCondor',
          before   => [Package['htcondor-ce']],
      }

      yumrepo { 'wlcg':
          descr    => 'WLCG Repository',
          baseurl  => 'http://linuxsoft.cern.ch/wlcg/centos7/$basearch',
          enabled  => 0,
          gpgcheck => 1,
          gpgkey   => 'http://linuxsoft.cern.ch/wlcg/RPM-GPG-KEY-wlcg',
          before   => [Package['htcondor-ce']],
      }

      yumrepo { 'epel':
          descr    => 'Extra Packages for Enterprise Linux 7 - $basearch',
          metalink => 'https://mirrors.fedoraproject.org/metalink?repo=epel-debug-7&arch=$basearch&infra=$infra&content=$contentdir',
          # baseurl  => 'http://download.fedoraproject.org/pub/epel/7/$basearch',
          enabled  => 0,
          gpgcheck => 1,
          gpgkey   => 'https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7',
          before   => [Package['htcondor-ce']],
      }

      yumrepo { 'EGI-trustanchors':
          descr    => 'EGI-trustanchors',
          baseurl  => 'http://repository.egi.eu/sw/production/cas/1/current/',
          enabled  => 1,
          gpgcheck => 1,
          gpgkey   => 'http://repository.egi.eu/sw/production/cas/1/current/GPG-KEY-EUGridPMA-RPM-3',
          before   => [Package['htcondor-ce']],
      }

      yumrepo { 'EGI-trustanchors':
          descr    => 'EGI-trustanchors',
          baseurl  => 'http://repository.egi.eu/sw/production/cas/1/current/',
          enabled  => 1,
          gpgcheck => 1,
          gpgkey   => 'http://repository.egi.eu/sw/production/cas/1/current/GPG-KEY-EUGridPMA-RPM-3',
          before   => [Package['htcondor-ce']],
      }

      yumrepo { 'UMD-4-base':
          descr    => "UMD-4-base (${facts['os']['release']['major']})",
          baseurl  => 'http://repository.egi.eu/sw/production/umd/4/centos7/$basearch/base',
          enabled  => 0,
          gpgcheck => 1,
          gpgkey   => 'http://repository.egi.eu/sw/production/umd/UMD-RPM-PGP-KEY',
          before   => [Package['htcondor-ce']],
      }

      yumrepo { 'UMD-4-updates':
          descr    => "UMD-4-updates (${facts['os']['release']['major']})",
          baseurl  => 'http://repository.egi.eu/sw/production/umd/4/centos7/$basearch/updates',
          enabled  => 0,
          gpgcheck => 1,
          gpgkey   => 'http://repository.egi.eu/sw/production/umd/UMD-RPM-PGP-KEY',
          before   => [Package['htcondor-ce']],
      }
    }
    default: {
      fail("This module currently doesn't support OSes other than CentOS 7")
    }
  }
}
