define tcpwrappers::allow
(
  $service,
  $address,
  $args = undef
)
{
  # Source can contain a mask, as well. Split that off.
  $parts = split($address, '/')
  $addr = $parts[0]
  $mask = $parts[1]

  # Validate the inputs
  $addr_regexps = [
    'ALL',
    'LOCAL',
    'UNKNOWN',
    'KNOWN',
    'PARANOID',
    '^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$',
    '^[a-zA-Z0-9_\-]+\.[a-zA-Z0-9_\-.]+',
  ]
  $mask_regex = [
    '^\d+$',
    '^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$',
  ]
  validate_re($addr, join($addr_regexps, '|'))
  if ($mask) {
    validate_re($mask, join($mask_regex, '|'))
  }
  validate_string($service)
  validate_string($args)

  if ($args) {
    $output = join([$service, $address, $args], ' : ')
  }
  else {
    $output = join([$service, $address], ' : ')
  }

  concat::fragment{ "tcpwrappers_allow_${name}":
    target  => $tcpwrappers::allow_path,
    order   => 10,
    content => "# ${name}\n${output}\n",
  }
}
