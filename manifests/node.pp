class rsnapshot::node(
  $to_location,
  $ensure         = present,
  $identifier     = $::fqdn,
  $ipaddress      = $::ipaddress,
  $backup         = [],
  $backup_script  = [],
  $export_sshkeys = true,
  $sshkey_aliases = [$identifier, $::ipaddress],
) {

  @@rsnapshot::master::node_definition { $identifier:
    ensure         => $ensure,
    to_location    => $to_location,
    identifier     => $identifier,
    ipaddress      => $ipaddress,
    backup         => $backup,
    backup_script  => $backup_script,
    export_sshkeys => $export_sshkeys,
  }

  Rsnapshot::Node::Master_definition <<| location_name == $to_location |>>
}
