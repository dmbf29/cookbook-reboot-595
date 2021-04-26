require_relative 'recipe'
require 'csv'

class Cookbook
  def initialize(csv_file_path)
    @recipes = [] # contains instances of Recipe
    @csv_file_path = csv_file_path
    load_csv # instance method
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_csv
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    save_csv
  end

  def mark_as_done(index)
    # need a recipe from the index
    recipe = @recipes[index]
    # mark recipe as done
    recipe.mark_as_done!
    # recipe.done = true
    # save the csv
    save_csv
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      # i have to give Recipe.new a hash
      # hash[key] = new_value
      row[:done] = row[:done] == 'true'
      recipe = Recipe.new(row)
      @recipes << recipe
    end
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      # 1. write the headers into the csv
      csv << ['name', 'description', 'rating', 'done', 'prep_time']
      # 2. iterate over the recipes and put them below the headers
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.done?, recipe.prep_time]
      end
    end
  end
end
