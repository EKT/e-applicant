#!/bin/sh
echo "Begin Processing"

for arg in $(ls -1)
do

echo "Processing Directory $arg"

         if [ -d $arg ]; then

                 if [ ! -d $arg/1 ]; then
                         mkdir $arg/1
                 fi

                 cd $arg
                 find . -maxdepth 1 -type f -exec mv {} 1 \;
                 cd ..

         fi
done

