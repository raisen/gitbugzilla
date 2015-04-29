gitbugzilla
===========
Small bash script to populate descriptions for git branches from a Bugzilla's setup.

Requires:

- [python-bugzilla](https://fedorahosted.org/python-bugzilla/)

## Installation

Set the following environment variables to match with your Bugzilla's setup:

**BUGZILLA_URL** = Your Bugzilla's URL. URL should end with xmlrpc.cgi, such as http://bugzilla/xmlrpc.cgi
**BUGZILLA_USERNAME** = Your Bugzilla's username
**BUGZILLA_PASSWORD** = Your Bugzilla's password

Shell script has some variables you might want to customize:

- **FILE** - Text file created by python-bugzilla (defaults to *bugs.txt*)
- **bug_prefix** - Prefix when matching Bugzilla's bug number with git's branch name (defaults to *bug*). If value is kept as default and say that we want to update the branch corresponding to Bugzilla's bug number 100, a branch named *bug100* must exist, otherwise branch won't have description set.

## Usage

    gitbugzilla.sh <COMMAND>

      -s Show git branches with their descriptions
      -g Populate git branches with Bugzilla's information"
