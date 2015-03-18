include_recipe "dhcapps::default"

node.default["application_name"] = "openvpn"

%w[rng-tools easy-rsa openssl ipcalc iptables-persistent].each do |dep|
  package dep do
    action :install
  end
end

package "openvpn" do
  action :install
end

directory "/etc/openvpn/easy-rsa/keys" do
  action :create
  recursive true
end

cookbook_file "/etc/openvpn/easy-rsa/vars" do
  source "openvpn/vars"
end

cookbook_file "/etc/openvpn/server.conf" do
  source "openvpn/server.conf"
end

cookbook_file "/etc/sysctl.d/99-openvpn" do
  source "openvpn/openvpn.sysctl"
end

cookbook_file "/etc/iptables/rules.v4" do
  source "openvpn/iptables.rules.v4"
end

include_recipe "dhcapps::_post_install"
include_recipe "dhcapps::_motd"


