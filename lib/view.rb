class View
  def display(recipes)
    if recipes.any?
      puts "Here are all of your recipes:"
      puts
      recipes.each_with_index do |recipe, index|
        xmark = recipe.done? ? "X" : " "
        puts "#{index + 1}. [#{xmark}] #{recipe.name} - #{recipe.description} Rating: #{recipe.rating}, Prep: #{recipe.prep_time}"
      end
    else
      puts "You don't have any recipes yet... 🍽"
    end
  end

  def ask_for(thing)
    puts "What is the #{thing} of your recipe?"
    gets.chomp
  end

  def ask_for_index
    puts "Which number?"
    gets.chomp.to_i - 1
  end
end
