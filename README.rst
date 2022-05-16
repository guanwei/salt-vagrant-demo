=================
Salt Vagrant Demo
=================

A Salt Demo using Vagrant.


Instructions
============

Run the following commands in a terminal. Git, VirtualBox and Vagrant must
already be installed.

.. code-block:: bash

    git clone https://github.com/guanwei/salt-vagrant-demo.git
    cd salt-vagrant-demo
    vagrant plugin install vagrant-vbguest
    vagrant up


This will download an CentOS VirtualBox image and create three virtual
machines for you. One will be a Salt Master named `salt-master` and two will be Salt
Minions named `salt-minion1` and `salt-minion2`.  The Salt Minions will point to the Salt
Master and the Minion's keys will already be accepted. Because the keys are
pre-generated and reside in the repo, please be sure to regenerate new keys if
you use this for production purposes.

You can then run the following commands to log into the Salt Master and begin
using Salt.

.. code-block:: bash

    vagrant ssh salt-master
    sudo salt '*' test.ping
