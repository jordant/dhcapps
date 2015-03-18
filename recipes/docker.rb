include_recipe "dhcapps::default"

node.default["application_name"] = "docker"

apt_repository "docker" do
  uri "https://get.docker.com/ubuntu"
  components ["main"]
  distribution "docker"
  keyserver "keyserver.ubuntu.com"
  key "36A1D7869245C8950F966E92D8576A8BA88D21E9"
  action :add
end

package "lxc-docker" do
  action :install
end
