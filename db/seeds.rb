# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(email: 'user@markdown.com', password: 'password')
user2 = User.create(email: 'user2@markdown.com', password: 'password')

goodAdjectivesPattern = /^((?!(un)?\w+(ing|less)$)|(?=\w+_))/
RandomWord.exclude_list << /^.{8,}$/ 
RandomWord.exclude_list << /^.{0,6}$/

[user, user2].each do |usr|
  (0..20).each do |n|

    RandomWord.exclude_list << goodAdjectivesPattern

    next_markdown = "Yesterday I saw the most " + RandomWord.adjs.rewind.take(5).join(", ")

    RandomWord.exclude_list.delete goodAdjectivesPattern

    next_markdown << " " + RandomWord.nouns.rewind.next

    next_tags = RandomWord.nouns.take(3).join(", ")

    the_note = Note.create(title: "Note #{n}", markdown: next_markdown, active: true)

    usr.notes << the_note
    usr.tag(the_note, :with => next_tags, :on => :tags)

  end
end


