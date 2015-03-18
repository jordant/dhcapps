include_recipe "dhcapps::default"

%w[python python-dev python-pip python-virtualenv].each do |p|
  package p do
    action :install
  end
end
