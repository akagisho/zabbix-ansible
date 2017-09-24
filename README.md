# zabbix-ansible

Setting up zabbix server using by Ansible.

## Requirements

* CentOS 7.x
* Ansible

For local development environment:

* VirtualBox
* Vagrant 1.5+

## Usage

### production

First of all, install CentOS 7.x to the server.

Create Ansible inventory file.

    $ ${EDITOR} production/inventory
    [default]
    zabbix.example.com  ansible_ssh_user=admin

Run ansible playbook.

    $ ansible-playbook -i production/inventory site.yml

Login.

* http://zabbix.example.com/<br>(Admin / zabbix)

### local vagrant

Run ansible playbook.

    $ vagrant up
    $ vagrant provision

Login.

* [http://10.200.19.33/](http://10.200.19.33/)<br>(Admin / zabbix)
