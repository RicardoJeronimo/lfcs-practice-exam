The script creates files to be used for the exercises at the end in comments:

# Exercises

## Archives
1. create a **.tar.gz** archive of _./playground/filepool_ and put it in _./playground/archives_.
2. create a **.tar.bzip2** archive of _./playground/filepool_ and put it in _./playground/archives_.
3. create a **.tar.xz** archive of _./playground/filepool_ and put it in _./playground/archives_.
4. create a **.cpio** archive of _./playground/filepool_ and put it in _./playground/archives_.
5. extract the **.tar.gz** archive in _./playground/extract/_, then compare the content of _./playground/extract_ with _./playground/filepool_. Delete the content of _./playground/extract_.
6. extract the **.tar.bzip2** archive in _./playground/extract/_, then compare the content of _./playground/extract_ with _./playground/filepool_. Delete the content of _./playground/extract_.
7. extract the **.tar.xz** archive in _./playground/extract/_, then compare the content of _./playground/extract_ with _./playground/filepool_. Delete the content of ./playground/extract.
8. extract the **.cpio** archive in ./playground/extract/, then compare the content of _./playground/extract with _./playground/filepool_. Leave the content of ./playground/extract to backup the _./playground/filepool_ directory.

## Find and files
1. move all the files owned by **user1** in _./playground/filepool_ to _./playground/user1_. Check the resisting files with `lsattr`.
10. compare the directories _./playground/user1_ and _./playground/user1ref_.
11. move all the files in _./playground/filepool_ with spaces in their name in _./playground/filenameswithspaces_, keeping ownership, with the `rsync --remove-source-files` command only (`find ... -exec rsync -v -o -g ...`). Copy them back to _./playground/filepool_ with the `find | xargs` commands keeping ownership too (`find ... -print0 | xargs -0 -I{} cp -a {} ...`).
12. find all the files in _./playground/filepool_ with no user, write the list in _./playground/listfile.txt_.
13. keeping the ownership, copy the files owned by **user2** in _./playground/filepool_ to _./playground/user2_ which have permission 1246.
14. compare the directories _./playground/user2_ and _./playground/user2ref_ (`diff -q`).
15. find all the files in _./playground/filepool_ owned by **user3** and newer than _./playground/filepool/user3_file2_suga1222.txt_.
16. make the list of all the files in _./playground/filepool_ owned by user3 and try to overwrite the file _./playground/user1ref/fileadded.txt_ with the list (check the `lsattr` attributes). Try to append the list.
17. find all the files in _./playground/filepool_ owned by **user3** which are readable by somebody (their owner, or their group, or anybody else). Count these files and compare with the total number of files owned by **user3**. List the files missing.
18. remove the sticky bit of files in _./playground/filepool_ owned by **user3**.
19. set the setuid bit of files in _./playground/filepool_ owned by **user3**. With `find ... \! ...`, list the files which do not have the setuid bit activated. Check their attributes with `lsattr`.
20. change the ACL on file _./playground/testacl.txt_ to give read privilege to **user1**, write privilege to **user2**. Remove the read privilege to __user1__.
21. search in _./playground/difffiles/_ one file which is different from the others.

## Groups and users
1. create a group **grp1**, then add **user1**, **user2**, **user3** to this group all in one command (`man gpasswd`).
23. make a directory _./playground/grp1dir_ owned by **grp1** and activate the **getuid** bit on it. Check the **getuid** bit by creating a file in the directory.
24. remove **user2** from group **grp1**, add it again with a different command than previously (`usermod`).
25. run _./playground/testsetuid.out_ as **user1**, then as **user2**. Set the **setuid** to 1 and then run it again as **user2**.
26. remove the execution privileges on file _./playground/testsetuid.out_ to all users. Change the ACL on file _./playground/testsetuid.out_ to give execution privilege to **grp1**, and then execute it with **user3**.

## System
1. search in _/var/log_ for the user who tried the 'sudo' command without permission.
30. grant **user1** with root privileges with no password, and add **user2** to the **sudoers** group.
31. set the number of processes **user3** can run to infinity.
32. switch the system to start at *runlevel 3* (**multi-user.target** in systemd), then switch back to *runlevel 5* (**graphical.target**). WARNING: NEVER 0 or 6.
33. create a service **myservice** from scratch that writes the date and time in */tmp/myservice.txt* both when it starts and when it stops (maybe `sleep 5` in between).
38. create a systemd timer for __myservice__ (`/lib/systemd/system/myservice.timer`, see https://opensource.com/article/20/7/systemd-timers to run it every minute). Start the timer service and add a cronjob to append the string '----------' in `/tmp/myservice.txt` every **2** minutes (`crontab -e`, and `*/2 * * * * echo ...`). Watch it with `watch cat /tmp/myservice.txt`.
34. create an **ext4** partition on a loop file image, set a label, mount it manually, and mount it automatically in */etc/fstab* with the label (`dd if=/dev/zero of=imgfile bs=1M count=100 ; losetup -f ; losetup /dev/loopX imgfile ; mkfs.ext4 /dev/loopX ; man tune2fs`).
35. add quotas to the __ext4__ partition for **user1**, check the quotas with `dd ... of=somefileX` (`man quota`).
36. create an **xfs** partition on a loop file image, set a label, mount it manually, and mount it automatically in */etc/fstab* with the label (`dd if=/dev/zero of=imgfile bs=1M count=100 ; losetup -f ; losetup /dev/loopX imgfile ; mkfs.xfs /dev/loopX ; man xfs_admin`).
37. add quotas to the **xfs** partition for **user1**, check the quotas with `dd` (`man xfs_quota`).

## Networking
1. run an http local website **mysite.com** at _/var/www/mysite/index.html_ on **port 54321** (changes in _/etc/hosts_, _/etc/apache2/apache2.conf_, _/etc/apache2/ports.conf_, _/etc/apache2/sites-available/mysite_, and _/etc/apache2/sites-enabled/mysite_ symlink. See for example https://youtu.be/KP5F1Leu8S8). Check with `lynx -dump localhost:54321` and `lynx -dump mysite.com`.
40. run a docker http website on **port 12345** at _~/html/docker/index.html_ (`docker run -dti --name ? -p ??:80 -v ??:/usr/local/apache2/htdocs/ httpd`). Delete the container and create the same one with a restart policy ('--restart' in `man docker-run`). Check with `lynx`.
41. download an **Alpine iso** image with `wget`, run a virtual machine with command `virt-install` and the iso (examples at the end of the man page. Here is one: `virt-install --name tiny --connect qemu:///session --disk size=1 --cdrom alpine-standard-3.14.2-x86.iso`), clone it with `virt-clone`, list it with `virsh`, stop it with `virsh`, start it again, destroy it, list it again, and undefine it (look for 'undefine' in `man virsh`).

## End
1. clean everything: `sudo find -type f -exec chattr -i {} \+ ; sudo rm -rf playground`.
2. repeat until done in less than 1 hour.
