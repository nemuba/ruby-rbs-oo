# frozen_string_literal: true

# Class: Frase
# Description: Class to storage a frase
# Author: Alef Ojeda de Oliveira
# Example:
#  frase = Frase.new(category: 'Pensador', content: 'Hello World', author: 'Alef')
class Frase
  attr_accessor :content, :author, :category

  # @param [String] content
  # @param [String] author
  # @param [String] category
  def initialize(category:, content:, author:)
    @category = category
    @content = content
    @author = author
  end

  # @return [Hash]
  def to_s
    { category: @category, content: @content, author: @author }
  end
end
