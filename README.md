Kitchen
========

Prepare your environment:

- ec2-api-tools (`brew install ec2-api-tools`)
- `gem install knife-ec2 knife-solo`
- make sure you have your AWS access key id and secret
- modify your settings

.chef/knife.rb:

    cookbook_path    ["cookbooks", "site-cookbooks"]
    node_path        "nodes"
    role_path        "roles"
    environment_path "environments"
    data_bag_path    "data_bags"
    #encrypted_data_bag_secret "data_bag_key"
    knife[:berkshelf_path] = "cookbooks"
    knife[:aws_access_key_id]       = "XXX"
    knife[:aws_secret_access_key]   = "XXX"
    knife[:region]                  = "eu-west-1" #{ENV['EC2_REGION']}"
    knife[:availability_zone]       = "eu-west-1a" #{ENV['EC2_AVAILABILITY_ZONE']}"
    knife[:ssh_user]                = "ec2-user"
    knife[:groups]                  = "default"


Vagrant
=======

A `vagrant up` should start a CentOS base box and trigger chef-solo.

EC2 provisioning with knkife-ec2
=================================

Create the box:

    knife ec2 server create -S awsprivate -I ami-5256b825 -G web-minimal --flavor=t1.micro

Check if it is up and running:
    knife ec2 server list

Install chef:

    knife prepare -i <path/to/ssh_key.pem> EC2_INSTANCE

Deploy:

    knife cook -i <path/to/ssh_key.pem> -r "recipe[randshop]" EC2_INSTANCE

Enjoy!


