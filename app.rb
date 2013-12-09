require_relative 'lib/compliment'
require 'bundler'
Bundler.require

module Compliments
  class App < Sinatra::Application

    compliments = {
      :awesome => "You're awesome!",
      :hair => "You have great hair.",
      :pusheen => "Pusheen loves you.",
      :hello_kitty => "Hello Kitty's got nothing on you.",
      :coding_champion => "You're a coding champion!",
      :jealous => "Everyone else in the room is jealous of you.",
      :fancy => "You're super fancy."
    }

    images = [
      "/images/christmas_pusheen.gif",
      "/images/balloon_pusheen.gif",
      "/images/pusheenicorn.gif",
      "/images/gangnam_pusheen.gif"
    ]

    get '/' do

      @compliment = Compliment.new(compliments.values.sample, images.sample)

      erb :index do
        erb :compliment
      end
      # redirect to("/#{compliments.keys.sample.to_s}")
    end

    get '/compliments' do
      @compliment = Compliment.new(compliments.values.sample, images.sample)
      erb :compliment
    end

    get '/:compliment' do
      compliment = compliments[params[:compliment].to_sym]

      if compliment
        @compliment = Compliment.new(compliment, images.sample)
        erb :compliment
      else
        erb :not_found
      end
    end
  end
end