default['server_name'] = 'localhost'
default['randshop']['docroot'] = '/var/www/html/randshop'
default['randshop']['installroot'] = '/var/www/html'
default['randshop']['phpinidir'] = '/var/www/html/'
default['randshop']['htpasswd'] = '/var/www/html/.htpasswd'

default['mysql']['bind_address'] = 'localhost'
#default['mysql']['ec2_path'] = ''

default['mysql']['remove_anonymous_users'] = true
default['mysql']['allow_remote_root'] = false
default['mysql']['remove_test_database'] = true
# XXX change this!
default['mysql']['server_root_password'] = 'root'
default['mysql']['server_repl_password'] = 'root'
default['mysql']['server_debian_password'] = 'root'

# Grant all privileges on all tables in foo db
default['randshop']['database_user'] = 'randshop_user'
default['randshop']['database_user_passwd'] = 'randshop_user'
default['randshop']['database_nam'] = 'randshop'
