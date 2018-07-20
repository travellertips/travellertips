#bash

JEKYLL_ENV=production bundle exec jekyll build --config _config_prod.yml
#jekyll serve

cd _site
rm Gemfile.lock
rm manifest.json
rm package-lock.json
rm new_img_list.txt
rm new_maps_list.txt
rm old_img_list.txt
rm old_maps_list.txt
rm proceed_list.txt
rm proceed_maps_list.txt
rm all_images_process.sh
rm new_images_process.sh
rm new_maps_process.sh
rm run_prod.sh
rm run.sh
rm Gemfile