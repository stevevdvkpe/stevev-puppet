class sshd {
	package { "openssh-server":
		ensure => installed;
	}

	file { "/etc/ssh/sshd_config":
		ensure => present,
		mode   => '444',
		owner  => 'root',
		group  => 'root',
		source => "puppet:///modules/sshd/sshd_config",
	}
}
