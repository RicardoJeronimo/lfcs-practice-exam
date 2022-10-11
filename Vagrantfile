Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  
  config.vm.define "home" do |home|
    home.vm.hostname = "home"
    home.vm.network "private_network", ip: "1.2.3.4"
    home.vm.provider "virtualbox" do |vb|
      vb.name = 'lfcs-practice-exam_home'
	  
      unless File.exist?('./storage/home_disk1.vmdk')
        vb.customize ['createmedium', '--filename', './storage/home_disk1.vmdk', '--format', 'VMDK', '--variant', 'Standard', '--size', 1024]
      	vb.customize ['storagectl', :id, '--name', 'SATA', '--add', 'sata']
      	vb.customize ['storageattach', :id, '--storagectl', 'SATA', '--port', 0, '--device', 0, '--type', 'hdd', '--medium', './storage/home_disk1.vmdk']
      end
	  
      unless File.exist?('./storage/home_disk2.vmdk')
        vb.customize ['createmedium', '--filename', './storage/home_disk2.vmdk', '--format', 'VMDK', '--variant', 'Standard', '--size', 1024]
      	vb.customize ['storageattach', :id, '--storagectl', 'SATA', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', './storage/home_disk2.vmdk']
      end
	  
      unless File.exist?('./storage/home_disk3.vmdk')
        vb.customize ['createmedium', '--filename', './storage/home_disk3.vmdk', '--format', 'VMDK', '--variant', 'Standard', '--size', 3 * 1024]
      	vb.customize ['storageattach', :id, '--storagectl', 'SATA', '--port', 2, '--device', 0, '--type', 'hdd', '--medium', './storage/home_disk3.vmdk']
      end
    end
	
    home.vm.provision "Home", type: "ansible" do |ansible|
      ansible.playbook = "roles/home.yml"
	  ansible.raw_ssh_args = "-C -o ControlMaster=no -o ControlPersist=60s -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
    end
  end
  
  config.vm.define "server1" do |server1|
    server1.vm.hostname = "server1"
    server1.vm.network "private_network", ip: "1.2.3.5"
    server1.vm.provider "virtualbox" do |vb|
      vb.name = 'lfcs-practice-exam_server1'
    end
	
    server1.vm.provision "Server1", type: "ansible" do |ansible|
      ansible.playbook = "roles/server1.yml"
	  ansible.raw_ssh_args = "-C -o ControlMaster=no -o ControlPersist=60s -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
    end
  end
  
  config.vm.define "server2" do |server2|
    server2.vm.hostname = "server2"
    server2.vm.network "private_network", ip: "1.2.3.6"
    server2.vm.provider "virtualbox" do |vb|
      vb.name = 'lfcs-practice-exam_server2'
    end
	
    server2.vm.provision "Server2", type: "ansible" do |ansible|
      ansible.playbook = "roles/server2.yml"
	  ansible.raw_ssh_args = "-C -o ControlMaster=no -o ControlPersist=60s -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
    end
  end
end