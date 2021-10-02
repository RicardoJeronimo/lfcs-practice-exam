The script creates files to be used for the exercises at the end in comments:

# Exercises

## Archives
1. create a .tar.gz archive of ./playground/filepool and put it in ./playground/archives
2. create a .tar.bzip2 archive of ./playground/filepool and put it in ./playground/archives
3. create a .tar.xz archive of ./playground/filepool and put it in ./playground/archives
4. create a .cpio archive of ./playground/filepool and put it in ./playground/archives
5. extract the .tar.gz archive in ./playground/extract/, then compare the content of ./playground/extract with ./playground/filepool. Delete the content of ./playground/extract
6. extract the .tar.bzip2 archive in ./playground/extract/, then compare the content of ./playground/extract with ./playground/filepool. Delete the content of ./playground/extract
7. extract the .tar.xz archive in ./playground/extract/, then compare the content of ./playground/extract with ./playground/filepool. Delete the content of ./playground/extract
8. extract the .cpio archive in ./playground/extract/, then compare the content of ./playground/extract with ./playground/filepool. Leave the content of ./playground/extract to backup the ./playground/filepool directory

## Find and files
9. move all the files owned by user1 in ./playground/filepool to ./playground/user1
10. compare the directories ./playground/user1 and ./playground/user1ref
11. move all the files in ./playground/filepool with spaces in there name in ./playground/filenameswithspaces, keeping ownership, with the `rsync --remove-source-files` command only (`find ... -exec rsync -v -o -g ...`). Copy them back to ./playground/filepool with the find/xargs commands keeping the ownership too (`find ... -print0 | xargs -0 -I{} cp -a {} ...`)
12. find all the files in ./playground/filepool with no user, write the result in ./playground/listfile.txt
13. keeping the ownership, copy the files from user2 in ./playground/filepool to ./playground/user2 which have permission 1246
14. compare the directories ./playground/user2 and ./playground/user2ref
15. find all the files in ./playground/filepool owned by user3 and newer than ./playground/filepool/user3_file2_suga0000.txt
16. make the list of all the files in ./playground/filepool owned by user3 and overwrite the file ./playground/user1ref/fileadded.txt with the list (check the lsattr attributes)
17. find all the files in ./playground/filepool owned by user3 which are executable by somebody (their owner, or their group, or anybody else)
18. remove all the sticky bits of files in ./playground/filepool owned by user3
19. set all the setuid bit of files in ./playground/filepool owned by user3. Check the 'resisting' files with lsattr.
20. change the ACL on file ./playground/testacl.txt to give read privilege to user1, write privilege to user2

## Groups and users
21. create a group grp1, then add user1, user2, user3 to this group all in one command (`man gpasswd`)
23. make a directory ./playground/grp1dir owned by grp1 and activate the getuid bit on it. Check the getuid bit by creating a file in the directory
24. remove user2 from group grp1, add it again with a different command than previously (`usermod`)
25. run ./playground/testsetuid.out as user1, then as user2. Set the setuid to 1 and then run it again as user2
26. remove the execution privileges on file ./playground/testsetuid.out to all users. Change the ACL on file ./playground/testsetuid.out to give execution privilege to grp1, and then execute it with user3

## System
26. search in /var/log for the user who tried the 'sudo' command without permission
30. grant user1 with root privileges with no password, and add user2 to the sudoers group
31. set the number of processes user3 can run to infinity
32. switch the system to start at runlevel 3 (multi-user.target in systemd), then switch back to runlevel 5 (graphical.target). WARNING: NEVER 0 or 6
33. create a service myservice from scratch that writes the date and time in /tmp/myservice.txt both when it starts and when it stops (maybe `sleep 5` in between)
34. create an ext4 partition on a loop file image, set a label, mount it manually, and mount it automatically in /etc/fstab with the label (`dd if=/dev/zero of=imgfile bs=1M count=100 ; losetup -f ; losetup /dev/loopX imgfile ; mkfs.ext4 /dev/loopX ; man tune2fs`)
35. add quotas to the ext4 partition for user1, check the quotas with `dd ... of=somefileX` (`man quota`)
36. create an xfs partition on a loop file image, set a label, mount it manually, and mount it automatically in /etc/fstab with the label (`dd if=/dev/zero of=imgfile bs=1M count=100 ; losetup -f ; losetup /dev/loopX imgfile ; mkfs.xfs /dev/loopX ; man xfs_admin`)
37. add quotas to the xfs partition for user1, check the quotas with `dd` (`man xfs_quota`)

## Networking
34. run an http local website mysite.com at /var/www/mysite/index.html on port 54321 (changes in /etc/hosts, /etc/apache2/apache2.conf, /etc/apache2/ports.conf, /etc/apache2/sites-available/mysite, and /etc/apache2/sites-enabled/mysite symlink. See for example https://youtu.be/KP5F1Leu8S8). Check with `lynx -dump localhost:54321`
40. run a docker http website on port 12345 at ~/html/docker/index.html (`docker run -dti --name ? -p ??:80 -v ??:/usr/local/apache2/htdocs/ httpd`). Delete the container and create the same one with a restart policy ('--restart' in `man docker-run`). Check with `lynx`
41. download an Alpine iso image with wget, run a virtual machine with command virt-install and the iso (examples at the end of the man page. Here is one: `virt-install --name tiny --connect qemu:///session --disk size=1 --cdrom alpine-standard-3.14.2-x86.iso`), clone it with virt-clone, list is with virsh, stop it with virsh, start it again, destroy it, and undefine it (look at 'undefine' in `man virsh`)

## End. Repeat until done in less than 1 hour
37. clean everything: `sudo find -type f -exec chattr -i {} \+ ; sudo rm -rf playground`
