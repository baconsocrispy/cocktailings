# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

spirits = Spirit.create([{ display_name: "Gin", sub_type: "Gin" }, 
                         { display_name: "Whiskey", sub_type: "Whiskey"},
                         { display_name: "Brandy", sub_type: "Brandy"},
                         { display_name: "Mezcal", sub_type: "Mezcal"},
                         { display_name: "Tequila", sub_type: "Tequila"},
                         { display_name: "Rum", sub_type: "Rum"},
                         { display_name: "Vodka", sub_type: "Vodka"}])