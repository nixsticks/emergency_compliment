Dir.glob('./lib/*.rb') do |model|
  require model
end

require 'yaml'
require 'bundler'
Bundler.require

module Compliments
  class App < Sinatra::Application
    enable :session

    set :compliments, {
      "0" => "You're awesome!",
      "1" => "You have great hair.",
      "2" => "Pusheen loves you.",
      "3" => "Hello Kitty's got nothing on you.",
      "4" => "You're a coding champion!",
      "5" => "Everyone else in the room is jealous of you.",
      "6" => "You're super fancy!",
      "7" => "I hope you know that all of your friends adore you.",
      "8" => "Your cat is secretly incredibly fond of you."
    }
    set :images, Array.new(Dir["./public/images/*"].size) {|i| 1 + i}
    set :session_secret, 'super secret'

    get '/' do
      @compliment = unique_compliment
      session[:compliment] = @compliment
      @message = settings.compliments.key(@compliment.message)

      erb :index
    end

    get '/:compliment/:image' do
      compliment = settings.compliments[params[:compliment]]
      image = params[:image]
      if compliment && image
        @compliment = Compliment.new(compliment, image)
        erb :share
      else
        erb :not_found
      end
    end

    get '/:permalink' do
      @pages = []
      $/ = "\n\n"
      File.open("permalinks.yaml", "r").each {|page| @pages << YAML::load(page)}

      permalink = @pages.detect {|page| page.permalink == params[:permalink]}

      if permalink
        @compliment = permalink.compliment
        erb :compliment
      else
        erb :not_found
      end
    end

    helpers do
      def unique_compliment
        if session[:compliment].nil?
          Compliment.new(settings.compliments.values.sample, settings.images.sample)
        else
          compliments = settings.compliments.values.select {|compliment| compliment != session[:compliment].message}
          images = settings.images.select {|image| image != session[:compliment].image}
          Compliment.new(compliments.sample, images.sample)
        end
      end

      def simple_partial(template)
        erb template
      end
    end
  end
end