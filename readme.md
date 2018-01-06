# Velkommen til GitReaper
GitReaper is a helper script written in Ruby that is run in an existing terminal. It automates my interactions with Git, such as: adding, committing, and pushing to specified branches.

Instead of sparsely committing changes, I can keep track of second-by-second snapshots of changes to files watched by Git. Those changes are wrapped up into a single __pool__ that I can summarize what changes were made. All pools are given IDs/names for reference/inspection on GitHub.

In addition, at the end of a pool of commits, the summary of changes is written into a log file called "why_commit" which lists all changes, ordered by date, since I started using GitReaper inside the specific project directory.



-Viktharien