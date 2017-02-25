#!/bin/sh

# Clone repo
git clone https://github.com/WPSwitzerland/wp-plugin-default

# We only want the code
rm -rf ./wp-plugin-default/.git
rm -f ./wp-plugin-default/.gitignore

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

find ./wp-plugin-default -type f -name "*.php" -exec sed -i '' -e "s/PLUGIN_PREFIX/$PLUGIN_PREFIX/g" {} +
find ./wp-plugin-default -type f -name "*.php" -exec sed -i '' -e "s/PLUGIN_AUTHOR/$PLUGIN_AUTHOR/g" {} +
find ./wp-plugin-default -type f -name "*.php" -exec sed -i '' -e "s/PLUGIN_NAME/$PLUGIN_NAME/g" {} +
find ./wp-plugin-default -type f -name "*.php" -exec sed -i '' -e "s/PLUGIN_DESCRIPTION/$PLUGIN_DESCRIPTION/g" {} +
find ./wp-plugin-default -type f -name "*.php" -exec sed -i '' -e "s/AUTHOR_NAMESPACE/$AUTHOR_NAMESPACE/g" {} +
find ./wp-plugin-default -type f -name "*.php" -exec sed -i '' -e "s/TEXT_DOMAIN/$TEXT_DOMAIN/g" {} +
find ./wp-plugin-default -type f -name "*.php" -exec sed -i '' -e "s/PLUGIN_KEY_PASCAL_CASE/$PLUGIN_KEY_PASCAL_CASE/g" {} +

echo "You are good to go!"
