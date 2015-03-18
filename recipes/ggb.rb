include_recipe "dhcapps::default"
include_recipe "dhcapps::_python"
include_recipe "dhcapps::_apache2"
include_recipe "dhcapps::_elasticsearch"

%w[libapache2-mod-wsgi collectd-core].each do |dep|
  package dep do
    action :install
  end
end

bash "install graphite" do
  code <<-EOH
  apt-get -y install libffi-dev
  pip install bucky
  pip install whisper
  pip install carbon
  pip install -r https://raw.githubusercontent.com/graphite-project/graphite-web/master/requirements.txt
  pip install graphite-web
  cp /opt/graphite/conf/graphite.wsgi.example /opt/graphite/conf/graphite.wsgi
  chown www-data.www-data /opt/graphite/conf/graphite.wsgi ; chmod 755 /opt/graphite/conf/graphite.wsgi
  chown www-data.www-data /opt/graphite -R
  EOH
end

cookbook_file "/opt/graphite/conf/carbon.conf" do
  source "ggb/carbon.conf"
end

cookbook_file "/opt/graphite/conf/storage-schemas.conf" do
  source "ggb/storage-schemas.conf"
end

cookbook_file "/etc/init/carbon-cache.conf" do
  source "ggb/carbon-cache.upstart"
end

service "carbon-cache" do
  provider Chef::Provider::Service::Upstart
  supports :restart => true
  action :enable
end


cookbook_file "/etc/init/bucky.conf" do
  source "ggb/bucky.upstart"
end

service "bucky" do
  provider Chef::Provider::Service::Upstart
  supports :restart => true
  action :enable
end

# grafana
remote_file "/tmp/grafana.tar.gz" do
  source "http://grafanarel.s3.amazonaws.com/grafana-1.9.1.tar.gz"
end

bash "install grafana" do
  code <<-EOH
  tar zxvf /tmp/grafana.tar.gz -C /tmp
  mv /tmp/grafana-* /opt/grafana
  chown www-data.www-data /opt/grafana -R
  EOH
end

cookbook_file "/opt/grafana/config.js" do
  source "ggb/grafana.config.js"
end

bash "graphite-web syncdb" do
  user  "www-data"
  code <<-EOH
  python /opt/graphite/webapp/graphite/manage.py syncdb --noinput
  EOH
end



cookbook_file "/etc/apache2/sites-available/grafana.conf" do
  source "ggb/grafana-site"
end

bash "enable graphite/grafana web" do
  code <<-EOH
  a2enmod wsgi
  a2enmod headers
  a2ensite grafana
  a2enmod proxy
  EOH
end
