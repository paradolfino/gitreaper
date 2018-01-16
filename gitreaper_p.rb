=begin

    Hi there. This is GitReaper, no class version. I made it to help do some heavy lifting with git commits.
    You're free to use and modify your own copies of the script - but I have not tested it on multiple platforms
    and don't know of the effects thereof.
    Feel free to also send in issues to the gitreaper repo or if you modify the code to make it better, feel free
    to also submit a pull request - I'll check it out.

    -Thanks
    Viktharien Volander

=end

$LOAD_PATH << '.'
require 'pathname'
require 'threader'


$color_red = "\033[31m"
$color_green = "\033[32m"
$color_default = "\033[0m"
$commits = 1
$time_running = 0

def execute(param)
    
    stalker = %x{#{param}}
    $time_running += 1
    if stalker.include? "nothing to commit" 
        p $color_red + "Stalking for #{$time_running} secs" + $color_default
    elsif stalker.include? "insert"
        p $color_green + stalker + $color_default
        p "#{$commits} commits to pool so far"
        $commits += 1
    end
end

def add_wait
    
    sleep 1
    execute "git add ."
    sleep 1
end

def commit_loop(pool)
    
    add_wait
    execute "git commit -m \" commit #{$commits} to pool[#{pool}] at #{Time.now.strftime("%H:%M - %d/%m/%Y")} \""
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
        p "Summarize changes made:"
        final_commit = gets.chomp
        atomic(final_commit, pool)
        p "Reaping #{$commits-1} commits to pool on branch: #{branch}"
        execute "git push -u origin #{branch}"
    when "kill"
        p "Wiping commits and exiting"
        system "git reset HEAD~"
    when "reap"
        p "Returning to loop"
        threader(branch)
    else
        p "Returning to loop"
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
    p "Preparing to Reap on #{branch} branch."
    reaper = Thread.new do
        
        while true
            commit_loop(thread_pool.join(''))
        end
        
    end
    
    gets
    reaper.kill
    p "How do you wish to exit?"
    p "'push': pushes all commits to branch\n'kill': wipes commits and exits program\n'reap': returns you to the reap loop"
    exit_type = gets.chomp
    exit(exit_type, thread_pool.join(''), branch)
    
    
end

def start
    p "Branch to push?"
    branch = gets.chomp
    threader(branch)
end

    



start
