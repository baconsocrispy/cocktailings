def seed_recipes(count, text, max_name_length)
  Recipe.destroy_all

  until Recipe.count == count   
    recipe = Recipe.new
    ingredients = seed_recipe_ingredients(recipe)
    update_recipe_name(recipe, text, max_name_length)
    recipe.save!
  end
  
  p 'Recipes successfully seeded'
end

# --------------- RECIPE SEEDING HELPERS ---------------- #
def seed_recipe_ingredients(recipe)
  ingredients = [*seed_ingredient_type(Spirit, 1),
                 *seed_ingredient_type(Garnish, 2),
                 *seed_ingredient_type(Modifier, 2),
                 *seed_ingredient_type(Sugar, 1)]

  ingredients.each { |i| recipe.portions.build(ingredient_id: i.id) }
end

def seed_ingredient_type(type, quantity)
  s = []
  quantity.times do
    num = rand(0...type.all.length)
    s << type.all[num] 
  end
  return s
end

def update_recipe_name(recipe, text, max_length)
  name = ''
  until name != '' && !Recipe.find_by(name: name)
    words = get_random_words(text, max_length)
    name = make_name(words)
  end
  recipe.name = name
end

def make_name(words)
  separators = [' ', ' & ', ' of the ', ' and ', ' with ']
  length = rand(2..words.length)
  name_words = words[0...length]
  name_words.count == 2 ? 
    name = name_words.join(separators[rand(0...separators.length)]) :
    name = name_words.join(' ')
  return name.titleize
end

def get_random_words(text, count)
  rejected_words = [ 'and', 'the', 'did', 'with', 'for', 'their', 'they', 'him', 'her', 'went', 'had', 'shall', 'when' ]
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

def clean_word(word)
  rejected_chars = ['.', '"\"', ',', '!', '"', '-', '?', ';', '(', ')', ':']
  clean_word = ''
  word.each_char { |c| clean_word += c unless rejected_chars.include?(c) }
  return clean_word
end