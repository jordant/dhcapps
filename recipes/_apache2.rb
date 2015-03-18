include_recipe "dhcapps::default"

package "apache2" do
  action :install
end

package "apache2-utils" do
  action :install
end

bash "disable default apache site" do
  code <<-EOH
  a2dissite 000-default
  EOH
end
