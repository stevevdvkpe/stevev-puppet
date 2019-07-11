class smartd {
	package {
		"smartmontools": ensure => purged;
	}

	file { "/etc/smartd.conf":
		ensure  => absent,
		source  => [
			# from modules/smartd/files/$hostname/smartd.conf
			"puppet:///modules/smartd/$hostname/smartd.conf",
			# from modules/smartd/files/smartd.conf
			"puppet:///modules/smartd/smartd.conf",
		],
		mode    => "444",
		owner   => "root",
		group   => "root",
		# package must be installed before configuration file
		require => Package["smartmontools"],
	}

	service { "smartd":
		# automatically start at boot time
		enable     => false,
		# restart service if it is not running
		ensure     => stopped,
		# "service smartd status" returns useful service status info
		hasstatus  => true,
		# "service smartd restart" can restart service
		hasrestart => true,
		# package and configuration must be present for service
		require    => [ Package["smartmontools"],
			        File["/etc/smartd.conf"] ],
		# changes to configuration cause service restart
		subscribe  => File["/etc/smartd.conf"],
	}
}
