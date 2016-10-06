class pdsh (
  String  $package   = $pdsh::params::package,
  Array   $rcmd_pkgs = $pdsh::params::rcmd_pkgs,
  Array   $mod_pkgs   = $pdsh::params::mod_pkgs,
  ) inherits pdsh::params {

  class {'::pdsh::install': } ->
  class {'::pdsh::generators': }
}
