define tcpwrappers::allow
(
  String $service,
  String $address,
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
    '^\[(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))\]$',
    '^[a-zA-Z0-9_\-]+\.[a-zA-Z0-9_\-.]+',
  ]
  $mask_regex = [
    '^\d+$',
    '^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$',
  ]


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
