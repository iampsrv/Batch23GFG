#!/bin/bash

#Specify folders whose backup is to be taken in variables
f1="folder_location_1"
f2="folder_location_2"
f3="folder_location_3"

#tar = Tape Archive tool for compression
#Creating same backup tar file for all specified folders
tar -cvf /backupfolder/backup.tar $f1 $f2 $f3

#Go to the backup folder location
cd /backupfolder

#Show the size of the folder
du -sh