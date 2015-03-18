include_recipe "dhcapps::default"

node.default["application_name"] = "gitlab"

remote_file "/tmp/gitlab.deb" do
  source "https://downloads-packages.s3.amazonaws.com/ubuntu-14.04/gitlab_7.7.2-omnibus.5.4.2.ci-1_amd64.deb"
end

package "gitlab" do
  action :install
  provider Chef::Provider::Package::Dpkg
  source "/tmp/gitlab.deb"
end

bash "inital gitlab configure" do
  action :run
  code <<-EOH
  gitlab-ctl reconfigure
  EOH
end

file "/etc/gitlab/gitlab-secrets.json" do
  action :delete
end

include_recipe "dhcapps::_post_install"
include_recipe "dhcapps::_motd"
