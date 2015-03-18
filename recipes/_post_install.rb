directory "/var/lib/cloud/scripts/per-once" do
  action :create
  recursive true
end

cookbook_file "/var/lib/cloud/scripts/per-once/#{node["application_name"]}.sh" do
  source "#{node["application_name"]}/post_install.sh"
  owner "root"
  group "root"
  mode "0755"
end
