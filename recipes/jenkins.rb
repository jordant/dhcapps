include_recipe "dhcapps::default"
include_recipe "dhcapps::_nginx"

node.default["application_name"] = "jenkins"

apt_repository "jenkins" do
    uri "http://pkg.jenkins-ci.org/debian"
    components ["binary/"]
    key "https://jenkins-ci.org/debian/jenkins-ci.org.key"
    action :add
end

package "jenkins" do
  action :install
end

cookbook_file "/etc/nginx/sites-available/jenkins.conf" do
  source "jenkins/jenkins-site"
end

link "/etc/nginx/sites-enabled/jenkins.conf" do
  to "/etc/nginx/sites-available/jenkins.conf"
end

#post install
#htpasswd -b -c /etc/nginx/conf.d/jenkins.htpasswd jenkins jenkins
