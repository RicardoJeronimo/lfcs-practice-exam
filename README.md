The purpose of this project is to provide a practice environment to use in studying for the Linux Foundations Certified Systems Adminstrator Exam

Prerequisites
-----------------
You need the following installed on your Mac, Windows or Linux computer:
* Ansible
* VirtualBox


* In VirtualBox a private "vboxnet" network will be created and a "Host-only Adapter" will be configured as the 2nd network adapter on each virtual machine. Each server's ip address will be automatically convigured as follows:
  * home: 1.2.3.4
  * server1: 1.2.3.5
  * server2: 1.2.3.6
* Perform all actions on home unless asked to ssh into another server. Always return to home-1 after completing tasks on other servers.
* The password for the root user is "vagrant"
* The following programs are installed for your convenience and they are not guaranteed to be automatically installed on the exam and in general as of this writing they are not installed by default on CentOS 7. But it has been reported that there is not much you should have to install on the exam.

  | Program Name | Package Name           |
  | ------------ | ------------           |
  | lsof         | lsof                   |
  | tree         | tree                   |
  | elinks       | elinks                 |
  | dig          | bind-utils             |
  | nslookup     | bind-utils             |
  | route        | net-tools              |
  | netstat      | net-tools              |
  | semanage     | policycoreutils-python |
  | traceroute   | traceroute             |


Instructions
-----------------
### Linux
- Clone the repository:
```
git clone https://github.com/RicardoJeronimo/lfcs-practice-exam
```
- Run Vagrant:
```
vagrant up
```

### Windows
- Clone the repository inside your Cygwin user's home directory
```
git clone https://github.com/RicardoJeronimo/lfcs-practice-exam
```
- Copy scripts to their destination
```
cp cygwin/ansible-playbook.bat C:/cygwin64
cp cygwin/ansible-playbook-winpath.sh C:/cygwin64/usr/local/bin
```
- Edit the aforementioned files and change the Cygwin path variables if necessary
- Add `C:\cygwin64\ansible-playbook.bat` to your Windows PATH
- Run Vagrant:
```
vagrant up
```