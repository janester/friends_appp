require "sinatra"
require "sinatra/reloader" if development?
require "pg"
require "pry"

get "/" do
  erb :home
end

get "/new" do
  erb :new
end

get "/all" do
  sql = "select * from friend_info"
  conn = PG.connect(:dbname =>'friends', :host => 'localhost')
  @rows = conn.exec(sql)
  conn.close
  erb :all
end

post "/create" do
  @name = params[:inputName]
  @age = params[:inputAge]
  @gender = params[:inputGender]
  @image = params[:inputImageURL]
  @twitter = params[:inputTwitter]
  @facebook = params[:inputFacebook]
  sql = "insert into friend_info (name, age, gender, image, twitter, facebook) values ('#{@name}', '#{@age}', '#{@gender}', '#{@image}', '#{@twitter}', '#{@facebook}')"
  conn = PG.connect(:dbname =>'friends', :host => 'localhost')
  conn.exec(sql)
  conn.close
  redirect to "/all"
end

post "/remove" do
  name = params[:inputName]
  # if (@rows.each {|row| row["name"] == name})
  sql = "delete from friend_info where name='#{name}'"
  conn = PG.connect(:dbname =>'friends', :host => 'localhost')
  conn.exec(sql)
  conn.close
  # end
    redirect to "/all"
  end
