include_recipe "dhcapps::default"

package 'nginx' do
  action :install
end

package "apache2-utils" do
  action :install
end

file "/etc/nginx/sites-enabled/default" do
  action :delete
end
