include_recipe "dhcapps::default"

node.default["application_name"] = "jekyll"

%w[ ruby ruby-dev git].each do |p|
  package p do
    action :install
  end
end

gem_package "jekyll" do
  action :install
end

