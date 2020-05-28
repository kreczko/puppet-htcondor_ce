# Configures host certificate and key files
class htcondor_ce::config::certs{
  $hostcert_location       = $::htcondor_ce::hostcert_location
  $hostkey_location       = $::htcondor_ce::hostkey_location


  file {'/etc/grid-security/hostcert.pem':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    source  => $hostcert_location,
  }

  file {'/etc/grid-security/hostkey.pem':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0400',
    source  => $hostkey_location,
  }

  file {'/etc/grid-security/condorcert.pem':
    ensure  => file,
    owner   => 'condor',
    group   => 'condor',
    mode    => '0444',
    source  => $hostcert_location,
  }

  file {'/etc/grid-security/condorkey.pem':
    ensure  => file,
    owner   => 'condor',
    group   => 'condor',
    mode    => '0400',
    source  => $hostkey_location,
  }
}
