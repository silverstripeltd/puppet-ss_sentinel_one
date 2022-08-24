class ss_sentinel_one (
  $site_token,
  $download_url,
  $http_proxy = '',
) {
  class { 'ss_sentinel_one::agent': }
}
