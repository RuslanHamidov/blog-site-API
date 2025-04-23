require './app'
require './models/blog'

10.times do |i|
  Post.create(
    title: "Sample Post #{i + 1}",
    body: "This is the body of sample post number #{i + 1}. It's just some placeholder text to simulate a real blog post."
  )
end

puts "✅ Seeded 10 posts!"
