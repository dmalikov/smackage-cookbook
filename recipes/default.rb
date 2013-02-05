# Cookbook Name:: smackage
#
# Recipe:: default
#

# Directory that suppose to be in $PATH
bin_dir = File.join(ENV["HOME"], 'bin')
unless ENV["PATH"].include? bin_dir
  Chef::Log.error("bin_dir= #{bin_dir} is not in $PATH= #{ENV["PATH"]}")
end

git node["smackage"]["dir"] do
  repository "git@github.com:standardml/smackage.git"
  revision   "master"
  user       ENV["USER"]
  group      ENV["USER"]
  action     :sync
end

bash "build smackage" do
  user ENV["USER"]
  cwd  node["smackage"]["dir"]
  code <<-EOH
    make mlton
    bin/smackage refresh
    bin/smackage make smackage mlton
    bin/smackage make smackage smlnj
    bin/smackage make smackage install
  EOH
end

template node["smackage"]["smlnj_config_path"] do
  source "smlnj_config.erb"
  mode   0755
  owner  ENV["USER"]
  group  ENV["USER"]
  variables( {
    :home => ENV["HOME"]
  } )
end

template File.join(bin_dir, 'mlton') do
  source "mlton_bin.erb"
  mode   0755
  owner  ENV["USER"]
  group  ENV["USER"]
  variables( {
    :home => ENV["HOME"]
  })
end
