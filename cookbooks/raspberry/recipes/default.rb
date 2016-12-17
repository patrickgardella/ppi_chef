# Update apt-get cache once a day
include_recipe 'apt'
node.set['apt']['unattended_upgrades']['update_package_lists'] = TRUE

cookbook_file '/etc/network/interfaces' do
  source 'interfaces'
end

package 'iw'
package 'wpasupplicant'

cookbook_file '/boot/wifi.conf' do
  action :create_if_missing
  source 'wifi.conf'
end

package 'git'
package 'python-git'
package 'logrotate'

package 'sonic-pi' do
  action :remove
end

cookbook_file '/etc/logrotate.d/update_chef' do
  source 'update_chef_logrotate'
end

cookbook_file '/usr/local/bin/update_chef.py' do
  source 'update_chef.py'
  mode '0755'
end

file '/boot/chef-url' do
  action :create_if_missing
  content 'http://foo.bar'
end

file '/boot/chef-cookbook' do
  action :create_if_missing
  content ''
end

cookbook_file '/etc/init.d/update_chef' do
  source 'update_chef_init'
  mode '0755'
end

apt_package 'ruby-dev'
gem_package 'berkshelf' do
  version '4.3.3'
end

service 'update_chef' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
  provider Chef::Provider::Service::Init::Debian
end
