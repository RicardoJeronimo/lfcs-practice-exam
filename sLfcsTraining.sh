#!/bin/bash

read -p "Run in say ~/some_dir_on_purpose/. Users user1, user2, user3, and user4 will be deleted and recreated. Proceed? (press ^C to exit)"

# alias delall='sudo find -type f -exec chattr -ia {} \+ ; sudo rm -rf playground ; sudo rm -rf playground/ ; sudo ~/bin/sLfcsTraining.sh'

if [ ! -e ./playground/filepool ]; then
    mkdir -p ./playground/filepool
    chmod 0777 ./playground
    chmod 0777 ./playground/filepool
fi

cd ./playground/filepool

for user in user1 user2 user3 user4
do
    # Add user
    userdel -r $user # delete the user if it already exists
    #useradd -m -k /etc/skel -s /bin/bash $user # (re)create the user
    useradd -m -k /etc/skel -s /bin/bash $user -p 'U6aMy0wojraho' # (re)create the user with the empty string as a password (the string U6aMy0wojraho is the hash of an empty string)
    #passwd -d $user # no password

    # Create files

    j=0 # some files will have an attribute
    maxseq=6

    for i in $(seq 2)
    do

        for perm1 in 1 2 4 #$(seq 0 2 $maxseq) # setuid, getuid, and sticky bit
        do

            for perm2 in $(seq 2 2 $maxseq) # user permission
            do

                for perm3 in $(seq 2 2 $maxseq) # group permission
                do

                    for perm4 in $(seq 2 2 $maxseq) # other permission
                    do
                        #echo "Creating file ${user}_file${i}_suga${perm1}${perm2}${perm3}${perm4}.txt"
                        echo ${user}file${i}s${perm1}u${perm2}g${perm3}a${perm4} > ${user}_file${i}_suga${perm1}${perm2}${perm3}${perm4}.txt
                        #echo "${perm1}${perm2}${perm3}${perm4} ${user}_file${i}_suga${perm1}${perm2}${perm3}${perm4}.txt"
                        chmod ${perm1}${perm2}${perm3}${perm4} ./${user}_file${i}_suga${perm1}${perm2}${perm3}${perm4}.txt
                        chown $user:$user ${user}_file${i}_suga${perm1}${perm2}${perm3}${perm4}.txt
			ls -aFhl ${user}_file${i}_suga${perm1}${perm2}${perm3}${perm4}.txt
                        j=$((j+1))
                        if [[ $j -eq 10 ]]; then
                            j=0
                            chattr +i ${user}_file${i}_suga${perm1}${perm2}${perm3}${perm4}.txt
                        fi
                    done
                done
            done
        done
    done
    echo "Done with $user."

    echo 'file name with spaces' > "${user}filename with spaces" # to train with xargs
    chown $user:$user "${user}filename with spaces"
    
    if [ $user == user4 ] ; then
        runuser -l  user4 -c 'sudo systemctl daemon-reload' # to trigger a record in /var/log
        userdel -r $user # delete the user to train finding files belonging to no user
    fi

done

cd ../..

if [ ! -e ./playground/user1ref ]; then
    echo 'create ./playground/user1ref'
    mkdir -p ./playground/user1ref
    chmod 0777 ./playground/user1ref
    chown user1:user1 ./playground/user1ref
    #echo $(ls ./playground/user1ref)
else
    echo 'user1ref exists'
fi

echo 'file added' > ./playground/user1ref/fileadded.txt
chattr +a ./playground/user1ref/fileadded.txt
find ./playground/filepool -user user1 -exec cp -a {} ./playground/user1ref \;
echo 'file modified' > ./playground/user1ref/user1_file10_suga0000.txt
#echo $(ls ./playground/user1ref)

