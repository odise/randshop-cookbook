`knife ec2 server create -S awsprivate -I ami-5256b825 -G web-minimal --flavor=t1.micro`
`knife ec2 server list`
`knife prepare -i <path/to/ssh_key.pem> EC2_INSTANCE`
`knife cook -i <path/to/ssh_key.pem> -r "recipe[randshop]" EC2_INSTANCE`


