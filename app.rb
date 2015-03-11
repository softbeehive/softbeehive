require "sinatra/base"
require "sinatra/reloader"
require "slim"
require "slim/include"

module Softbeehive
  class App < Sinatra::Base
    
    configure :development do
      register Sinatra::Reloader
      also_reload "src/data.rb"

      set :slim, :layout => :"layouts/default"
      set :bind, "0.0.0.0"
    end

    before { request.path_info.sub! %r{/$}, '' }

    get "/" do
      slim :projects
    end

    get "/projects" do
      slim :projects
    end

    get "/projects/:name" do
      slim :"projects/details"
    end

    get "/about" do
      slim :about
    end

    get "/contact" do
      slim :contact
    end

    def selectProject(key)
      @kev = data_array.detect {|k, v| k[:"#{key}"]}
      return @kev[:"#{key}"]
    end

    require_relative "src/data"
    helpers ProjectData

  end
end