touch ./playground/testsetuid.txt
chmod 644 ./playground/testsetuid.txt
echo "#include <stdio.h>
#include <stdlib.h>
int main(int argc, char *argv[]){
FILE *fptr = fopen(\"testsetuid.txt\", \"a\");
fprintf(fptr,\"Triggers a segmentation fault if not ran by the owner or setuid bit not set to 1. \");
fclose(fptr);
}" > ./playground/testsetuid.c

gcc ./playground/testsetuid.c -o ./playground/testsetuid.out
chown user1:user1 ./playground/testsetuid.*

touch ./playground/testacl.txt
chmod 600 ./playground/testacl.txt
#chown user1 ./playground/testacl.txt

if [ ! -e ./playground/user2ref ]; then
    echo 'create ./playground/user2ref'
    mkdir -p ./playground/user2ref
    chmod 0777 ./playground/user2ref
fi

find ./playground/filepool -perm 1246 -user user2 -exec cp -a {} ./playground/user2ref \;

#if [ ! -e ./playground/filepool/archives ]; then
#    echo 'create ./playground/filepool/archives'
#    mkdir -p ./playground/filepool/archives
#    chmod 0777 ./playground/filepool/archives
#fi

if [ ! -e ./playground/extract ]; then
    echo 'create ./playground/extract'
    mkdir -p ./playground/extract
    chmod 0777 ./playground/extract
fi

if [ ! -e ./playground/filenameswithspaces ]; then
    echo 'create ./playground/filenameswithspaces'
    mkdir -p ./playground/filenameswithspaces
    chmod 0777 ./playground/filenameswithspaces
fi

if [ ! -e ./playground/user2 ]; then
    echo 'create ./playground/user2'
    mkdir -p ./playground/user2
    chmod 0777 ./playground/user2
fi

if [ ! -e ./playground/archives ]; then
    echo 'create ./playground/archives'
    mkdir -p ./playground/archives
    chmod 0777 ./playground/archives
fi


# Exercises

## Archives
# 1. create a .tar.gz archive of ./playground/filepool and put it in ./playground/archives
# 2. create a .tar.bzip2 archive of ./playground/filepool and put it in ./playground/archives
# 3. create a .tar.xz archive of ./playground/filepool and put it in ./playground/archives
# 4. create a .cpio archive of ./playground/filepool and put it in ./playground/archives
# 5. extract the .tar.gz archive in ./playground/extract/, then compare the content of ./playground/extract with ./playground/filepool. Delete the content of ./playground/extract
# 6. extract the .tar.bzip2 archive in ./playground/extract/, then compare the content of ./playground/extract with ./playground/filepool. Delete the content of ./playground/extract
# 7. extract the .tar.xz archive in ./playground/extract/, then compare the content of ./playground/extract with ./playground/filepool. Delete the content of ./playground/extract
# 8. extract the .cpio archive in ./playground/extract/, then compare the content of ./playground/extract with ./playground/filepool. Leave the content of ./playground/extract to backup the ./playground/filepool directory

## Find and files
# 9. move all the files owned by user1 in ./playground/filepool to ./playground/user1
# 10. compare the directories ./playground/user1 and ./playground/user1ref
# 11. move all the files in ./playground/filepool with spaces in there name in ./playground/filenameswithspaces, keeping ownership, with the `rsync --remove-source-files` command only (`find ... -exec rsync -v -o -g ...`). Copy them back to ./playground/filepool with the find/xargs commands keeping the ownership too (`find ... -print0 | xargs -0 -I{} cp -a {} ...`)
# 12. find all the files in ./playground/filepool with no user, write the result in ./playground/listfile.txt
# 13. keeping the ownership, copy the files from user2 in ./playground/filepool to ./playground/user2 which have permission 1246
# 14. compare the directories ./playground/user2 and ./playground/user2ref
# 15. find all the files in ./playground/filepool owned by user3 and newer than ./playground/filepool/user3_file2_suga0000.txt
# 16. make the list of all the files in ./playground/filepool owned by user3 and overwrite the file ./playground/user1ref/fileadded.txt with the list (check the lsattr attributes)
# 17. find all the files in ./playground/filepool owned by user3 which are executable by somebody (their owner, or their group, or anybody else)
# 18. remove all the sticky bits of files in ./playground/filepool owned by user3
# 19. set all the setuid bit of files in ./playground/filepool owned by user3. Check the 'resisting' files with lsattr.
# 20. change the ACL on file ./playground/testacl.txt to give read privilege to user1, write privilege to user2

## Groups and users
# 22. create a group grp1, then add user1, user2, user3 to this group all in one command (`man gpasswd`)
# 23. make a directory ./playground/grp1dir owned by grp1 and activate the getuid bit on it. Check the getuid bit by creating a file in the directory
# 24. remove user2 from group grp1, add it again with a different command than previously (`usermod`)
# 25. run ./playground/testsetuid.out as user1, then as user2. Set the setuid to 1 and then run it again as user2
# 26. remove the execution privileges on file ./playground/testsetuid.out to all users. Change the ACL on file ./playground/testsetuid.out to give execution privilege to grp1, and then execute it with user3

## System
# 29. search in /var/log for the user who tried the 'sudo' command without permission
# 30. grant user1 with root privileges with no password, and add user2 to the sudoers group
# 31. set the number of processes user3 can run to infinity
# 32. switch the system to start at runlevel 3 (multi-user.target in systemd), then switch back to runlevel 5 (graphical.target). WARNING: NEVER 0 or 6
# 33. create a service myservice from scratch that writes the date and time in /tmp/myservice.txt both when it starts and when it stops (maybe `sleep 5` in between)
# 34. create an ext4 partition on a loop file image, set a label, mount it manually, and mount it automatically in /etc/fstab with the label (`dd if=/dev/zero of=imgfile bs=1M count=100 ; losetup -f ; losetup /dev/loopX imgfile ; mkfs.ext4 /dev/loopX ; man tune2fs`)
# 35. add quotas to the ext4 partition for user1, check the quotas with `dd ... of=somefileX` (`man quota`)
# 36. create an xfs partition on a loop file image, set a label, mount it manually, and mount it automatically in /etc/fstab with the label (`dd if=/dev/zero of=imgfile bs=1M count=100 ; losetup -f ; losetup /dev/loopX imgfile ; mkfs.xfs /dev/loopX ; man xfs_admin`)
# 37. add quotas to the xfs partition for user1, check the quotas with `dd` (`man xfs_quota`)

## Networking
# 39. run an http local website mysite.com at /var/www/mysite/index.html on port 54321 (changes in /etc/hosts, /etc/apache2/apache2.conf, /etc/apache2/ports.conf, /etc/apache2/sites-available/mysite, and /etc/apache2/sites-enabled/mysite symlink. See for example https://youtu.be/KP5F1Leu8S8). Check with `lynx -dump localhost:54321`
# 40. run a docker http website on port 12345 at ~/html/docker/index.html (`docker run -dti --name ? -p ??:80 -v ??:/usr/local/apache2/htdocs/ httpd`). Delete the container and create the same one with a restart policy ('--restart' in `man docker-run`). Check with `lynx`
# 41. download an Alpine iso image with wget, run a virtual machine with command virt-install and the iso (examples at the end of the man page. Here is one: `virt-install --name tiny --connect qemu:///session --disk size=1 --cdrom alpine-standard-3.14.2-x86.iso`), clone it with virt-clone, list is with virsh, stop it with virsh, start it again, destroy it, and undefine it (look at 'undefine' in `man virsh`)

## End. Repeat until done in less than 1 hour
# 42. clean everything: `sudo find -type f -exec chattr -i {} \+ ; sudo rm -rf playground`
