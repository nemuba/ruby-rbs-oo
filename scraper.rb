# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require_relative 'frase'

# Class for scraping the website
class Scraper
  attr_reader :url, :html, :parse, :categories, :category, :frases

  def initialize(url)
    scraper(url)
  end

  def reload!
    scraper(url)

    puts 'Reloaded'
  end

  def random(category: @categories.sample, count: 0)
    @html = URI.open(@url.gsub('frases', category))
    @parse = Nokogiri::HTML.parse(@html)
    @category = parse.css('div#content h1[itemprop="name"]').text
    @frases = list_frases
  end

  private

  def scraper(url)
    @url = url
    @html = URI.open(url)
    @parse = Nokogiri::HTML.parse(@html)
    @categories = list_categories
    @frases = list_frases
    @category = 'Frases em Destaque'
  end

  def list_categories
    parse.css('div#content a[href^="/frases_"]').map { |a| a['href'].gsub('/', '') } || []
  end

  def list_frases
    parse.css('.thought-card')&.map do |frase|
      content = frase.css('.frase.fr')&.text
      author = frase.css('.autor')&.text.strip

      Frase.new(category: @category, content: content, author: author).to_s
    end || []
  end
end
