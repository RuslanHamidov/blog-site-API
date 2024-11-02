require 'sinatra'
require 'sinatra/json'
require 'sinatra/activerecord'


#ensure content_type is json
before do
  content_type :json
end

#main page where 5 latest posts are returned
get '/' do
  latest_posts = []
  db_example.reverse_each do |post|
    latest_posts.push(post)
    break if latest_posts.length == 5
  end
  json latest_posts
end

#show all posts
get '/posts' do
  json Post.all
end

#get particular post
get '/posts/:id' do
  post = Post.find(params[:id])
  json post
end

#make new post
post '/posts' do
  post = Post.create(title: params[:title], body: params[:body])
  json post
end

#edit post
put '/posts/:id' do
  post = Post.find(params[:id])
  post.update(title: params[:title], body: params[:body])
  post.save
  redirect '/posts/' + params[:id]
end

#delete particular post
delete '/posts/:id' do
  post = Post.find(params[:id])
  post.destroy
  redirect '/posts'
end
