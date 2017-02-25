#!/bin/sh

# Clone repo
git clone https://github.com/WPSwitzerland/wp-plugin-default

# We only want the code
rm -rf ./wp-plugin-default/.git
rm -f ./wp-plugin-default/.gitignore

# Ask for metadata of the new plugin
echo "What's your plugin called?"
read PLUGIN_NAME

find ./wp-plugin-default -type f -name "*.php" -exec sed -i '' -e "s/PLUGIN_NAME/$PLUGIN_NAME/g" {} +
