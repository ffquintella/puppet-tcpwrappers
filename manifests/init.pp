class tcpwrappers
(
  # lint:ignore:variable_is_lowercase
  Boolean $defaultAllowAll   = $tcpwrappers::params::default_allow_all,
  Boolean $defaultDenyAll    = $tcpwrappers::params::default_deny_all,
  # lint:endignore
  Boolean $default_allow_all = $tcpwrappers::params::default_allow_all,
  Boolean $default_deny_all  = $tcpwrappers::params::default_deny_all,
  String $config_path       = $tcpwrappers::params::config_path,
  String $allow_path        = $tcpwrappers::params::allow_path,
  String $deny_path         = $tcpwrappers::params::deny_path,
  String $allow_message     = $tcpwrappers::params::allow_message,
  String $deny_message      = $tcpwrappers::params::deny_message,
  String $package_ensure    = $tcpwrappers::params::package_ensure,
  String $package_name      = $tcpwrappers::params::package_name
)
inherits tcpwrappers::params
{

  contain tcpwrappers::install
  contain tcpwrappers::config

}
