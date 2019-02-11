#!/bin/bash

##Pass the directories in arguements that you would like to watch for rar files
echo "$(date): Starting Extractor"


#Get RAR Archives
#Test the archive
#If passed continue
#Get List of files and check if they exist
#If they pass skip archive
#If they dont extract file

function is_valid()
{
        extract_dir=`dirname $1`
        if [ -f $extract_dir/.extracted ];
        then
                return 1
        fi
        lsar -test $1 >> /dev/null
        return $?
}
function isExtracted(){
        local file
        extract_dir=`dirname $1`
        files=`lsar  $1 | awk '{if(NR>1)print}'`
        count=0
        found_count=0
        for file in $files;
        do
                ((count++))
                if [ -f $(dirname $1)/$file ];
                then
                        ((found_count++))
                fi
        done
        #Send Result
        if [ $count -eq $found_count ];
        then
                touch $extract_dir/.extracted
                return 0
        else
                return 1
        fi

}
function extract()
{
        extract_dir=`dirname $1`
        unar -o "$extract_dir" $1
        if [ $? -eq 0 ];
        then
                touch $extract_dir/.extracted
        fi
}

while true;
do
        for watch_dir in "$@";
        do
                archives=`find $watch_dir -name *.rar`
                for file in $archives;
                do
                        if is_valid $file;
                        then
                                if ! isExtracted $file
                                then
                                        extract $file
                                else
                                        echo Skipping $file
                                fi
                        fi

                done
        done
        sleep 5
done

