=begin

    Hi there. This is GitReaper. I made it to help do some heavy lifting with git commits.
    You're free to use and modify your own copies of the script - but I have not tested it on multiple platforms
    and don't know of the effects thereof.
    Feel free to also send in issues to the gitreaper repo or if you modify the code to make it better, feel free
    to also submit a pull request - I'll check it out.

    -Thanks
    Viktharien Volander

=end

class GitReaper

    @@color_red = "\033[31m"
    @@color_green = "\033[32m"
    @@color_default = "\033[0m"
    @@commits = 1
    @@time_running = 0

    def initialize
        
    end

=begin
    #DEPRECATED - but may use in the future
    def self.detect_file
        mod = Dir.glob("#{Dir.pwd}**/*").max_by {|f| File.mtime(f)}
        mod = mod.split('/')
        GitReaper.commit_loop(mod)
    end
=end

    def self.execute(param)
        stalker = %x{#{param}}
        @@time_running += 1
        if stalker.include? "nothing to commit" 
            puts @@color_red + "Stalking for #{@@time_running} secs" + @@color_default
        elsif stalker.include? "insert"
            puts @@color_green + stalker + @@color_default
            puts "#{@@commits} commits to pool so far"
            @@commits += 1
        end
    end

    def self.add_wait
        sleep 1
        GitReaper.execute "git add ."
        sleep 1
    end

    def self.commit_loop(pool)
            GitReaper.add_wait
            GitReaper.execute "git commit -m \" commit #{@@commits} to pool[#{pool}] at #{Time.now.strftime("%H:%M - %d/%m/%Y")} \""
    end

    def self.atomic(why, pool)
        open('why_commit.txt', 'a') do |file|
            file.puts "#{Time.now.strftime("%d/%m/%Y %H:%M")}:pool[#{pool}]: #{why}"
        end
        GitReaper.add_wait
        GitReaper.execute "git commit -m \"pool[#{pool}]: #{why}\""
    end

    def self.threader(branch)
        thread_bits = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
        thread_bits_adjs = ['serene','rapid','brilliant','pretty']
        thread_bits_verbs = ['rolling','living','shining','steaming']
        thread_bits_nouns = ['cow','rabbit','mountain','river']
        thread_pool = []
        thread_fork = [0,1]
        thread_pool.push(thread_bits_adjs[rand(4)] + "-")
        thread_pool.push(thread_bits_verbs[rand(4)] + "-")
        thread_pool.push(thread_bits_nouns[rand(4)] + "-")
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
                GitReaper.commit_loop(thread_pool.join(''))
            end
            
        end
        
        gets
        reaper.kill
        puts "Summarize changes made:"
        final_commit = gets.chomp
        GitReaper.atomic(final_commit, thread_pool.join(''))
        puts "Reaping #{@@commits} to pool on branch: #{branch}"
        GitReaper.execute "git push -u origin #{branch}"
        
    end

    def self.start
        puts "Branch to push?"
        branch = gets.chomp
        GitReaper.threader(branch)
    end

end

GitReaper.start
