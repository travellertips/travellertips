#bash

###
##  This script monitors only fresh_maps/ folder for adding images.
##  If maps were added to maps/ folder directly they will not be processed!
##
###


cd _assets/images/posts

### Check if there any new images

DIR_TO_CHECK='maps_fresh'

### Lowecase all files
cd $DIR_TO_CHECK
for i in *; do mv "$i" "$(echo $i|tr A-Z a-z)"; done
cd ../
 
OLD_LIST_FILE='/Users/Greg/Documents/Greg/Projects/travellertips/old_maps_list.txt'
NEW_LIST_FILE='/Users/Greg/Documents/Greg/Projects/travellertips/new_maps_list.txt'
PROCEED_LIST='/Users/Greg/Documents/Greg/Projects/travellertips/proceed_maps_list.txt'

ls $DIR_TO_CHECK > $NEW_LIST_FILE

# Create list of images to process
diff $OLD_LIST_FILE $NEW_LIST_FILE | grep -e "^>" | sed s/"> "// > $PROCEED_LIST

if [ -s "$PROCEED_LIST" ]
then
    
    # Processing maps for posts
    for f in `cat $PROCEED_LIST`
    do
        cp $DIR_TO_CHECK/$f maps

        ### set all maps for posts to a standard size

        echo "Processing $f"
        #mogrify -strip -interlace Plane -gaussian-blur 0.03 -resize '780' -unsharp 0x1 -quality 75 -density 72x72 -units pixelsperinch -gravity Center -crop 780x435+0+0 +repage maps/$f 
        mogrify -strip -interlace Plane -resize '780' -unsharp 0x1 -quality 80 -density 72x72 -units pixelsperinch -gravity Center -crop 780x435+0+0 +repage maps/$f 
done

    # Update old statistics
    ls $DIR_TO_CHECK > $OLD_LIST_FILE
    
else

    echo " --- No new maps --- "

fi

