include_recipe "dhcapps::default"
include_recipe "dhcapps::_mysql"

node.default["application_name"] = "owncloud"

apt_repository "owncloud" do
  uri "http://download.opensuse.org/repositories/isv:/ownCloud:/community/xUbuntu_14.04/"
  components ["/"]
  key "http://download.opensuse.org/repositories/isv:ownCloud:community/xUbuntu_14.04/Release.key"
  action :add
end

package "owncloud" do
  action :install
end

cookbook_file "/etc/apache2/conf-available/owncloud.conf" do
  source "#{node["application_name"]}/owncloud.conf"
  owner "root"
  group "root"
  mode "0755"
end

include_recipe "dhcapps::_motd"
