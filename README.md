# 

# Image processing scripts description:

Images processing scripts are using mogrify as an image processor. To not execute the image processing each time, the comparison files are created that display the list of new images (new_img_list.txt) in the _assets/images/posts/fresh/ folder and the list of already processed images (old_img_list.txt) in the _assets/images/posts/ folder.

## new_images_process.sh

script checks the image lists and if new images were added to the /fresh/ folder, then they are processed. Images are resized, cropped and compressed. Also thumbnails of two sixes are created (640px and 320px width respectively)

## all_images_process.sh

will do the image process for all imges again.
    

# Other bash scripts description

## run.sh

builds website and runs the server
    
## run_prod.sh

builds website for PROD environment (see _config.yml) and runs the server

# Posts Front Matter

## tags

tags are used for getting similar articles or within a search

## keywords

keywords is the array of the key words of the post used in the context search
    
## category 

categories are used for countries (interactive map, search and menu)
    
## thumbnail

path to related to post thumbnail (640 px in width) images - used on pages with lists of posts
    
## thumbsmall

path to related to post thumbnail (320 px in width) images - used on related articles widget
    
## capsule

can have two values _new_ or _found_ - then the capsule bage is shown on the blog article, showing if the treasure capsule was applied or has been already found

## pdfguide

name of the pdf file of the pocket guide
    
## menu

used for posts - making the related menu item active (to be developed)

# Categories

Categories are used for countries only. Each new country should be added to the /category/ folder as an empty file. The include "destinations-map.html" should be updated as well.
