The script creates files to be used for the exercises at the end in comments (thanks to u/7lawa for his feedback):

# Exercises

## Archives
1. create a **.tar.gz** archive of _./playground/filepool_ and put it in _./playground/archives_.
2. create a **.tar.bzip2** archive of _./playground/filepool_ and put it in _./playground/archives_.
3. create a **.tar.xz** archive of _./playground/filepool_ and put it in _./playground/archives_.
4. create a **.cpio** archive of _./playground/filepool_ and put it in _./playground/archives_.
5. list the files in the **.tar.gz** archive.
5. extract the **.tar.gz** archive in _./playground/extract/_, then compare the content of _./playground/extract_ with _./playground/filepool_. Delete the content of _./playground/extract_.
6. extract the **.tar.bzip2** archive in _./playground/extract/_, then compare the content of _./playground/extract_ with _./playground/filepool_. Delete the content of _./playground/extract_.
7. extract the **.tar.xz** archive in _./playground/extract/_, then compare the content of _./playground/extract_ with _./playground/filepool_. Delete the content of ./playground/extract.
8. extract the **.cpio** archive in ./playground/extract/, then compare the content of _./playground/extract with _./playground/filepool_. Leave the content of ./playground/extract to backup the _./playground/filepool_ directory.

## Find and files
1. move all the files owned by **user1** in _./playground/filepool_ to _./playground/user1_. Check the resisting files with `lsattr`.
10. compare the directories _./playground/user1_ and _./playground/user1ref_.
11. move all the files in _./playground/filepool_ with spaces in their names in _./playground/filenameswithspaces_, keeping ownership, with the `rsync --remove-source-files` command only (`find -name "* *" -exec rsync -v -o -g --remove-source-files {} destdir/ \;`). Copy them back to _./playground/filepool_ with the `find | xargs` commands keeping ownership too (`find -name "* *" -print0 | xargs -0 -I{} cp -a {} destdir/`).
12. find all the files in _./playground/filepool_ with no user, write the list in _./playground/listfile.txt_.
13. keeping the ownership, copy the files owned by **user2** in _./playground/filepool_ to _./playground/user2_ which have permission 1246.
14. compare the directories _./playground/user2_ and _./playground/user2ref_ (`diff -q`).
15. find all the files in _./playground/filepool_ owned by **user3** and newer than _./playground/filepool/user3_file2_sugo1222.txt_.
16. make the list of all the files in _./playground/filepool_ owned by user3 and try to overwrite the file _./playground/user1ref/fileadded.txt_ with the list (check the `lsattr` attributes). Try to append the list.
17. find all the files in _./playground/filepool_ owned by **user3** which are readable by somebody (their owner, or their group, or anybody else). Count these files and compare with the total number of files owned by **user3**. Long list the missing files to check.
18. remove the sticky bit of files in _./playground/filepool_ owned by **user3**.
20. set the setuid bit of files in _./playground/filepool_ owned by **user3**. With `find ... \! ...` or `find ... -not ...`, list the files which do not have the setuid bit activated. Check their attributes with `lsattr` (`for file in $(find ./playground/filepool/ -user user3 -not -perm /1000 -exec ls {} \+) ; do sudo lsattr $file ; done`).
20. change the ACL on file _./playground/testacl.txt_ to give read privilege to **user1**, write privilege to **user2**. Remove the read privilege to __user1__.
21. search in _./playground/difffiles/_ one file which is different from the others.
22. define function `echoerr(){ python -c 'import os; os.write(1, b"ok\n"); os.write(2, b"error\n")';}`, execute it printing only the stdout (`echoerr 2> /dev/null`), then only the stderr, and then overwrite|append both stdout and stderr to _./playground/stdfile.txt_ using both syntaxes `&>> file` and `>> file 2>&1`.
23. using `sed`, print only the lines from 8 to 12 included in _./playground/phonenumber.txt_ in the terminal. Still with `sed` remove lines 15 to the end of the file (`sed -i '15,??'`). Using both `sed` without option `-E` and with the option, print all the lines with a phone number (`[1-9]{3}-...`). Using `sed` without option `-E`, add parens around the area code (`xyz-` becomes `(xyz)-`) rewriting the file (option `-i`) and using `sed -E` remove the parens rewriting the file. Print all the odd-numbered lines (example in `man sed`).
24. find to which package the file `/etc/ssh/ssh_config` belongs.

