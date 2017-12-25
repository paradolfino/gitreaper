GitReaper is a helper script written in Ruby that is run in an existing terminal.

I basically made it because I wanted something to automate my git interactions without being a mess to set up. It actually doesn't interact with the git api at all and just executes CLI commands.

It will run on a loop: every second adding and committing to git. Upon commit, it includes a commit message based on most recent file modified in the directory for which GitReaper is in.

This tool probably doesn't follow best practices when it comes to commit messages. That's why I made it create a log of commits in why_commit.txt as well as ask for a final commit message that describes what changes were made.

Atomic commits outside of the final_commit are commits to a pool. The pool is a reference name for the "pool" of commits before a push.

-Viktharien