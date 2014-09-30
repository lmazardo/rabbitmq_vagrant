Vagrant configuration to test a small rabbitmq cluster.

# Fetch Vagrant image

If you do not have Vagrant image available on your host, first fetch it:

    vagrant box add puppetlabs/debian-7.4-64-puppet 'https://vagrantcloud.com/puppetlabs/boxes/debian-7.4-64-puppet/versions/2/providers/virtualbox.box'

# Starting cluster

Cd inside rabbitmq_vagrant and launch both rabbit1 and rabbit2 virtual machines:

    vagrant up

# Playing with clients

Two python programs can help test the cluster:

    test_clients/send.py
    test_clients/receive.py
    
They can send and receive messages to and from the cluster (not really a reference implementation but it works...). To run this clients, you will need the pika library:

    pip install pika==0.9.8

Launch this clients, play with the nodes of the cluster (stop one, restart it...) and see what happens. To stop a rabbit node, either stop the vm (vagrant halt rabbit1) or ssh on the vm and stop rabbit:

    vagrant ssh rabbit1
    sudo rabbitmqctl stop_app
