# Homepage (Root path)
# require 'bootstrap'
enable :sessions


get '/' do
  @songs = Song.all
  erb :index
end

get '/new' do
  erb :new
end

get '/index' do
  @songs = Song.all
  if session[:user_id]
    @user = User.find_by(username: params[:username])
  end
  erb :index
end

get '/signin' do
  erb :index
end

get '/signup' do
  erb :signup
end

post '/new' do
  @song = Song.new(
    title:  params[:title],
    author: params[:author],
    url:    params[:url],  
  )
  if session[:user_id] 
    @song.user = User.find_by(username: params[:username])
  end
  if @song.save
    redirect '/index'
  else
    erb :new
  end
end

post '/signup' do
  @user = User.new(
    username: params[:username],
    email: params[:email]
  )
  if @user.save
    session[:user_id] = @user.id
    redirect '/index'
  else
    erb :signup
  end
end

post '/signout' do
  session[:user_id] = nil
  redirect '/index'
end

post '/signin' do
  session[:user_id] = nil
  @user = User.find_by(username: params[:username])
  session[:user_id] = @user.id
  redirect '/index'
  # User.all.each do |user|
  #   if @user.username == params[:username]
  #     session[:user_id] = @user.id
  #     redirect '/index'
  #   else
  #     redirect '/index'
  #   end
  # end
end





