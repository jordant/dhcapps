include_recipe "dhcapps::default"

node.default["application_name"] = "nodejs"

apt_repository "nodejs" do
  uri "https://deb.nodesource.com/node"
  components ["main"]
  distribution node['lsb']['codename']
  key "https://deb.nodesource.com/gpgkey/nodesource.gpg.key"
  action :add
end

package "build-essential" do
  action :install
end

package "nodejs" do
  action :install
end
