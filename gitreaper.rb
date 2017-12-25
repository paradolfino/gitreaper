class GitReaper

    def initialize
        
    end

    def self.detect_file
        mod = Dir.glob("#{Dir.pwd}**/*").max_by {|f| File.mtime(f)}
        mod = mod.split('/')
        GitReaper.commit_loop(mod)
    end

    def self.execute(param)
        stalker = %x{#{param}}
        if stalker.include? "nothing to commit" 
            puts "Stalking"
        end
    end

    def self.add_wait
        sleep 1
        GitReaper.execute "git add ."
        sleep 1
    end

    def self.commit_loop(ref)
            verb = ["modify","change","edit"]
            GitReaper.add_wait
            GitReaper.execute "git commit -m \"#{ref[ref.length - 1]}: #{verb[rand(verb.length)]}: #{ref[ref.length]}\""
    end

    def self.atomic(why)
        open('why_commit.txt', 'a') do |file|
            file.puts "#{Time.now.strftime("%d/%m/%Y %H:%M")}: #{why}"
        end
        GitReaper.add_wait
        GitReaper.execute "git commit -m \"what did I change?: #{why}\""
    end

    def self.threader(branch)
        thread_bits = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
        thread_pool = []
        thread_fork = [0,1]
        6.times do
            do_fork = thread_fork[rand(thread_fork.length)]
            if do_fork == 0
                thread_pool.push(rand(9))
            else
                thread_pool.push(thread_bits[rand(thread_bits.length)])
            end
        end
        puts "Preparing to Reap on #{branch} branch."
        reaper = Thread.new do
            while true
                GitReaper.detect_file 
            end
            
        end
        
        gets
        reaper.kill
        puts "Summarize changes made:"
        final_commit = gets.chomp
        GitReaper.atomic(final_commit)
        puts "Reaping"
        GitReaper.execute "git push -u origin #{branch}"
        puts "Executing"
        
    end

    def self.start
        puts "Branch to push?"
        branch = gets.chomp
        GitReaper.threader(branch)
    end

end

GitReaper.start
