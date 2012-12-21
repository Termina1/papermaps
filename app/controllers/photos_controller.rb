class PhotosController < ApplicationController
  def index
    respond_to do |wants|

      wants.json do
        render json: Photo.populate_from_instagram("cats", 10)
      end

      wants.html do
        render "index" 
      end

    end
  end
end
