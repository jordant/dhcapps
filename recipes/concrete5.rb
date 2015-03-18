include_recipe "dhcapps::default"
include_recipe "dhcapps::_mysql"
include_recipe "dhcapps::_nginx"
include_recipe "dhcapps::_php5-fpm"

node.default["application_name"] = "concrete5"

%w[php5-gd].each do |php_package|
  package php_package do
    action :install
  end
end

remote_file "/tmp/concrete5.zip" do
  source "http://www.concrete5.org/download_file/-/view/74619/"
end

package "unzip" do
  action :install
end

bash "unzip concrete5" do
  action :run
  code <<-EOH
  unzip /tmp/concrete5.zip -d /var/www
  mv /var/www/concrete5* /var/www/concrete5 && chown www-data.www-data /var/www -R
  EOH
end

cookbook_file "/etc/nginx/sites-available/concrete5.conf" do
  source "concrete5/concrete5-site"
end

link "/etc/nginx/sites-enabled/concrete5.conf" do
  to "/etc/nginx/sites-available/concrete5.conf"
end

cookbook_file "/etc/nginx/conf.d/fastcgi.conf" do
  source "concrete5/fastcgi.conf"
end

include_recipe "dhcapps::_post_install"
include_recipe "dhcapps::_motd"
