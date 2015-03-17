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
      p row
      users << row["name"]
    end
  end
  @users = users
  erb :index
end

post '/add' do
  @conn.exec('INSERT INTO authors (name) values ($1)', [params[:name]])
  redirect '/'
end