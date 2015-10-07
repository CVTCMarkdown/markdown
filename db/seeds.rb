# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


goodAdjectivesPattern = /^((?!(un)?\w+(ing|less)$)|(?=\w+_))/
RandomWord.exclude_list << /^.{8,}$/ 
RandomWord.exclude_list << /^.{0,6}$/ 

loop do
  noteCount = Note.count
  break if noteCount >= 20
  
  begin

    RandomWord.exclude_list << goodAdjectivesPattern
    
    nextMarkdown = "Yesterday I saw the most " + RandomWord.adjs.rewind.take(5).join(", ")
    
    RandomWord.exclude_list.delete goodAdjectivesPattern
    
    nextMarkdown << " " + RandomWord.nouns.rewind.next
    
    nextTags = RandomWord.nouns.take(3).join(", ")
    
    Note.create(title: "Note #{noteCount}", markdown: nextMarkdown, active: true, tag_list: nextTags)

  rescue StopIteration => e
    puts e

    next
  end

end
