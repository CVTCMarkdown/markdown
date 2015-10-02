# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



loop do
  noteCount = Note.count
  break if noteCount >= 1000000
  
  begin

    RandomWord.exclude_list.clear
    RandomWord.exclude_list << /^(?!(un)?\w+(ing|ss)$)/
    
    nextMarkdown = "Yesterday I saw the most " + RandomWord.phrases.take(5).join(", ")
    
    RandomWord.exclude_list.clear
    
    nextMarkdown += RandomWord.nouns.next
    
    nextTags = RandomWord.nouns.take(3).join(", ")
    
    
    
    Note.create(title: "Note #{noteCount}", markdown: nextMarkdown, active: true, tag_list: nextTags)
    
    puts "#{noteCount}th record inserted"
  rescue StopIteration => e
    puts e
    RandomWord.adjs.rewind
    RandomWord.nouns.rewind
    next
  end

end
