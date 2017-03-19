#!/bin/sh

function runPluginBuilder()
{

	# Ask for data
    echo "Plugin key: lowercase with underscores (e.g. 'my_plugin')"
    read PLUGIN_KEY

    if test -z "$PLUGIN_KEY"
    then
        echo "You must specify a plugin key."
        exit
    fi

    echo "Author name (e.g. 'Mark Mustermann')"
    read PLUGIN_AUTHOR

    echo "Author email address"
    read AUTHOR_EMAIL

    echo "Author URI (website address)"
    read AUTHOR_URI

    # Escape URI for regexp use within sed
    AUTHOR_URI=$(echo $AUTHOR_URI | sed -e 's/\//\\\//g')

    echo "Author's vendor name (e.g. 'CompanyName')"
    read AUTHOR_NAMESPACE

    echo "Plugin name (e.g. 'My great plugin')?"
    read PLUGIN_NAME

    echo "Plugin description"
    read PLUGIN_DESCRIPTION

    echo "Plugin URI (e.g. GitHub URL)"
    read PLUGIN_URI

    # Escape URI for regexp use within sed
    PLUGIN_URI=$(echo $PLUGIN_URI | sed -e 's/\//\\\//g')

	# Fetch the current base code from GitHub
    git clone https://github.com/WPSwitzerland/wp-plugin-default $PLUGIN_KEY
	rm -rf $PLUGIN_KEY/.git $PLUGIN_KEY/README.md
    mv $PLUGIN_KEY/wp-plugin-default.php $PLUGIN_KEY/$PLUGIN_KEY.php
    mv $PLUGIN_KEY/README_BLANK.md $PLUGIN_KEY/README.md

	# Search and replace metadata and names

    # Plugin key
    find $PLUGIN_KEY -type f -name "*.*" -exec sed -i "s/PLUGIN_KEY/$PLUGIN_KEY/g" {} +

    # Plugin prefix (for non-namespace functionality)
    find $PLUGIN_KEY -type f -name "*.*" -exec sed -i "s/PLUGIN_PREFIX/$PLUGIN_KEY/g" {} +

    # Text domain
    find $PLUGIN_KEY -type f -name "*.*" -exec sed -i "s/TEXT_DOMAIN/$PLUGIN_KEY/g" {} +

    # Plugin domain (e.g. wpswitzerland/my_great_plugin)
    # First convert to lowercase
    PLUGIN_DOMAIN=$(echo "$AUTHOR_NAMESPACE/$PLUGIN_KEY" | sed -e 's/\(.*\)/\L\1/')
    find $PLUGIN_KEY -type f -name "*.*" -exec sed -i "s/PLUGIN_DOMAIN/$PLUGIN_DOMAIN/g" {} +

    # Apply plugin key as pascal case namespace
    PLUGIN_NAMESPACE=$(echo $PLUGIN_KEY | sed -e 's/_\([a-z]\)/\u\1/g' -e 's/^[a-z]/\u&/')
    find $PLUGIN_KEY -type f -name "*.php" -exec sed -i "s/PLUGIN_NAMESPACE/$PLUGIN_NAMESPACE/g" {} +

    # Plugin author name
    if ! test -z "$PLUGIN_AUTHOR"
    then
        find $PLUGIN_KEY -type f -name "*.*" -exec sed -i "s/PLUGIN_AUTHOR/$PLUGIN_AUTHOR/g" {} +
    fi

    # Plugin author email address
    if ! test -z "$AUTHOR_EMAIL"
    then
        find $PLUGIN_KEY -type f -name "*.*" -exec sed -i "s/AUTHOR_EMAIL/$AUTHOR_EMAIL/g" {} +
    fi

    # Plugin author website
    if ! test -z "$AUTHOR_URI"
    then
        find $PLUGIN_KEY -type f -name "*.*" -exec sed -i "s/AUTHOR_URI/$AUTHOR_URI/g" {} +
    fi

    # Plugin name
    if ! test -z "$PLUGIN_NAME"
    then
		find $PLUGIN_KEY  -type f -name "*.*" -exec sed -i  "s/PLUGIN_NAME/$PLUGIN_NAME/g" {} +
    fi

    # Plugin description
    if ! test -z "$PLUGIN_DESCRIPTION"
    then
    	find $PLUGIN_KEY -type f -name "*.*" -exec sed -i "s/PLUGIN_DESCRIPTION/$PLUGIN_DESCRIPTION/g" {} +
    fi

    # Plugin author namespace (Usually a company name; used as the top-level PHP namespace)
    if ! test -z "$AUTHOR_NAMESPACE"
    then
        find $PLUGIN_KEY -type f -name "*.*" -exec sed -i "s/AUTHOR_NAMESPACE/$AUTHOR_NAMESPACE/g" {} +
    fi

    # Plugin's own website
    if ! test -z "$PLUGIN_URI"
    then
        find $PLUGIN_KEY -type f -name "*.*" -exec sed -i "s/PLUGIN_URI/$PLUGIN_URI/g" {} +
    fi

}

runPluginBuilder

echo "You are good to go!"
