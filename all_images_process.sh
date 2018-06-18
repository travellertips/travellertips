#bash

#cd _assets/images/posts/maps

#mogrify -resize 1200x675 -gravity Center -crop 1200x675+0+0 +repage *.*

cd _assets/images/posts

### Check if there any new images

DIR_TO_CHECK='fresh'

### Lowecase all files
cd $DIR_TO_CHECK
for i in *; do mv "$i" "$(echo $i|tr A-Z a-z)"; done
cd ../
 
OLD_STAT_FILE='/Users/Greg/Documents/Greg/Projects/travellertips/new_img_check.txt'
 
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
    
    for img in *.*
    do
        NAME=`echo "${img%.*}" | awk '{print tolower($0)}'`
        EXT=`echo "${img##*.}" | awk '{print tolower($0)}'`
        mv "$img" "$NAME.$EXT"
    done

    cwd=$(pwd)

    ### set all images for posts to a standard size

    if [[ "$f" != *"_mix"* ]] && [[ "$f" != *"_top"* ]]
    then
        echo "Processing $f"
        mogrify -strip -interlace Plane -gaussian-blur 0.03 -resize '1200' -unsharp 0x1 -quality 75 -density 72x72 -units pixelsperinch -gravity Center -crop 1200x845+0+0 +repage $f 
    fi

    rm -r thumbnails650/*

    cp "$cwd"/* "thumbnails650"

    # Creating thumbnails 650

    echo "Creating thumbnails 650x"

    cd thumbnails650
    thumb='-thumb.' #postfix for rename

    for f in `cat $PROCEED_LIST`
    do
        echo "Processing thumbnail of $f"
        cp ../fresh/$f .

        ### rename thumbnails files
        mv "$f" "${f%.*}$thumb${f##*.}"

        ### resize all thumbnails
        mogrify -strip -interlace Plane -gaussian-blur 0.02 -resize '650' -unsharp 0x1 -quality 85 -density 72x72 -units pixelsperinch -gravity Center -crop 650x365+0+0 +repage ${f%.*}$thumb${f##*.}
    done

    cd ../
    
    # Creating thumbnails 320

    echo "Creating thumbnails 320x"

    cd thumbnails320
    thumb='-thumb.' #postfix for rename

    for f in `cat $PROCEED_LIST`
    do
        echo "Processing thumbnail of $f"
        cp ../fresh/$f .

        ### rename thumbnails files
        mv "$f" "${f%.*}$thumb${f##*.}"

        ### resize all thumbnails
        mogrify -strip -interlace Plane -gaussian-blur 0.02 -resize '320' -unsharp 0x1 -quality 85 -density 72x72 -units pixelsperinch -gravity Center -crop 320x180+0+0 +repage ${f%.*}$thumb${f##*.}
    done

    cd ../
    
    echo $NEW_STAT > $OLD_STAT_FILE

fi

cd ../../../

jekyll build
bundle exec jekyll serve --livereload
