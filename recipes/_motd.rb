bash "remove default motd's" do
  code <<-EOH
  rm -f /etc/update-motd.d/*
  EOH
end

template "/etc/update-motd.d/00-header" do
  source 'motd.erb'
  owner 'root'
  group 'root'
  mode  '0755'
  variables(
      "application_name" => node["application_name"]
  )
end

cookbook_file "/etc/update-motd.d/10-#{node["application_name"]}" do
  source "#{node["application_name"]}/10-motd"
  owner "root"
  group "root"
  mode "0755"
end

bash "update motd" do
  code <<-EOH
  run-parts -v --exit-on-error /etc/update-motd.d
  EOH
end
