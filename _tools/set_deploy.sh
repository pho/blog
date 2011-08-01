#!/bin/bash
# If you are hosting your site in a different machine that the one which
# runs your git repo, this script will help you to deploy easily your
# Jekyll powered site/blog/thing
#
#																																~pho


function create_deploy(){	
		echo -n "Host where you are hosting the site: "
		read host
		echo "REMINDER: You have to configure your ssh login on that machine using a pair of rsa-keys"
		echo -n "Absolute path to jekyll dest dir: "
		read dest

		origin=`git remote -v | grep fetch | head -n 1 | cut  -f 2 | cut -d " " -f 1`
		echo -n "Detected origin: $origin. Its OK? [Y/N] "
		while read answer
			do
				if [[ $answer =~ [nNyY] ]];	then
					break;
				else
						echo -n "Detected origin: $origin. Its OK? [Y/N] ";
				fi
		done

		if [[ $answer =~ [nN] ]]; then
			echo -n "Type the git clone address: "
			read origin
		fi

		echo -n "Creating the deploy script... "
		echo "ssh $host \"cd /tmp/; git clone $origin jekyll-tmp; cd /tmp/jekyll-tmp; jekyll $dest; rm -fr /tmp/jekyll-tmp\"" > _tools/deploy.sh
		chmod +x _tools/deploy.sh
		echo "done"
}

if [ -d .git ]; then 
#Check that we are at the root of the project

if [ -f _tools/deploy.sh ]; then
	echo "There is an existing deploy script created."
	echo -n "If you continue, it will be overwrited. Continue? [Y/N] "
	read answer
	if [[ $answer == [yY] ]]; then
		create_deploy
	fi
else
	create_deploy
fi

echo -n "Do you want to add the deploy script to the .gitignore? [Y/N] "
while read answer
	do
		if [[ $answer =~ [nNyY] ]];	then
			break;
		else
				echo -n "Do you want to add the resultant script to the .gitignore? [Y/N] "
		fi
done

if [[ $answer =~ [yY] ]]; then
	echo "_tools/deploy.sh" >> .gitignore
fi


echo -n "Do you want to add an alias for this script as \"git deploy\" on .git/config? [Y/N] "
while read answer
	do
		if [[ $answer =~ [nNyY] ]];	then
			break;
		else
				echo -n "Do you want to add an alias for this script as \"git deploy\" on .git/config? [Y/N] "
		fi
done

if [[ $answer =~ [yY] ]]; then
	echo "[alias]" >> .git/config
	echo "	deploy = !git push origin master && _tools/deploy.sh" >> .git/config
fi

else
	echo "This script is meant to be runned from the git project root dir"
fi

