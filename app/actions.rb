# Homepage (Root path)
get '/' do
  @songs = Song.all
  erb :index
end

get '/new' do
  erb :new
end

get '/index' do
  @songs = Song.all
  erb :index
end

post '/new' do
  @song = Song.new(
    title:  params[:title],
    author: params[:author],
    url:    params[:url]
  )
  if @song.save
    redirect '/index'
  else
    erb :new
  end
end


