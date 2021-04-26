# This scraper should be making Recipe instances
require 'nokogiri' # turns HTML into Ruby objects
require 'open-uri'


# search #=> return an array []
# .search('h1')
# .search('.class_name')
# .search('a.class_name') # a tag with this class
# .search('.parent_class_name .child_class_name')
# .search('#id_name')

# text
# .text.strip

# p doc.search('.card__detailsContainer-left').count # array of objects with JUST the title


# wrap this in a Class and a method (like step #5 on Kitt)
# controller will call this to get recipes (an array of instances)
# we'll send that to the view (.display)

class ScrapeAllrecipesService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    file = 'lib/strawberry.html'  # or 'strawberry.html'
    doc = Nokogiri::HTML(File.open(file), nil, 'utf-8')
    doc.search('.card__detailsContainer-left').first(5).map do |card_element|
      name = card_element.search('.card__title').text.strip
      description = card_element.search('.card__summary').text.strip
      rating = card_element.search('.rating-star.active').count
      url = card_element.search('.card__titleLink').first.attributes['href'].value
      prep_time = fetch_prep_time(url)
      # Create an instance of a Recipe
      Recipe.new(
        name: name,
        description: description,
        rating: rating,
        prep_time: prep_time
      )
    end
  end

  def fetch_prep_time(url)
    html = open(url).read
    doc = Nokogiri::HTML(html)
    return doc.search('.recipe-meta-item-body').first.text.strip # 4
  end
end

# returns => array w/instances


#
