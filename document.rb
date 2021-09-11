# frozen_string_literal: true

# Class: Document
# attributes:
#  - name: String
#  - rows: Array[Row]
# @example
#  doc = Document.new(name: 'teste.txt', rows: [Row.new(title: 'Aprender', content: 'Ruby on Rails' )])
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
      file.write "title | content \n"
      rows.each do |row|
        next unless row.errors.empty?

        file.write "#{row.title} | #{row.content}\n"
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
