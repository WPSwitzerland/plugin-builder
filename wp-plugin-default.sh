#!/bin/sh

function runPluginBuilder()
{

	# Ask for metadata of the new plugin
 	echo "Who are you (or the plugin author)?"
 	read PLUGIN_AUTHOR
 	
 	echo "What's your plugin called?"
 	read PLUGIN_NAME
 	
 	echo "In a sentence or two, what does it do?"
 	read PLUGIN_DESCRIPTION
 	
 	# Ask for some names used within the code
 	echo "What prefix specific to your plugin should be used?"
 	read PLUGIN_PREFIX
 	
	echo "What textdomain specific to your plugin should be used?"
	read TEXT_DOMAIN
	
 	echo "What author namespace should be used?"
 	read AUTHOR_NAMESPACE
 	
 	echo "What plugin namespace should be used?"
 	read PLUGIN_KEY_PASCAL_CASE

    if ! test -z "$TEXT_DOMAIN" 
    then
		git clone https://github.com/WPSwitzerland/wp-plugin-default $TEXT_DOMAIN
		rm -rf $TEXT_DOMAIN/.git $TEXT_DOMAIN/.gitignore
		mv $TEXT_DOMAIN/wp-plugin-default.php $TEXT_DOMAIN/$TEXT_DOMAIN.php	   
	else
		echo "Please define a text domain"
		exit
	fi

	# Search and replace metadata and names
    if ! test -z "$PLUGIN_AUTHOR" 
    then
		find $TEXT_DOMAIN -type f -name "*.php" -exec sed -i "s/PLUGIN_AUTHOR/$PLUGIN_AUTHOR/g" {} +
#	else

    fi

    if ! test -z "$PLUGIN_PREFIX" 
    then
    	find $TEXT_DOMAIN -type f -name "*.php" -exec sed -i "s/PLUGIN_PREFIX/$PLUGIN_PREFIX/g" {} +
#	else
		
    fi

    if ! test -z "$PLUGIN_NAME" 
    then
		find $TEXT_DOMAIN  -type f -name "*.php" -exec sed -i  "s/PLUGIN_NAME/$PLUGIN_NAME/g" {} +
#	else
		
    fi

    if ! test -z "$PLUGIN_DESCRIPTION" 
    then
    	find $TEXT_DOMAIN -type f -name "*.php" -exec sed -i "s/PLUGIN_DESCRIPTION/$PLUGIN_DESCRIPTION/g" {} +
#	else
		
    fi

    if ! test -z "$AUTHOR_NAMESPACE" 
    then
		find $TEXT_DOMAIN -type f -name "*.php" -exec sed -i "s/AUTHOR_NAMESPACE/$AUTHOR_NAMESPACE/g" {} +
#	else
		
    fi

    if ! test -z "$PLUGIN_KEY_PASCAL_CASE" 
    then
		find $TEXT_DOMAIN -type f -name "*.php" -exec sed -i "s/PLUGIN_KEY_PASCAL_CASE/$PLUGIN_KEY_PASCAL_CASE/g" {} +
#	else
		
    fi

    if ! test -z "$AUTHOR_NAMESPACE" 
    then
		find $TEXT_DOMAIN -type f -name "*.php" -exec sed -i "s/TEXT_DOMAIN/$TEXT_DOMAIN/g" {} +
#	else
		
    fi

}

echo
runPluginBuilder 
echo "You are good to go!"









