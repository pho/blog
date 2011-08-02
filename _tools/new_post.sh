echo -n "Title: "
read title
filename=_`date +%Y-%m-%d`-`python -c "print '-'.join('$title'.split(' '))"`.textile
editor _posts/$filename
echo "Saved as $filename. Remove the underscore for publish"
