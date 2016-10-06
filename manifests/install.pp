class pdsh::install (
  $package   = $pdsh::package,
  $rcmd_pkgs = $pdsh::rcmd_pkgs,
  $mod_pkgs   = $pdsh::mod_pkgs,
  ) {

    package {$package:
      ensure => installed,
    }
    $rcmd_pkgs.each |$rcmd| {
      package { $rcmd:
        ensure => installed,
      }
    }
    $mod_pkgs.each |$mod| {
      package { $mod:
        ensure => installed,
      }
    }
  }
