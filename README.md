# WordPress plugin builder

## Description
This is a shell script, which you can run on the command line and which uses
[this boilerplate code](https://github.com/WPSwitzerland/wp-plugin-default) to automatically set up a new plugin.
It provides you with all that you will need to start working on a WordPress plugin based around code using
PHP namespaces.

## Usage
Run this shell script from the command line: ``./build-wordpress-plugin.sh``. The script will prompt you for the
information it needs.

### On Mac OS
If you're going to use this bash script on Mac OS, you'll first need to replace the default version of ``sed`` with
[the GNU version](https://www.gnu.org/software/sed/), so that all of the necessary regular expression functionality
works. You can use [Homebrew](https://brew.sh/) to do this.

```
brew install gnu-sed --with-default-names
```

## Contributors
* Mark Howells-Mead | markweb.ch
* Mauro Bringolf | maurobringolf.ch
* Simon Bärlocher | sbaerlocher.ch

## License
Use this code freely, widely and for free. Provision of this code provides and implies no guarantee.

Please respect the GPL v3 licence, which is available via http://www.gnu.org/licenses/gpl-3.0.html

## Changelog

### 0.2.1
* Fix minor formatting issue in README.

### 0.2.0
* Major rewrite, including the use of the plugin key as a basis for the file and folder name, as well as the PascalCase PHP namespace.
* Issues remain when adding an http:// prefix to a URL, and the script entry is currently not validated. These will be addressed in an upcoming version.
