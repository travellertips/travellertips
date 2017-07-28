#bash

cd _assets/images/posts

### Check if there any new images

DIR_TO_CHECK='fresh'
 
OLD_STAT_FILE='../../../new_img_check.txt'
 
if [ -e $OLD_STAT_FILE ]
    then
        OLD_STAT=`cat $OLD_STAT_FILE`
    else
        OLD_STAT="nothing"
fi
 
NEW_STAT=`find $DIR_TO_CHECK -type f -exec ls -l {} \; | awk '{sum += $5} END {print sum}' `
 
if [ "$OLD_STAT" != "$NEW_STAT" ]
then

    rm *

    cp fresh/* .

    cwd=$(pwd)

    ### set all images for posts to a standard size

    mogrify -strip -interlace Plane -gaussian-blur 0.05 -resize 1600x900 -unsharp 0x1 -quality 75 -density 72x72 -units pixelsperinch -gravity Center -crop 1600x900+0+0 +repage *.* 

    rm -r thumbnails/*

    cp "$cwd"/* "thumbnails"

    cd thumbnails

    thumb='-thumb.' #postfix for rename

    ### rename thumbnails files
    for file in *
    do
        NAME=`echo "${file%.*}$thumb" | awk '{print tolower($0)}'`
        mv "$file" "$NAME${file##*.}"
    done

    ### resize all thumbnails
    mogrify -strip -interlace Plane -gaussian-blur 0.02 -resize '650' -unsharp 0x1 -quality 85 -density 72x72 -units pixelsperinch -gravity Center -crop 650x365+0+0 +repage *.* 


    cd ../../../../

    echo $NEW_STAT > $OLD_STAT_FILE
fi



#jekyll build
#bundle exec jekyll serve
