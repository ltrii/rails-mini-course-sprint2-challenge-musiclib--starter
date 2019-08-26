module Api
    module V1
      class PlaylistsController < ApplicationController
        def index
          @artists = Artist.all
  
          render json: @artists
        end
  
        def show
          @artist = Artist.find(params[:id])
  
          render json: @artist
        end

        def create

        end
      end
    end
  end