include_recipe "dhcapps::default"
include_recipe "dhcapps::_java"

apt_repository "elasticsearch" do
  uri "http://packages.elasticsearch.org/elasticsearch/1.4/debian"
  components ["main"]
  distribution "stable"
  key "https://packages.elasticsearch.org/GPG-KEY-elasticsearch"
  action :add
end

package "elasticsearch" do
  action :install
end

bash "update-rc.d elasticsearch" do
  code <<-EOH
  update-rc.d elasticsearch defaults 95 10
  EOH
end
