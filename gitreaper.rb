class GitReaper

    def initialize
        
    end

    def self.detect_file
        mod = Dir.glob("*/*").max_by {|f| File.mtime(f)}
        mod = mod.split('/')
        GitReaper.commit_loop(mod, "none")
    end

    def self.execute(param)
        system param
        #stalker = %x{#{param}}
        #if stalker.include? "nothing to commit" 
            #puts "Stalking"
        #end
    end

    def self.commit_loop(ref, why)
        if why == "none"
            verb = ["modify","change","edit"]
            sleep 1
            GitReaper.execute "git add ."
            sleep 1
            GitReaper.execute "git commit -m \"#{ref[0]}: #{verb[rand(verb.length)]}: #{ref[1]}\""
        else
            open('why_commit.txt', 'a') do |file|
                file.puts "#{`date`}: #{why}"
            end
            sleep 1
            GitReaper.execute "git add ."
            sleep 1
            GitReaper.execute "git commit -m \"what did I change?: #{why}\""
        end
    end

    def self.threader(branch)
        puts "Preparing to Reap on #{branch} branch."
        reaper = Thread.new do
            while true
                GitReaper.detect_file
            end
        end
        
        final_commit = gets.chomp
        GitReaper.commit_loop(branch, final_commit)
        puts "Reaping"
        GitReaper.execute "git push -u origin #{branch}"
        puts "Executing"
        reaper.kill
    end

    def self.start
        branch = `git checkout`
        branch = branch.split("/")
        branch = branch.pop
        branch = branch.gsub(/[^-\p{Alnum}]/,"")
        GitReaper.threader(branch)
    end

end

GitReaper.start
