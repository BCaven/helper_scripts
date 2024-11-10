#!/bin/bash

wget https://www.idiap.ch/webarchives/sites/www.idiap.ch/resource/gestures/data/BochumGestures1998.tar.gz
tar -xvzf BochumGestures1998.tar.gz
rm BochumGestures1998.tar.gz
cd BochumGestures1998/


# grab all of the things for each class

classes=`ls sih/ | sed -E 's/[a-z23]*([0-9]{2})([a-z])00R.tiff/\1/g' | sort -u`
mkdir train_sih/
for class in $classes; do
    counter=0
    mkdir train_sih/$class/
    # grab every file that matches that class
    # and add it to the new directory
    for file in `ls sih/ | grep $class | sed -E 's/.tiff//g'`; do
        cp sih/$file.tiff train_sih/$class/$counter.tiff
        counter=$(($counter+1))
    done
done
rm -rf sih/
echo "sih images done"
# and do it again for rgb

# grab all of the things for each class

classes=`ls rgb/ | sed -E 's/[a-z23]*([0-9]{2})([a-z])00R.tiff/\1/g' | sort -u`
mkdir train_rgb/
for class in $classes; do
    counter=0
    mkdir train_rgb/$class/
    # grab every file that matches that class
    # and add it to the new directory
    for file in `ls rgb/ | grep $class | sed -E 's/.tiff//g'`; do
        cp rgb/$file.tiff train_rgb/$class/$counter.tiff
        counter=$(($counter+1))
    done
done
rm -rf rgb/
echo "rgb images done"
