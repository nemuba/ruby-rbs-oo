require_relative 'scraper'
require_relative 'row'
require_relative 'document'

data = Scraper.new('https://www.pensador.com/frases/')

rows = []

data.categories.each do |category|
  data.random(category: category)
  sleep 1
  rows << Row.new(title: data.category, content: data.frases)
end

Document.new(name: 'teste.txt', rows: rows).save!
