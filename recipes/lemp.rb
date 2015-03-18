include_recipe "dhcapps::default"
include_recipe "dhcapps::_mysql"
include_recipe "dhcapps::_nginx"
include_recipe "dhcapps::_php5-fpm"

node.default["application_name"] = "lemp"

cookbook_file "/etc/nginx/sites-available/php.conf" do
  source "lemp/php-site"
end

link "/etc/nginx/sites-enabled/php.conf" do
  to "/etc/nginx/sites-available/php.conf"
end

file "/usr/share/nginx/html/info.php" do
  content '<?php phpinfo(); ?>'
end

