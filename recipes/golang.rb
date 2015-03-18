include_recipe "dhcapps::default"

node.default["application_name"] = "golang"

remote_file "/tmp/golang.tar.gz" do
  source "https://storage.googleapis.com/golang/go1.4.1.linux-amd64.tar.gz"
end

bash "install golang" do
  code <<-EOH
  tar zxvf /tmp/golang.tar.gz -C /opt && rm /tmp/golang.tar.gz
  EOH
end

cookbook_file "/etc/profile.d/go.sh" do
  source "golang/go.profile"
end
