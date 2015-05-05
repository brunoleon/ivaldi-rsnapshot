define rsnapshot::master::node_definition(
  $ensure = present,
  $to_location,
  $identifier,
  $ipaddress,
  $backup = [],
) {
  $backup_array = any2array($backup)
  concat::fragment { "rsnapshot_node_${name}":
    target  => $rsnapshot::params::config_path,
    content => template('rsnapshot/rsnapshot_node.conf.erb'),
    order   => '50',
  }
}
