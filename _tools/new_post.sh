echo -n "Title: "
read title
filename=`date +%Y-%m-%d`-`python -c "print '-'.join('$title'.split(' '))"`.textile
if [[ -f _posts/$filename ]]; then
	editor _posts/$filename
else
	editor _posts/_$filename
	echo "Saved draft as _$filename. Remove the underscore for publish"
	echo "REMEMBER: Add it to the git tree if you want to edit the file in another computer"
fi
