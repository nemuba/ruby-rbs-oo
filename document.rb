# frozen_string_literal: true

# Class: Document
# attributes:
#  - name: String
#  - rows: Array[Row]
# example:
#  doc = Document.new(name: 'teste.txt', rows: [Row.new(title: 'Aprender', content: 'Ruby on Rails' )])
#  doc.save!
#  puts doc.read
class Document
  attr_reader :name, :rows
  attr_accessor :errors

  # @param [String] name
  # @param [Array<Row>] rows
  def initialize(name:, rows:)
    self.errors = []
    self.name = name
    self.rows = rows
  end

  # @param [String] name
  def name=(name)
    raise FileNotFound, 'Arquivo precisa existir !' unless File.exist?(name)

    @name = name
  rescue FileNotFound => e
    puts "#{e.class}: #{e.message}"
    errors << { name: e.message }
    @name = nil
  end

  def rows=(rows)
    @rows = rows || []
  end

  def save!
    File.open(name, 'wb+') do |file|
      file.write "Frases\n\n"
      rows.each do |row|
        next unless row.errors.empty?

        file.write "categoria: #{row.title}\n\n"
        row.content.each do |frase|
          file.write "frase: #{frase[:content]}\n"
          file.write "autor: #{frase[:author]}\n\n"
        end
      end
    end

    puts 'Arquivo salvo !'
    puts "Linhas inseridas: #{`wc -l #{name}`.split.first.to_i}"
  end

  def read
    File.open(name, 'r').readlines
  end

  class FileNotFound < StandardError; end
end
