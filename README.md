gitbugzilla
===========
Small bash script to populate descriptions for git branches from a Bugzilla's setup.

Requires:

- [python-bugzilla](https://fedorahosted.org/python-bugzilla/)

## Usage
### Generate a text file using python-bugzilla

Generate a text file containing a list of bugs from Bugzilla using `python-bugzilla`. For example:

    bugzilla --bugzilla=http://MY_BUGZILLA_URL/xmlrpc.cgi --user='MY_BUGZILLA_USERNAME' --password='MY_BUGZILLA_PASSWORD' query > bugs.txt

Command above will create a text file ``bugs.txt`` with a list of all the bugs from Bugzilla.

### Process text file
Invoke the shell script:
    ./gitbugzilla.sh

## Settings
Shell script has some variables you might want to customize:

- **FILE** - Text file created by python-bugzilla (defaults to *bugs.txt*)
- **bug_prefix** - Prefix when matching Bugzilla's bug number with git's branch name (defaults to *bug*). If value is kept as default and say that we want to update the branch corresponding to Bugzilla's bug number 100, a branch named *bug100* must exist, otherwise branch won't have description set.