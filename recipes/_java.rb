include_recipe "dhcapps::default"
bash "setup java ppa" do
  code <<-EOH
  add-apt-repository -y ppa:webupd8team/java
  apt-get update
  echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
  echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
  EOH
end

package "oracle-java8-installer" do
  action :install
end
