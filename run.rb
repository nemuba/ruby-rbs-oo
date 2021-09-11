require_relative 'document.rb'
require_relative 'row.rb'

rows = [
  Row.new(title: "Aprender", content: "Ruby on Rails"),
  Row.new(title: "Aprender", content: "Hotwire Rails"),
  Row.new(title: "Aprender", content: "Sidekiq"),
  Row.new(title: "Aprender", content: "Sinatra"),
  Row.new(title: "Aprender", content: "React JS"),
]

document = Document.new(name: "teste.txt", rows: rows)
return  unless document.errors.empty?

document.save!

puts "Documento: #{document.name}"
puts document.read

