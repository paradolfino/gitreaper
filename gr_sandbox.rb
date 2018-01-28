#testing new features here

def output input
    changes = input.strip.split(",")
    changes.map! {|item| item = "* #{item.strip}"}
    
    open('pull.txt', 'w') do |file|
        puts "pool[test]:"
        puts changes
    end
end
input = gets.chomp
  
output input