## Groups and users
1. create a group **grp1**, then add **user1**, **user2**, **user3** to this group all in one command (`man gpasswd`, option `-M`).
23. make a directory _./playground/grp1dir_ owned by **grp1** and activate the **getuid** bit on it. Check the **getuid** bit by creating a file in the directory.
24. remove **user2** from group **grp1**, add it again with a different command than previously (`usermod`).
25. run _./playground/testsetuid.out_ as **user1** <span style="text-decoration: underline">in its directory</span>, then as **user2**. Set the **setuid** to 1 and then run it again as **user2**.
26. remove the execution privileges on file _./playground/testsetuid.out_ to other users and try to run it with __user3__. Change the ACL on file _./playground/testsetuid.out_ to give execution privilege to **grp1**, and then execute it with **user3** (beware of the mask: `setfacl -m m::x testsetuid.out`. The ACL hasn't absolute priority: if you remove the group execution with `chmod g-x`, the ACL won't fix it because the mask cancels the ACL).
<!-- 27. add __user3__ to the sudo group and allow __user2__ to run any command without password. -->
27. lock and then unlock __user3__.

## System
1. search in _/var/log_ for the user who tried the 'sudo' command without permission.
30. grant **user1** with root privileges with no password, and add **user2** to the **sudoers** group.
31. set the number of processes **user3** can run to infinity.
32. switch the system to start at *runlevel 3* (**multi-user.target** in systemd), then switch back to *runlevel 5* (**graphical.target**). WARNING: NEVER 0 or 6.
33. create a service **myservice** from scratch that writes the date and time in */tmp/myservice.txt* both when it starts and when it stops (maybe `sleep 5` in between).
38. create a systemd timer for __myservice__ (`/lib/systemd/system/myservice.timer`, see https://opensource.com/article/20/7/systemd-timers to run it every minute). Start the timer service and add a cronjob to append the string '----------' in `/tmp/myservice.txt` every **2** minutes (`crontab -e`, and `*/2 * * * * echo ...`). Watch it with `watch tail /tmp/myservice.txt`.
34. create an **ext4** partition on a loopfile image, set a label, mount it manually, and mount it automatically in */etc/fstab* with the label (`dd if=/dev/zero of=imgfile bs=1M count=100 ; losetup -f ; losetup /dev/loopX imgfile ; mkfs.ext4 /dev/loopX ; man tune2fs`).
35. add quotas to the __ext4__ partition for **user1**, check the quotas with `dd ... of=somefileX` (`man quota`).
36. create an **xfs** partition on a loopfile image, set a label, mount it manually, and mount it automatically in */etc/fstab* with the label (`dd if=/dev/zero of=imgfile bs=1M count=100 ; losetup -f ; losetup /dev/loopX imgfile ; mkfs.xfs /dev/loopX ; man xfs_admin`).
37. add quotas to the **xfs** partition for **user1**, check the quotas with `dd` (`man xfs_quota`).

## Networking
1. run an http local website **mysite.com** at _/var/www/mysite/index.html_ on **port 54321** (changes in _/etc/hosts_, _/etc/apache2/apache2.conf_, _/etc/apache2/ports.conf_, _/etc/apache2/sites-available/mysite_, and _/etc/apache2/sites-enabled/mysite_ symlink. See for example https://youtu.be/KP5F1Leu8S8). Check with `lynx -dump localhost:54321` and `lynx -dump mysite.com`.
40. run a docker http website on **port 12345** at _~/html/docker/index.html_ (`docker run -dti --name ? -p ??:80 -v ??:/usr/local/apache2/htdocs/ httpd`). Delete the container and create the same one with a restart policy ('--restart' in `man docker-run`). Check with `lynx`.
41. download an **Alpine iso** image with `wget`, run a virtual machine with command `virt-install` and the iso (examples at the end of the man page. Here is one: `virt-install --name tiny --connect qemu:///session --disk size=1 --cdrom alpine-standard-3.14.2-x86.iso`), clone it with `virt-clone`, list it with `virsh`, stop it with `virsh`, start it again, destroy it, list it again, and undefine it (look for 'undefine' in `man virsh`).

## Raid, Lvm, and crypto
1. make four image files, potentially with different sizes: `dd if=/dev/zero of=./imagefileX bs=1M count=100`.
2. link them to loop partitions: `losetup --find --show imagefileX`.
2. format the partitions for LVM: `fdisk /dev/loopX`, `p`, `n`, `enter`, `enter`, `enter`, `t`, `8e`, `w`.
3. declare four physical volumes: `pvcreate /dev/loopXp1 /dev/loopX+1p1 /dev /dev/loopX+2p1 /dev/loopX+3p1`.
4. make a virtual group with the four physical volumes: `vgcreate myvg /dev/loopX ...`.
5. split the virtual group in four logical volumes with **same** size: retrieve the number of physical extents (PEs) with `vgdisplay | grep myvg "Total PE"` and divide this number n by 4 to create the LVs with `lvcreate myvg --name mylv1 -l n/4 ; lvcreate myvg --name mylv2 -l n/4 ; ...`.
6. format the logical volumes for Raid: `fdisk /dev/myvg/mylvX`, `p`, `n`, `enter`, `enter`, `enter`, `t`, `fd`, `w`. It may take to run `partprobe` to refresh the partition table.
7. make two Raid0 with the four logical volumes: `mdadm --create /dev/md0 --level=0 --raid-devices=2 /dev/myvg/mylv1 /dev/myvg/mylv2 ; ... /dev/md1 ...`
8. format the Raid0 partitions for LVM: `fdisk /dev/mdX`, ..., `8e`.
9. make a physical volume with each Raid0 partition: `pvcreate /dev/mdXp1 /dev/mdX+1p1`
10. make a virtual group with the physical Raid0 volumes: `vgcreate myraidvg /dev/md0p1 /dev/md1p1`
11. split the virtual group into two logical volumes of same size: `lvcreate myraidvg --name myraidlv1 -l 50%FREE ; lvcreate myraidvg --name myraidlv2 -l 100%FREE`.
12. format the logical volumes for Raid: `fdisk /dev/myraidvg/myraidlvX`. It may take to run `partprobe` to refresh the partition table.
13. make one Raid1 with the two logical volumes: `mdadm --create /dev/mdY --level=1  --raid-devices=2 /dev/myraidvg/myraidlv1 /dev/myraidvg/myraidlv2`.
14. make a crypo partition with the Raid1 partition: `cryptsetup luksFormat /dev/mdY`.
15. open it: `cryptsetup luksOpen /dev/mdY crytoraid`.
16. format it in ext4: `mkfs -t ext4 /dev/mapper/crytoraid`.
17. mount it at `/secret`: `mount /dev/mapper/cryptoraid /secret`.
18. make a crypto file: `echo 'cryptotest' > /secret/cryptofile`.
19. unmount the crypto partition, close it, reopen it under a different name, remount it and check the file: `umount /secret ; cryptsetup luksClose crytoraid ; cryptsetup luksOpen /dev/mdY othername ; mount /dev/mapper/othername /secret ; cat /secret/cryptofile`.
1. make a swapfile and mount it, both manually and with `mount -a`.
2. make a crypto swapfile and mount it, both manually and with `mount -a`.
3. make a crypto partition on a simple image file and mount it, both manually and with `mount -a`.
4. make a simple Raid1, and mount it both manually and with `mount -a`.
5. make a simple logical volume, and mount it both manually and with `mount -a`.
6. clean the `/etc/fstab` file.

## End
1. clean everything: `sudo find -type f -exec chattr -i {} \+ ; sudo rm -rf playground`.
2. repeat until confident.

-----

# Other resources
## Find
 - https://geekflare.com/linux-find-commands/
 - https://www.tecmint.com/35-practical-examples-of-linux-find-command/

## Awk
- http://evc-cit.info/cit052/awk_tutorial.html

## Other commands
- http://evc-cit.info/cit052/
- remaking the workshop archive manually: https://www.csc.fi/documents/200270/272439/Linux-command-line-exercises_Linux%2BCSC-Quick-Reference.pdf/0d3d1813-238a-4aed-a1e3-1a3d57a243f3
- https://devconnected.com/30-linux-processes-exercises-for-sysadmins/

## AppArmor
- https://medium.com/information-and-technology/so-what-is-apparmor-64d7ae211ed

## Xfs labeling and quotas
- https://medium.com/shehuawwal/how-to-label-ext4-and-xfs-file-system-in-linux-356f56e4cae2
- https://www.golinuxcloud.com/configure-enable-disable-xfs-quota-grace-time/
- non xfs quotas: http://www.yolinux.com/TUTORIALS/LinuxTutorialQuotas.html

## Virsh undefine
- https://bobcares.com/blog/virsh-command-to-delete-a-vm/
- https://serverfault.com/questions/363674/managing-qcow2-images-with-virsh

## Run a command as another user
- https://www.cyberciti.biz/open-source/command-line-hacks/linux-run-command-as-different-user/

## Forgot a docker option
- https://www.digitalocean.com/community/questions/how-to-adjust-docker-container-run-options

## Password set to an empty string
- https://unix.stackexchange.com/questions/192945/user-without-a-password-how-can-one-login-into-that-account-from-a-non-root-ac

## Working with files in C (setuid for the script)
- https://www.programiz.com/c-programming/c-file-input-output
