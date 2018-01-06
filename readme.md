# Velkommen til GitReaper

GitReaper is a helper script written in Ruby that is run in an existing terminal. It automates my interactions with Git, such as: adding, committing, and pushing to specified branches.

Instead of sparsely committing changes, I can keep track of second-by-second snapshots of changes to files watched by Git. Those changes are wrapped up into a single __pool__ that I can summarize what changes were made. All pools are given IDs/names for reference/inspection on GitHub.

In addition, at the end of a pool of commits, the summary of changes is written into a log file called "why_commit" which lists all changes, ordered by date, since I started using GitReaper inside the specific project directory.

## Threader

Threader, or "threader.rb", is a set of customizable methods that are used in GitReaper to generate unique IDs for commit pools. If you don't download threader.rb, GitReaper will still generate unique IDs, but will just use 6 alpha-numeric characters randomly chosen.

## GitReaper_NoClass

The original GitReaper, called "core" and just named "gitreaper.rb" is a class that uses internal methods and class variables.  
"gitreaper_noclass" is the same functionality, just with no explicit GitReaper class - and it looks more like a script this way.



-Viktharien