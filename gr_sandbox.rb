#testing new features here

def output input
    changes = input.strip.split(",")
    changes.map! {|item| item = "* #{item.strip}"}
    puts "pool[test]:"
    puts changes
end
    input = gets.chomp
    
    output input