# This scraper should be making Recipe instances
require 'nokogiri' # turns HTML into Ruby objects

file = 'strawberry.html'  # or 'strawberry.html'
doc = Nokogiri::HTML(File.open(file), nil, 'utf-8')

# search #=> return an array []
# .search('h1')
# .search('.class_name')
# .search('a.class_name') # a tag with this class
# .search('.parent_class_name .child_class_name')
# .search('#id_name')

# text
# .text.strip

# p doc.search('.card__detailsContainer-left').count # array of objects with JUST the title
doc.search('.card__detailsContainer-left').first(5).map do |card_element|
  p name = card_element.search('.card__title').text.strip
  puts
  # description = search for description
  # Create an instance of a Recipe
end

# wrap this in a Class and a method (like step #5 on Kitt)
# controller will call this to get recipes (an array of instances)
# we'll send that to the view (.display)

# class ScrapeAllrecipesService
#   def initialize(keyword)
#     @keyword = keyword
#   end

#   def call
#     # TODO: return a list of `Recipes` built from scraping the web.
#   end
# end

# ScrapeAllrecipesService.new('strawberry').call  # returns => array w/instances


#
