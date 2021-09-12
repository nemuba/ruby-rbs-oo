# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require_relative 'frase'

# Class for scraping the website
# Attributes:
# - url
# - html
# - categories
# - category
# - frases
# Example:
# scrape = Scraper.new('https://site.com')
# puts scrape.frases
# scrape.random(category: scrape.categories.sample)
# puts scrape.frases
class Scraper
  attr_reader :url, :html, :parse, :categories, :category, :frases

  # @param [String] url
  # @return void
  def initialize(url)
    scraper(url)
  end

  # @return void
  def reload!
    scraper(url)

    puts 'Reloaded'
  end

  # @param [String] category
  # @return void
  def random(category: @categories.sample)
    @html = URI.open(@url.gsub('frases', category))
    @parse = Nokogiri::HTML.parse(@html)
    @category = parse.css('div#content h1[itemprop="name"]').text
    @frases = list_frases
  end

  private

  # @param [String] url
  # @return void
  def scraper(url)
    @url = url
    @html = URI.open(url)
    @parse = Nokogiri::HTML.parse(@html)
    @categories = list_categories
    @frases = list_frases
    @category = 'Frases em Destaque'
  end

  # @return [Array<String>]
  def list_categories
    parse.css('div#content a[href^="/frases_"]').map { |a| a['href'].gsub('/', '') } || []
  end

  # @return [Array<Hash>]
  def list_frases
    parse.css('.thought-card')&.map do |frase|
      content = frase.css('.frase.fr')&.text
      author = frase.css('.autor')&.text.strip

      Frase.new(category: @category, content: content, author: author).to_s
    end || []
  end
end
