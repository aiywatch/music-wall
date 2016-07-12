# Homepage (Root path)
enable :sessions

get '/', '/index' do
  session["user"] ||= "anonymous"
  @songs = Song.all
  erb :index
end

get '/songs/new' do
  erb :'songs/new'
end

get '/songs/new_user' do
  erb :'songs/new_user'
end

get '/logout' do
  session["user"] = nil
  redirect '/'
end

get '/songs/login' do
  erb :"/songs/login"
end

get '/vote/:id' do
  if session["user_obj"]
    user_id = session["user_obj"].id
    song_id = params[:id]
    vote = Vote.new(song_id: song_id, user_id: user_id)
    vote.save
  end
  redirect '/'
end


post '/index' do
  username_id = User.find_by(username: session["user"]).id unless session["user"] == "anonymous"

  @song = Song.new(
    title: params[:title],
    author: params[:author],
    url: params[:url],
    user_id: username_id
  )
  if @song.save
    redirect '/'
  else
    @error = 'Invalid field'
    erb :'/songs/new'
  end
end

post '/create_user' do
  @user = User.new(
    username: params[:username],
    password: params[:password]
  )
  if @user.save
    session["user"] = @user.username
    session["user_obj"] = @user
    erb :'/songs/success_user'
  else
    @error = 'Invalid field'
    erb :'/songs/new_user'
  end
end

post '/loging' do
  if User.authen(params).size > 0
    user = User.authen(params)
    session["user"] = user.first.username
    session["user_obj"] = user.first
  else
    @error = 'Invalid User'
  end
  redirect '/'
end




