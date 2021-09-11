class Document
  attr_accessor :name, :rows, :errors

  # @param [String] name
  # @param [Array<Row>] rows
  def initialize(name:, rows:)
    @errors = []
    self.name = name
    self.rows = rows || []
  end

  # @param [String] name
  def name=(name)
    raise FileNotFound, "Arquivo precisa existir !" unless File.exist?(name)
    @name = name
  rescue FileNotFound => e
    puts "#{e.class}: #{e.message}"
    self.errors << { name: e.message }
    @name = nil
  end

  def save!
    File.open(name, 'wb+') do |file|
      file.write "title | content \n"
      rows.each do |row|
        next unless row.errors.empty?

        file.write "#{row.title} | #{row.content}\n"
      end
    end

    puts "Arquivo salvo !"
    puts "Linhas inseridas: #{`wc -l #{name}`.split.first.to_i}"
  end

  def read
    File.open(name, 'r').readlines
  end

  class FileNotFound < StandardError; end
end