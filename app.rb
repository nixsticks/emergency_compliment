require_relative 'lib/compliment'
require_relative 'lib/page'
require 'yaml'
require 'bundler'
Bundler.require

module Compliments
  class App < Sinatra::Application

  set :compliments, ["You're awesome!", "You have great hair.", "Pusheen loves you.", "Hello Kitty's got nothing on you.", "You're a coding champion!", "Everyone else in the room is jealous of you.", "You're super fancy!"]
  set :images, Dir["./public/images/*"].map {|image| "/images/#{Pathname.new(image).basename}"}

    get '/' do
      @compliment = Compliment.new(settings.compliments.sample, settings.images.sample)
      @page = Page.new(@compliment)
      
      File.open("permalinks.yaml", "a") do |f|
        f.write(@page.to_yaml)
        f.puts
      end

      erb :index do
        erb :compliment
      end
    end

    get '/compliments' do
      @compliment = Compliment.new(settings.compliments.sample, settings.images.sample)
      erb :compliment
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

    get '/:compliment/:image' do
      
    end

  end
end