require_relative 'lib/compliment'
require_relative 'lib/page'
require 'yaml'
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

    images = Dir["./public/images/*"].map {|image| "/images/#{Pathname.new(image).basename}"}

    get '/' do

      @compliment = Compliment.new(compliments.values.sample, images.sample)
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
      @compliment = Compliment.new(compliments.values.sample, images.sample)
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
  end
end