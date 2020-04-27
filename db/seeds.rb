# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

  Label.create!(label_name: "")
  Label.create!(label_name: "英語")
  Label.create!(label_name: "フロント")
  Label.create!(label_name: "バック")
  Label.create!(label_name: "rails")
  Label.create!(label_name: "ruby")


# 30.times do |i|
#   Learning.create!(title: "title#{i + 1}",
#                    main_content: "main#{i + 1}",
#                    sub_content: "sub#{i + 1}",
#                    url_info: "url#{i + 1}",
#                    # user_id ()
#                   )
end
