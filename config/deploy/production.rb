set :stage, :production

set :scm,                         :git
set :repo_url,                    "git@bitbucket.org:maquinet/cashmonitor-2.git"
set :branch,                      "master"
set :scm_username,                "danvalencia"

set :rails_env,                   "production"
set :deploy_to,                   "/opt/cashmonitor"
set :normalize_asset_timestamps,  false
set :use_sudo,                    false

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a has can be used to set
# extended properties on the server.
# server 'example.com', user: 'deploy', roles: %w{web app}, my_property: :my_value

# you can set custom ssh options
# it's possible to pass any option but you need to keep in mind that net/ssh understand limited list of options
# you can see them in [net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start)
# set it globally
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
# and/or per server
server 'ec2-54-245-26-209.us-west-2.compute.amazonaws.com',
  user: 'ubuntu',
  roles: %w{web app db},
  ssh_options: {
    user: 'ubuntu', # overrides user setting above
    keys: %w(/Users/dvalencia/.ssh/keys/maquinet-server.pem),
    forward_agent: false,
    auth_methods: %w(publickey password)
  }
# setting per server overrides global ssh_options

# fetch(:default_env).merge!(rails_env: :production)
