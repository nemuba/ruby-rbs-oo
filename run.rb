require_relative 'document.rb'
require_relative 'row.rb'

rows = []

puts "Informe o titulo: "
title = gets.chomp.to_s

puts "Informe o titulo: "
content = gets.chomp.to_s

rows << Row.new(title: title, content: content)

document = Document.new(name: 'teste.txt', rows: rows)

document.save!

sleep 2

puts document.read