class ss_sentinel_one (
  $download_url,
  $site_token = '',
  $http_proxy = '',
  $enable = true,
) {
  class { 'ss_sentinel_one::agent': }
}
