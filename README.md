# WordPress plugin builder

## Description

This is a shell script, which you can run on the command line and which uses
[this boilerplate code](https://github.com/WPSwitzerland/plugin-boilerplate-psr) to automatically set up a new plugin.
It provides you with all that you will need to start working on a WordPress plugin based around code using
PHP namespaces.

## Usage

Run this shell script from the command line: `./build-wordpress-plugin.sh`. The script will prompt you for the
information it needs.

### On Mac OS

If you're going to use this bash script on Mac OS, you'll first need to replace the default version of `sed` with
[the GNU version](https://www.gnu.org/software/sed/), so that all of the necessary regular expression functionality
works. You can use [Homebrew](https://brew.sh/) to do this. When installing, Homebrew instructs on how to adapt the
`PATH`, if one wants to use sed without the g prefix. (`--with-default-names` is no longer supported.)

Since version 0.6.2, you will also need to ensure that perl is available.

```
brew install gnu-sed
brew install perl
```

### Preset values

If you have the appropriate environment variables set in your bash profile, version 0.6.0 added support for these
as default values. Press ENTER on the command line to accept the default values (where available) or type your
custom values as appropriate.

(To create a custom environment variable with its value, add your modified version of the following to e.g. `~/.bash_profile` (on OSX).

    export WP_PLUGIN_AUTHOR="Mark Howells-Mead"
    export WP_PLUGIN_EMAIL="mark@sayhello.ch"
    export WP_PLUGIN_AUTHOR_URI="https://sayhello.ch/"
    export WP_PLUGIN_AUTHOR_NAMESPACE="SayHello"

### Supported environment variables

-   WP_PLUGIN_AUTHOR
-   WP_PLUGIN_EMAIL
-   WP_PLUGIN_AUTHOR_URI
-   WP_PLUGIN_AUTHOR_NAMESPACE

### Global access

(This applies for Mac OS.) Place a copy of the .sh file in `/usr/local/bin` and make it executable.

    cp build-wordpress-plugin.sh /usr/local/bin/build-wordpress-plugin
    chmod +x /usr/local/bin/build-wordpress-plugin

Then use `build-wordpress-plugin` from the plugin directory of your project.

## Contributors

-   Mark Howells-Mead | [permanenttourist.ch](https://permanenttourist.ch/wordpress)
-   Mauro Bringolf | [maurobringolf.ch](https://maurobringolf.ch)
-   Simon Bärlocher | [sbaerlocher.ch](https://sbaerlocher.ch)
-   Sven von Arx

## License

Use this code freely, widely and for free. Provision of this code provides and implies no guarantee.

Please respect the GPL v3 licence, which is available via http://www.gnu.org/licenses/gpl-3.0.html

## Changelog

### 0.6.2

-   Use perl instead of sed to convert plugin namespace to PascalCase, for improved support in OSX.

### 0.6.1

-   Update README

### 0.6.0

-   Fix SED errors and allow defaults via ENV
-   Update gnu-sed instructions for OSX

### 0.5.0

-   Clean plugin key input to remove . characters.

### 0.4.0

-   Reference new plugin-boilerplate-psr repository paths.

### 0.3.1

-   Add global access information to README.

### 0.3.0

-   Fix URL issue detailed in 0.2.0.
-   Hyperlink contributor URIs.

### 0.2.1

-   Fix minor formatting issue in README.

### 0.2.0

-   Major rewrite, including the use of the plugin key as a basis for the file and folder name, as well as the PascalCase PHP namespace.
-   Issues remain when adding an http:// prefix to a URL, and the script entry is currently not validated. These will be addressed in an upcoming version.
