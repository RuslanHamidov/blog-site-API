require 'sinatra'
require 'sinatra/json'
require 'sinatra/activerecord'

db_example = [{id: 1, title: "sample title", body: "this is body of first post"},
              {id: 2, title: "title2", body: "this is body of second post"},
              {id: 3, title: "title2", body: "this is body of second post"},
              {id: 4, title: "title2", body: "this is body of second post"},
              {id: 5, title: "title2", body: "this is body of second post"},
              {id: 6, title: "title2", body: "this is body of second post"},
              {id: 7, title: "title2", body: "this is body of second post"},
              {id: 8, title: "title2", body: "this is body of second post"}
              ]

#get request body
def getBody (req)
    req.body.rewind
    return JSON.parse(req.body.read)
end

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
  json db_example
end

#get particular post
get '/posts/:id' do
  id = params["id"].to_i
  json db_example[id]
end

#make new post
post '/posts' do
  data = getBody(request)
  new_post = {id: db_example.length + 1,title: data["title"], body: data["body"]}
  db_example.push(new_post)
  json new_post
end

#edit post
put '/posts/:id' do
  id = params["id"].to_i
  body = getBody(request)
  db_example[id - 1][:title] = body["title"]
  db_example[id - 1][:body] = body["body"]
end

#delete particular post
delete '/posts/:id' do
  id = (params["id"].to_i)
  db_example.delete_at(id)
end
