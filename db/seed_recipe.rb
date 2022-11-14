def seed_recipes(count, text, max_name_length)
  Portion.where(portionable_type: 'Recipe').destroy_all
  Recipe.destroy_all

  until Recipe.count == count   
    recipe = Recipe.new
    ingredients = seed_recipe_ingredients(recipe)
    update_recipe_name(recipe, text, max_name_length)
    add_category(recipe)
    recipe.save!
  end
  
  p 'Recipes successfully seeded'
end

# --------------- RECIPE SEEDING HELPERS ---------------- #
# seeds a recipe with each ingredient type
def seed_recipe_ingredients(recipe)
  ingredients = [*seed_ingredient_type(Spirit, 1),
                 *seed_ingredient_type(Garnish, 2),
                 *seed_ingredient_type(Modifier, 2),
                 *seed_ingredient_type(Sugar, 1)]

  ingredients.each { |i| recipe.portions.build(ingredient_id: i.id) }
end

# randomly selects a quantity of an ingredient type and 
# returns them in an array
def seed_ingredient_type(type, quantity)
  s = []
  quantity.times do
    num = rand(0...type.all.length)
    s << type.all[num] 
  end
  return s
end

# generates a recipe name for a given recipe from randomly
# selected words in a text up to a chosen number of words per name.
# ensures there are no duplicate names
def update_recipe_name(recipe, text, max_length)
  name = ''
  until name != '' && !Recipe.find_by(name: name)
    words = get_random_words(text, max_length)
    name = make_name(words)
  end
  recipe.name = name
end

# joins a collection of words together with randomly selected
# separators. Randomly chooses how many words go into the title
def make_name(words)
  separators = [' ', ' & ', ' of the ', ' and ', ' with ']
  length = rand(2..words.length)
  name_words = words[0...length]
  name_words.count == 2 ? 
    name = name_words.join(separators[rand(0...separators.length)]) :
    name = name_words.join(' ')
  return name.downcase
end

# grabs a desired number of words at random from a text, cleans them
# and returns an array of those words
def get_random_words(text, count)
  rejected_words = [ 'and', 'the', 'did', 'with', 'for', 'their', 'they', 'him', 'her', 'went', 'had', 'shall', 'when', 'about' ]
  words = []
  count.times do
    word = ''
    until word.length >= 3 && !rejected_words.include?(word)
      num = rand(0...text.count)
      unclean = text[num]
      word = clean_word(unclean)
    end
    words << word
  end
  return words
end

# trims unwanted punctuation out of strings
def clean_word(word)
  rejected_chars = ['.', '"\"', ',', '!', '"', '-', '?', ';', '(', ')', ':']
  clean_word = ''
  word.each_char { |c| clean_word += c unless rejected_chars.include?(c) }
  return clean_word
end

# adds one random category to each recipe
def add_category(recipe)
  random_idx = rand(0...Category.count)
  category_id = Category.all[random_idx].id
  recipe.category_ids = [category_id]
end