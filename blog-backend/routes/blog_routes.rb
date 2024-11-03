require 'sinatra'
require 'sinatra/json'
require 'sinatra/activerecord'

#ensure content_type is json
before do
  content_type :json
end

#main page where 5 latest posts are returned
get '/' do
  latest_posts = Post.order(created_at: :desc).limit(5)
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
