require 'sinatra'
require 'sinatra/json'
require 'sinatra/activerecord'
require 'sinatra/namespace'
require 'dotenv/load'

#get env variables from .env
configure do
  set :username, ENV['USERNAME']
  set :password, ENV['PASSWORD']
end

#helper methods to protect resource and check if authorized
helpers do
  def protected!
    halt 401, json(message: "Unathorized") unless authorized?
  end

  def authorized?
    @auth ||= Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? && @auth.credentials == [settings.username, settings.password]
  end
end

#ensure content_type is json
before do
  content_type :json
end

#admin namespace
namespace "/admin" do
  before do
    protected!
  end

  #show all posts
  get '/posts' do
    json Post.all
  end

  #make new post
  post '/posts' do
    post = Post.create(title: params[:title], body: params[:body])
    json post
  end

  #edit post
  put '/posts/:id' do
    post = Post.find(params[:id])
    if post
      post.update(title: params[:title], body: params[:body])
      redirect '/posts/' + params[:id]
    else
      halt 404, json(message: "Post not found")
    end
  end

  #delete particular post
  delete '/posts/:id' do
    post = Post.find(params[:id])
    if post
      post.destroy
      redirect '/posts'
    else
      halt 404, json(message: "Post not found")
    end
  end
end
