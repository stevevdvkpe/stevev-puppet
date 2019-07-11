class sshd {
	package { "openssh-server":
		ensure => installed;
	}

	file { "/etc/ssh/sshd_config":
		ensure  => present,
		mode    => '444',
		owner   => 'root',
		group   => 'root',
		source  => "puppet:///modules/sshd/sshd_config",
		require => Package["openssh-server"],
	}

	service { "ssh":
		enable    => true,
		ensure    => running,
		subscribe => File["/etc/ssh/sshd_config"],
	}

	ssh_authorized_key { "stevev-key-pair-oregon":
		ensure => present,
		user   => "ubuntu",
		type   => "ssh-rsa",
		key    => "AAAAB3NzaC1yc2EAAAADAQABAAABAQCrFq80b0ptexNiI6KP4hxww5d5RFm8djIpsdJqRZDyoyD5vaf7d30bTLef8su6stHuBBjKccMcUjNyu4BliJBXIy7bKVDllVB5oeLFizDahQcgqjYfzyqj16uEa7NLBW5/3ljLpPX8XEI7YFM/hg65JFgpQIAiBi2N6bGj9mQrh/51SpCO6FruQH8KVjDl/CLgbnFq9cDwRDAo4tvPO1b0MRVrvM8BbZbBUHqV/093jVXkwY+BxsU6cgOnHrSmoTnH4MqMXUI/ok31JORVbWW5NAz28Ag7V/NbDvRBIYicJOd9aqEST/L812+tmnE8iQzn3bZvv7v0E7FHneCS5Qpz",
	}
		
}
