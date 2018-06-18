#bash

###
##  This script monitors only fresh/ folder for adding images.
##  If images were added to posts/ folder directly they will not be processed!
##
###

#cd _assets/images/posts/maps

#mogrify -resize 1200x675 -gravity Center -crop 1200x675+0+0 +repage *.*

cd _assets/images/posts

### Check if there any new images

DIR_TO_CHECK='fresh'

### Lowecase all files
cd $DIR_TO_CHECK
for i in *; do mv "$i" "$(echo $i|tr A-Z a-z)"; done
cd ../
 
OLD_LIST_FILE='/Users/Greg/Documents/Greg/Projects/travellertips/old_img_list.txt'
NEW_LIST_FILE='/Users/Greg/Documents/Greg/Projects/travellertips/new_img_list.txt'
PROCEED_LIST='/Users/Greg/Documents/Greg/Projects/travellertips/proceed_list.txt'

ls $DIR_TO_CHECK > $NEW_LIST_FILE

# Create list of imahes to process
diff $OLD_LIST_FILE $NEW_LIST_FILE | grep -e "^>" | sed s/"> "// > $PROCEED_LIST

if [ -s "$PROCEED_LIST" ]
then

    # Processing images for posts
    for f in `cat $PROCEED_LIST`
    do
        cp fresh/$f .

        ### set all images for posts to a standard size
        if [[ "$f" != *"_mix"* ]] && [[ "$f" != *"_top"* ]]
        then
            echo "Processing $f"
            mogrify -strip -interlace Plane -gaussian-blur 0.03 -resize '1200' -unsharp 0x1 -quality 75 -density 72x72 -units pixelsperinch -gravity Center -crop 1200x845+0+0 +repage $f 
        fi
    done

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

    # Update old statistics
    ls $DIR_TO_CHECK > $OLD_LIST_FILE
    
else

    echo " --- No new images --- "

fi

