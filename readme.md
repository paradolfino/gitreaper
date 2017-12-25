GitReaper is a helper script written in Ruby that is run in an existing terminal.

It will run on a loop, adding and committing to git. Upon commit, it includes a commit message based on most recent file modified in the directory for which GitReaper is in.

This tool probably doesn't follow best practices when it comes to commit messages. That's why I made it create a log of commits in why_commit.txt as well as ask for a final commit message that describes what changes were made.