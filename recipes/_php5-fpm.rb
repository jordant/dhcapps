include_recipe "dhcapps::default"

%w[php5-fpm php5-mysql].each do |p|
  package p do
    action :install
  end
end
