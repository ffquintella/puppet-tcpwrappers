# tcpwrappers

This module is a fork form sharumpe/tcpwrappers. I decided to make it to allow compatibility with puppet and concat 6.

This is a tcpwrappers module intended to configure simple allow/deny rules.

This is provided as-is, YMMV.  If you're in Vagrant, make sure to include at least an allow for the "sshd" service.

## NOTE

Though the `defaultAllowAll` and `defaultDenyAll` are still included, they should be considered deprecated, and will be removed in the next release.

Code should be changed to use `default_allow_all` and `default_deny_all` instead.

## Examples

Just include the module:

```puppet
include tcpwrappers
```

Include the module, and create "allow all" or "deny all" defaults:
(Note: these rules will not be removed if you define other allow or deny rules.)

```puppet
class { 'tcpwrappers':
  default_deny_all => true,
}
```

Allow a service from an address/range (if not using default_allow_all):

```puppet
tcpwrappers::allow { 'local_sshd':
  service => 'sshd',
  address => '192.168.1.0/24',
}
```

Deny a service from an address/range (if not using default_allow_all):

```puppet
tcpwrappers::deny { 'local_ftp':
  service => 'ftpd',
  address => '192.168.2.0/255.255.255.0',
}
```

Use a wildcard (ALL, LOCAL, UNKNOWN, KNOWN, PARANOID):

```puppet
tcpwrappers::allow { 'local_httpd':
  service => 'httpd',
  address => 'LOCAL',
}
```
