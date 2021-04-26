class Recipe
  attr_reader :name, :description, :rating, :prep_time

  def initialize(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
    @rating = attributes[:rating]
    @prep_time = attributes[:prep_time]
    @done = attributes[:done] || false # boolean
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = !@done
  end
end

# p Recipe.new
# p Recipe.new(name: 'strawberry', description: "whatever")
