require_relative 'document'
require_relative 'row'

rows = []

puts 'Informe o titulo: '
title = gets.chomp.to_s

puts 'Informe o conteúdo: '
content = gets.chomp.to_s

rows << Row.new(title: title, content: content)

document = Document.new(name: 'teste.txt', rows: rows)

document.save!

puts document.read
