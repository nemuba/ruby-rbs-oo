# frozen_string_literal: true

# Class: Row
# attributes:
# - title: String
# - content: String
# example:
# row = Row.new(title: 'Aprender', content: 'Aprender Ruby')
class Row
  attr_reader :title, :content
  attr_accessor :errors

  # @param [String] title
  # @param [Array<Hash>] content
  def initialize(title:, content:)
    self.errors = []
    self.title = title
    self.content = content
  end

  # @param [String] title
  def title=(title)
    raise TitleMaxSizeError, 'Titulo muito grande, máximo de 30 caractes !' unless title.size <= 30

    @title = title
  rescue TitleMaxSizeError => e
    puts "#{e.class}: #{e.message}"
    errors << { title: e.message }
    @title = nil
  ensure
    treat_errors(:title, @title)
  end

  # @param [String] content
  def content=(content)
    raise ContentMaxSizeError, 'Conteúdo muito grande, máximo de 150 carcateres !' unless content.size <= 150

    @content = content
  rescue ContentMaxSizeError => e
    puts "#{e.class}: #{e.message}"
    errors << { content: e.message }
    @content = nil
  ensure
    treat_errors(:content, @content)
  end

  def valid?
    errors.empty?
  end

  private

  def treat_errors(key, value)
    errors.reject! { |err| err.key?(key) } unless value.nil?
  end

  class TitleMaxSizeError < StandardError; end

  class ContentMaxSizeError < StandardError; end
end
