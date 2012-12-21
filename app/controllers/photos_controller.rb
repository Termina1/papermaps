class PhotosController < ApplicationController
  def index
    respond_to do |wants|

      wants.json do
        render json: Photo.get_last
      end

      wants.html do
        render "index" 
      end

    end
  end
end
