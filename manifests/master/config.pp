class rsnapshot::master::config {

  File_line {
    ensure  => present,
    path    => '/etc/rsnapshot.conf',
    require => Package['rsnapshot'],
  }

  file_line { 'snapshot_root':
    match   => "^snapshot_root\t",
    line    => "snapshot_root\t/var/backups/rsnapshot/",
  }

  file_line { 'exclude_mysql':
    line    => "exclude\tvar/lib/mysql",
  }

  file_line { 'exclude_postgresql':
    line    => "exclude\tvar/lib/postgresql",
  }

  file_line { 'exclude_tmp':
    line    => "exclude\ttmp",
  }

  file_line { 'exclude_spool':
    line    => "exclude\tvar/spool",
  }

  file_line { 'exclude_php5_sessions':
    line    => "exclude\tvar/lib/php5",
  }

  file_line { 'exclude_jenkins_workspace':
    line    => "exclude\tvar/lib/jenkins/workspace",
  }

  file_line { 'exclude_dev':
    line    => "exclude\tdev",
  }

  file_line { 'exclude_proc':
    line    => "exclude\tproc",
  }

  file_line { 'exclude_sys':
    line    => "exclude\tsys",
  }

  exec { 'generate private ssh key':
    command  => "/usr/bin/ssh-keygen -f /root/.ssh/id_rsa -N '' -C 'root@${::fqdn}'",
    creates  => '/root/.ssh/id_rsa',
  }

  file_line { 'cmd_ssh':
    match => "cmd_ssh\t",
    line  => "cmd_ssh\t/usr/bin/ssh",
  }

  file_line { 'link_dest':
    match => "link_dest\t",
    line  => "link_dest\t1",
  }

  file_line { 'no_localhost_home':
    match => "backup\t\/home\/\t\tlocalhost\/",
    line  => "#backup\t/home/\t\tlocalhost/"
  }

  file_line { 'no_localhost_etc':
    match => "backup\t\/etc\/\t\tlocalhost\/",
    line  => "#backup\t/etc/\t\tlocalhost/"
  }

  file_line { 'no_localhost_usr_local':
    match => "backup\t\/usr\/local\/\tlocalhost\/",
    line  => "#backup\t/usr/local/\tlocalhost/"
  }

  file_line { 'retain_hourly':
    match => "retain\t\thourly\t",
    line  => "retain\t\thourly\t4",
  }

  cron { 'rsnapshot hourly':
    user    => root,
    hour    => '*/6',
    minute  => 0,
    command => 'rsnapshot hourly'
  }

  cron { 'rsnapshot daily':
    user    => root,
    hour    => 4,
    minute  => 0,
    command => 'rsnapshot daily'
  }

  cron { 'rsnapshot weekly':
    user    => root,
    hour    => 2,
    minute  => 0,
    weekday => 0,
    command => 'rsnapshot weekly'
  }
}
