require 'rubygems'
require 'sinatra'
require 'omniauth'
require 'omniauth-twitter'

class SinatraApp < Sinatra::Base
  configure do
    set :sessions, true
    set :inline_templates, true
  end

  use OmniAuth::Builder do
    provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  end

  get '/' do
    erb "<a href='/auth/twitter'>Login with Twitter</a><br>"
  end


  get '/auth/:provider/callback' do
    result = request.env['omniauth.auth']
    erb "<a href='/'>Top</a><br>
         <h1>#{params[:provider]}</h1>
         <pre>#{JSON.pretty_generate(result)}</pre>"
  end
end

SinatraApp.run! if __FILE__ == $0