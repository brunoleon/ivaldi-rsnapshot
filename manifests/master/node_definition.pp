define rsnapshot::master::node_definition(
  $ensure = present,
  $to_location,
  $identifier,
  $ipaddress,
  $backup_script = [],
  $backup = [],
  $export_sshkeys,
) {
  $backup_script_array = any2array($backup_script)
  $backup_array = any2array($backup)

  concat::fragment { "rsnapshot_node_${name}_backup_script":
    target  => $rsnapshot::params::config_path,
    content => template('rsnapshot/rsnapshot_backup_script.conf.erb'),
    order   => '40',
  }
  concat::fragment { "rsnapshot_node_${name}_backup":
    target  => $rsnapshot::params::config_path,
    content => template('rsnapshot/rsnapshot_backup.conf.erb'),
    order   => '50',
  }
  if $export_sshkeys {
    include rsnapshot::sshkeys
  }
}
