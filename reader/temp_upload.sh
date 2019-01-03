#!/bin/bash

# Read in Temperature by Ruby
value=$(sudo /usr/bin/ruby /home/pi/read_temp.rb)

# Old
#echo "$value" | cat - /var/www/html/index.html > tt && mv tt /var/www/html/index.html

# Remove First Five Lines of HTML with insert the picture
sed -i '1,5d' /var/www/html/index.html 

# Get the right order of the values and store new value into tt temp file
echo "$value" | cat - /var/www/html/index.html > tt 

# Concat Picture code and tt in to index.html
cat pic_html tt > /var/www/html/index.html

# Delete tt temp file
rm -f tt
