require 'sinatra'
require "sinatra/activerecord"
require_relative 'routes/blog_routes'
require "/models/blog.rb"


set :database, { adapter: 'sqlite3', database: 'db/blog.sqlite3', encoding: 'utf8' }
