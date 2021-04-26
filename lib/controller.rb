require_relative 'view'
require_relative 'recipe'
require_relative 'scrape_allrecipes_service'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    display_recipes
  end

  def create
    # Ask user for a name
    name = @view.ask_for('name')
    # Ask user for a description
    description = @view.ask_for('description')
    rating = @view.ask_for('rating')
    prep_time = @view.ask_for('prep time')
    # Instantiate a recipe
    recipe = Recipe.new(
      name: name,
      description: description,
      rating: rating,
      prep_time: prep_time
    )
    # Store the recipe in the cookbook
    @cookbook.add_recipe(recipe)
  end

  def destroy
    # Display the recipes
    display_recipes
    # Ask which recipe? (get the index)
    index_of_recipe = @view.ask_for_index
    # Remove the recipe from the Cookbook
    @cookbook.remove_recipe(index_of_recipe)
  end

  def import
    # keyword = tell view to ask for search term
    keyword = @view.ask_for('name')
    # create a url with the keyword
    # html = open the url
    # give the html to nokogiri to do its *magic*
    # searched through the recipe cards to gather all of the info
    # created an array filled with Recipe instances
    recipes = ScrapeAllrecipesService.new(keyword).call
    # tell the view to display the recipes
    @view.display(recipes)
    # tell the view to ask for index
    index_of_recipe = @view.ask_for_index
    # get one recipe from the array using the index
    recipe = recipes[index_of_recipe]
    # give the recipe to the cookbook
    @cookbook.add_recipe(recipe)
  end

  def mark_as_done
    # display the recipes from the cookbook
    display_recipes
    # ask the user for the index
    index_of_recipe = @view.ask_for_index
    @cookbook.mark_as_done(index_of_recipe)
  end

  private

  def display_recipes
    # Retrieve the recipes from the Cookbook
    recipes = @cookbook.all
    # Display the recipes (ask the view)
    @view.display(recipes)
  end
end
