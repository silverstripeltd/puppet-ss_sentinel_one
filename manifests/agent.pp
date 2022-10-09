class ss_sentinel_one::agent inherits ::ss_sentinel_one {

  if $ss_sentinel_one::http_proxy {
      $proxy_environment = ["http_proxy=${ss_sentinel_one::http_proxy}", "https_proxy=${ss_sentinel_one::http_proxy}"]
  } else {
      $proxy_environment = []
  }

  exec { 'download':
    command     => "curl -s -f ${ss_sentinel_one::download_url} -o /usr/src/sentinelagent",
    path        => '/usr/bin:/usr/sbin:/bin',
    onlyif      => "test ! -f /usr/src/sentinelagent",
    environment => $proxy_environment,
  }
  -> package { 'sentinelagent':
    ensure   => installed,
    provider => dpkg,
    source   => '/usr/src/sentinelagent'
  }

  # The setup and configuration utilises the custom facts
  if $facts['sentinel_one'] != 'Enabled' {
    if $ss_sentinel_one::http_proxy != '' {
      exec { 'management_proxy':
        command => "sentinelctl management proxy set ${ss_sentinel_one::http_proxy}",
        path    => '/usr/bin:/usr/sbin:/bin',
      }
    }
    -> exec { 'management_type':
      command => 'sentinelctl management type set server',
      path    => '/usr/bin:/usr/sbin:/bin',
    }
    -> exec { 'management_site_token':
      command => "sentinelctl management token set ${ss_sentinel_one::site_token}",
      path    => '/usr/bin:/usr/sbin:/bin',
    }
    -> exec { 'management_enable':
      command => 'sentinelctl control enable',
      path    => '/usr/bin:/usr/sbin:/bin',
    }
    -> exec { 'management_start':
      command => 'sentinelctl control start',
      path    => '/usr/bin:/usr/sbin:/bin',
    }
  }
}
