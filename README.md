Vagrant configuration to test a small rabbitmq cluster.

# Fetch Vagrant image

If you do not have Vagrant image available on your host, first fetch it:

    vagrant box add puppetlabs/debian-7.4-64-puppet 'https://vagrantcloud.com/puppetlabs/boxes/debian-7.4-64-puppet/versions/2/providers/virtualbox.box'

# Starting cluster

Cd inside rabbitmq_vagrant and launch both rabbit1 and rabbit2 virtual machines:

    vagrant up

# Playing with clients

If all went well, you will find test_clients/send.py and test_clients/receive.py two python programs that can send and receive messages from the cluster (not really a reference implementation but it works...). To run this clients, you will need the pika library:

    pip install pika==0.9.8

Launch this clients, stop, start, rabbit on both nodes of the cluster and see what happens. To stop a rabbit node, either stop the vm (vagrant halt rabbit1) or ssh on the vm and stop rabbit:

    vagrant ssh rabbit1
    sudo rabbitmqctl stop_app
