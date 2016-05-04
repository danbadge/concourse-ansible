# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  project_dir = File.expand_path(File.dirname(__FILE__))
  cluster_definition = YAML.load_file(File.join(project_dir, 'cluster-definition.yml'))

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true

  cluster_nodes = cluster_definition['cluster']
  config.vm.box = "ubuntu/trusty64"

  cluster_nodes.each do |node|
    config.vm.define vm_name = node['name'] do |instance|
      instance.vm.hostname = vm_name 

      instance.vm.provider :virtualbox do |vb|
        vb.name = vm_name
        vb.memory = node['memory'].to_i
        vb.cpus = node['cpus'].to_i
      end

      instance.vm.network(:private_network,{:ip => node['ip']})

      if vm_name =~ /^concourse.local*/
        instance.vm.network(:forwarded_port, guest: 80, host: 80)
        instance.vm.network(:forwarded_port, guest: 443, host: 443)
      end

      if cluster_nodes.last['name'] == vm_name
        instance.vm.provision "ansible" do |ansible|
          ansible.limit = 'all'
          ansible.playbook = "configure.yml"
          ansible.groups = {
            'concourse:children' => ["concourse-web", "concourse-worker"],
            'concourse:vars' => {
                'concourse_url' => "https://concourse.local",
                'concourse_ui_host' => "concourse.local"
            },
            'concourse-web' => ["concourse.local"],
            'concourse-worker' => ["concourse-worker-01", "concourse-worker-02"],
          }
        end
      end
    end
  end
end
