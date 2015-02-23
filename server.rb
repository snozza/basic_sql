require 'sinatra'
require 'pg'

set :conn, PG.connect( dbname: 'testing')

before do
  @conn = settings.conn
end

get '/' do
  users = []
  @conn.exec("SELECT * FROM authors") do |result|
    result.each do |row|
      users << row
    end
  end
  @users = users
  erb :index
end