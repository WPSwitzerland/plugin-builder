#!/bin/sh

function runPluginBuilder()
{

    ### PLUGIN KEY
    read -p "Plugin key: lowercase with underscores [my_plugin]:" plugin_key
    PLUGIN_KEY=${plugin_key:-my_plugin}

    if test -z "$PLUGIN_KEY"
    then
        echo "You must specify a plugin key."
        exit
    fi

    ### PLUGIN NAME (no default)
        read -p "Plugin name (e.g. 'My great plugin'):" PLUGIN_NAME

    ### PLUGIN DESCRIPTION (no default)
        read -p "Plugin description:" PLUGIN_DESCRIPTION

    ### PLUGIN URI (no default)
        read -p "Plugin URI:" PLUGIN_URI

    ### AUTHOR NAME (WP_PLUGIN_AUTHOR)
        if [[ -z "${WP_PLUGIN_AUTHOR}" ]]; then
            WP_PLUGIN_AUTHOR_DEFAULT=""
        else
            WP_PLUGIN_AUTHOR_DEFAULT="${WP_PLUGIN_AUTHOR}"
        fi
        read -p "Author name [$WP_PLUGIN_AUTHOR_DEFAULT]:" PLUGIN_AUTHOR
        PLUGIN_AUTHOR=${plugin_author:-$WP_PLUGIN_AUTHOR_DEFAULT}

    ### AUTHOR EMAIL (WP_PLUGIN_EMAIL)
        if [[ -z "${WP_PLUGIN_EMAIL}" ]]; then
            WP_PLUGIN_EMAIL_DEFAULT=""
        else
            WP_PLUGIN_EMAIL_DEFAULT="${WP_PLUGIN_EMAIL}"
        fi
        read -p "Author email address [$WP_PLUGIN_EMAIL_DEFAULT]:" PLUGIN_EMAIL
        AUTHOR_EMAIL=${plugin_email:-$WP_PLUGIN_EMAIL_DEFAULT}

    ### AUTHOR URI (WP_PLUGIN_AUTHOR_URI)
        if [[ -z "${WP_PLUGIN_AUTHOR_URI}" ]]; then
            WP_PLUGIN_AUTHOR_URI_DEFAULT=""
        else
            WP_PLUGIN_AUTHOR_URI_DEFAULT="${WP_PLUGIN_AUTHOR_URI}"
        fi
        read -p "Author website [$WP_PLUGIN_AUTHOR_URI_DEFAULT]:" AUTHOR_URI
        AUTHOR_URI=${AUTHOR_URI:-$WP_PLUGIN_AUTHOR_URI_DEFAULT}
        AUTHOR_URI=$(echo $AUTHOR_URI | sed -e 's/\//\\\//g') # Escape URI

    ### AUTHOR NAMESPACE (WP_PLUGIN_AUTHOR_NAMESPACE)
        if [[ -z "${WP_PLUGIN_AUTHOR_NAMESPACE}" ]]; then
            WP_PLUGIN_AUTHOR_NAMESPACE_DEFAULT=""
        else
            WP_PLUGIN_AUTHOR_NAMESPACE_DEFAULT="${WP_PLUGIN_AUTHOR_NAMESPACE}"
        fi
        read -p "Author's vendor name [$WP_PLUGIN_AUTHOR_NAMESPACE_DEFAULT]:" AUTHOR_NAMESPACE
        AUTHOR_NAMESPACE=${AUTHOR_NAMESPACE:-$WP_PLUGIN_AUTHOR_NAMESPACE_DEFAULT}

    # Replace dots from PLUGIN_KEY to not break function names
    PLUGIN_KEY_CLEAN=$(echo $PLUGIN_KEY | sed 's/\./\_/g')

    # Escape URI for regexp use within sed
    PLUGIN_URI=$(echo $PLUGIN_URI | sed -e 's/\//\\\//g')

	# Fetch the current base code from GitHub
    git clone https://github.com/WPSwitzerland/plugin-boilerplate-psr $PLUGIN_KEY
	rm -rf $PLUGIN_KEY/.git $PLUGIN_KEY/README.md
    mv $PLUGIN_KEY/plugin-boilerplate-psr.php $PLUGIN_KEY/$PLUGIN_KEY.php
    mv $PLUGIN_KEY/README_BLANK.md $PLUGIN_KEY/README.md

	# Search and replace metadata and names

    # Plugin key
    find $PLUGIN_KEY -type f -name "*.*" -exec sed -i '' "s/PLUGIN_KEY/$PLUGIN_KEY_CLEAN/g" {} +

    # Plugin prefix (for non-namespace functionality)
    find $PLUGIN_KEY -type f -name "*.*" -exec sed -i '' "s/PLUGIN_PREFIX/$PLUGIN_KEY_CLEAN/g" {} +

    # Text domain
    find $PLUGIN_KEY -type f -name "*.*" -exec sed -i '' "s/TEXT_DOMAIN/$PLUGIN_KEY_CLEAN/g" {} +

    # Apply plugin key as pascal case namespace
    PLUGIN_NAMESPACE=$(echo $PLUGIN_KEY_CLEAN | sed -E 's/[_-]([a-z0-9])/\U\1/g')

    echo ''
    echo $PLUGIN_NAMESPACE;
    echo ''

    find $PLUGIN_KEY -type f -name "*.php" -exec sed -i '' "s/PLUGIN_NAMESPACE/$PLUGIN_NAMESPACE/g" {} +

    # Plugin domain (e.g. wpswitzerland/my_great_plugin)
    # First convert to lowercase
    PLUGIN_DOMAIN=$PLUGIN_KEY_CLEAN
    find $PLUGIN_KEY -type f -name "*.*" -exec sed -i '' "s/PLUGIN_DOMAIN/$PLUGIN_DOMAIN/g" {} +

    # Plugin author name
    if ! test -z "$PLUGIN_AUTHOR"
    then
        find $PLUGIN_KEY -type f -name "*.*" -exec sed -i '' "s/PLUGIN_AUTHOR/$PLUGIN_AUTHOR/g" {} +
    fi

    # Plugin author email address
    if ! test -z "$AUTHOR_EMAIL"
    then
        find $PLUGIN_KEY -type f -name "*.*" -exec sed -i '' "s/AUTHOR_EMAIL/$AUTHOR_EMAIL/g" {} +
    fi

    # Plugin author website
    if ! test -z "$AUTHOR_URI"
    then
        find $PLUGIN_KEY -type f -name "*.*" -exec sed -i '' "s/AUTHOR_URI/$AUTHOR_URI/g" {} +
    fi

    # Plugin name
    if ! test -z "$PLUGIN_NAME"
    then
		find $PLUGIN_KEY -type f -name "*.*" -exec sed -i '' "s/PLUGIN_NAME/$PLUGIN_NAME/g" {} +
    fi

    # Plugin description
    if ! test -z "$PLUGIN_DESCRIPTION"
    then
    	find $PLUGIN_KEY -type f -name "*.*" -exec sed -i '' "s/PLUGIN_DESCRIPTION/$PLUGIN_DESCRIPTION/g" {} +
    fi

    # Plugin author namespace (Usually a company name; used as the top-level PHP namespace)
    if ! test -z "$AUTHOR_NAMESPACE"
    then
        find $PLUGIN_KEY -type f -name "*.*" -exec sed -i '' "s/AUTHOR_NAMESPACE/$AUTHOR_NAMESPACE/g" {} +
    fi

    # Plugin's own website
    if ! test -z "$PLUGIN_URI"
    then
        find $PLUGIN_KEY -type f -name "*.*" -exec sed -i '' "s/PLUGIN_URI/$PLUGIN_URI/g" {} +
    fi

}

runPluginBuilder

echo "You are good to go!"
