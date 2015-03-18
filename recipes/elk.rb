include_recipe "dhcapps::default"
include_recipe "dhcapps::nginx"

node.default["application_name"] = "elk"

include_recipe "dhcapps::_elasticsearch"

apt_repository "logstash" do
  uri "http://packages.elasticsearch.org/logstash/1.4/debian"
  components ["main"]
  distribution "stable"
  key "https://packages.elasticsearch.org/GPG-KEY-elasticsearch"
  action :add
end

package "logstash" do
  action :install
end

remote_file "/tmp/kibana.tar.gz" do
  source "https://download.elasticsearch.org/kibana/kibana/kibana-3.1.2.tar.gz"
end

bash "installing kibana" do
  code <<-EOH
  tar zxvf /tmp/kibana.tar.gz -C /usr/share/nginx/html/
  mv /usr/share/nginx/html/kibana*/ /usr/share/nginx/html/kibana
  EOH
end


cookbook_file "/etc/logstash/conf.d/01-input.conf" do
  source "elk/01-input.conf"
end

cookbook_file "/etc/logstash/conf.d/20-output.conf" do
  source "elk/20-output.conf"
end

cookbook_file "/usr/share/nginx/html/kibana/config.js" do
  source "elk/config.js"
end

include_recipe "dhcapps::_post_install"
include_recipe "dhcapps::_motd"

