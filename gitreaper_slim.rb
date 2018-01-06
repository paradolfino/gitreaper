=begin

    Hi there. This is a slimmed down version of GitReaper. By slim I mean that there isn't a threader, there isn't any coloring, limited output
    and only the exit options. Commit pools will be using only a 6 character alphanumeric id instead of "serene-something-something".
    -Thanks
    Viktharien Volander

=end

def execute(param)
    
    stalker = %x{#{param}}
    if stalker.include? "nothing to commit" 
        puts "Stalking"
    elsif stalker.include? "insert"
        puts stalker
    end
end

def add_wait
    sleep 1
    execute "git add ."
    sleep 1
end

def commit_loop(pool)
    
    add_wait
    execute "git commit -m \" commit to pool[#{pool}] at #{Time.now.strftime("%H:%M - %d/%m/%Y")} \""
end

def atomic(why, pool)
    
    open('why_commit.txt', 'a') do |file|
        file.puts "#{Time.now.strftime("%d/%m/%Y %H:%M")}:pool[#{pool}]: #{why}"
    end
    add_wait
    execute "git commit -m \"pool[#{pool}]: #{why}\""
end

def exit(exit_type, pool, branch)
    case exit_type
    when "push"
        puts "Summarize changes made:"
        final_commit = gets.chomp
        atomic(final_commit, pool)
        puts "Reaping commits to pool on branch: #{branch}"
        execute "git push -u origin #{branch}"
    when "kill"
        puts "Wiping commits and exiting"
        system "git reset HEAD~"
    when "reap"
        puts "Returning to loop"
        threader(branch)
    else
        puts "Returning to loop"
        threader(branch)
    end
end

def threader(branch)
    include Threader
    pn = Pathname.new('threader.rb')
    thread_pool = []
    thread_fork = [0,1]
    thread_bits = []
    if pn.exist?
        thread_bits = Threader.bits
        thread_pool.push(Threader.bits_adjs[rand(Threader.bits_adjs.length)] + "-")
        thread_pool.push(Threader.bits_verbs[rand(Threader.bits_verbs.length)] + "-")
        thread_pool.push(Threader.bits_nouns[rand(Threader.bits_nouns.length)] + "-")
    else
        thread_bits = ("a".."z").to_a
    end
    
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
            commit_loop(thread_pool.join(''))
        end
        
    end
    
    gets
    reaper.kill
    puts "How do you wish to exit?"
    puts "'push': pushes all commits to branch\n'kill': wipes commits and exits program\n'reap': returns you to the reap loop"
    exit_type = gets.chomp
    exit(exit_type, thread_pool.join(''), branch)
    
    
end

def start
    puts "Branch to push?"
    branch = gets.chomp
    threader(branch)
end

    



start
