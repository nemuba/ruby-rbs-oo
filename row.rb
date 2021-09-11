class Row
  attr_accessor :title, :content, :errors

  # @param [String] title
  # @param [String] content
  def initialize(title:, content:)
    self.errors = []
    self.title = title
    self.content = content
  end

  # @param [String] title
  def title=(title)
    raise TitleMaxSizeError, "Titulo muito grande, máximo de 30 caractes !" unless title.size <= 30
    @title = title
  rescue TitleMaxSizeError => e
    puts "#{e.class}: #{e.message}"
    self.errors << { title: e.message }
    @title = nil
  end

  # @param [String] content
  def content=(content)
    raise ContentMaxSizeError, "Conteúdo muito grande, máximo de 150 carcateres !" unless content.size <= 150
    @content = content
  rescue ContentMaxSizeError => e
    puts "#{e.class}: #{e.message}"
    self.errors << { content: e.message }
    @content = nil
  end

  class TitleMaxSizeError < StandardError; end

  class ContentMaxSizeError < StandardError; end
end