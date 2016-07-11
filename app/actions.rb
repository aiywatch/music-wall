# Homepage (Root path)
get '/', '/index' do
  @songs = Song.all
  erb :index
end

get '/songs/new' do
  erb :'songs/new'
end

post '/index' do
  @song = Song.new(
    title: params[:title],
    author: params[:author],
    url: params[:url]
  )
  if @song.save
    redirect '/'
  else
    @error = 'Invalid field'
    erb :'/songs/new'
  end
end