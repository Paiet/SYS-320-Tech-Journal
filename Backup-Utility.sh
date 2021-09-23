#!/bin/bash

# To backup a file, run...> bactup.sh -b archive_name filename
# To backup a dir, run ...> bactup.sh -b archive_name dir_name
# $1 is the option -b backup
# $2 is the name to save the archive as
# $3 is the file or dir you wish to backup

t_date=$(date +%H%M-%y%m%d)
bakdir="/backup"
rooted=$(whoami)

##############################################
# One-time, instant file or directory backup
##############################################

if [[ $rooted = "root" ]] && [[ $1 = "-b" ]] && [[ -e $3 ]]
then
  tar -czvf $2.backup.$t_date $3
  zippy=$2.backup.$t_date
  echo "Checking if $zippy exists already in $bakdir"
  if [ ! -e $bakdir/$zippy ]; then
      mv $zippy $bakdir
      chmod u=rw,go= $bakdir/$zippy
    echo "Backup complete"
      ls -lh $bakdir/$zippy
  else
    read -p "File: $tru_fals already exists. Overwrite? [y/n] ...>" overwriteYN
    case $overwriteYN in
        y|Y)    mv $zippy $backdir
            echo "Backup Complete"
            ls -lh $bakdir/$zippy
            ;;
        *)    echo "That's messed up! Cleaning files."
            rm $zippy
            echo "$zippy removed"
            ;;
    esac
  fi
elif [[ $rooted = "root" ]] && [[ $1 = "-r" ]] && [[ -e $2 ]] && [[ -e $3 ]]
then
  tar -zxv -f $2 -C $3
  echo "File(s) restored from backup"
elif [[ $rooted = "root" ]] && [[ $1 = "-r" ]] && [[ -e $2 ]]
then
  tar -zxv -f $2
  echo "File(s) restored from backup"
else
echo "Are you root? sudo?"
echo "Invalid Parameters?"
echo "To BACKUP: sudo ./bactup -b archive_name file/dir_name"
echo "To RESTORE: sudo ./bactup -r archive_name(full path) restore_dir(optional)"
fi
