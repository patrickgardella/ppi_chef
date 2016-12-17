ssl_verify_mode :verify_peer

log_level         :warn
log_location      STDOUT

current_dir = File.absolute_path(__FILE__)

cookbook_path [
  '/chef_data/berks-cookbooks',
  '/chef_data/cookbooks'
]

chef_repo_path = File.absolute_path(__FILE__)
