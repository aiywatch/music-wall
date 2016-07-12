# Homepage (Root path)
enable :sessions

helpers do
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def can_comment?
    if session[:user_obj]
      comment = Comment.where(song_id: params[:id], user_id: session[:user_obj].id)
      comment.size == 0
    end
  end
end

get '/', '/index' do
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
  # use session.clear or clear both 
  session.clear
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

get '/song_view/:id' do
  @song = Song.find_by(id: params[:id])
  erb :'songs/song_view'
end

get '/comment/del/:song_id/:id' do
  Comment.find(params[:id]).destroy
  redirect "/song_view/#{params[:song_id]}"
end


post '/new_song' do
  username_id = session["user_obj"].id if session["user_obj"]

  @song = Song.new(
    title: params[:title],
    author: params[:author],
    url: params[:url],
    user_id: username_id
  )
  if @song.save
    redirect '/'
  else
    session[:flash] = 'Invalid field'
    erb :'/songs/new'
  end
end

post '/create_user' do
  @user = User.new(
    username: params[:username],
    password: params[:password]
  )
  if @user.save
    session["user_obj"] = @user
    erb :'/songs/success_user'
  else
    session[:flash] = 'Invalid field'
    erb :'/songs/new_user'
  end
end

post '/loging' do
  if User.authen(params).size > 0
    user = User.authen(params)
    session["user_obj"] = user.first
  else
    session[:flash] = 'Invalid User'
  end
  redirect '/'
end

post '/comment/new/:id' do
  @comment = Comment.new(
    song_id: params[:id],
    user_id: session[:user_obj].id,
    comment: params[:comment],
    star: params[:star]
  )
  if @comment.save
    redirect "/song_view/#{params[:id]}"
  else
    session[:flash] = 'Invalid Comment'
    redirect "/song_view/#{params[:id]}"
  end
end




