require 'fileutils'

class PicturesController < ApplicationController
  protect_from_forgery :except => :create
  
  def create
    picture_dir  = File.join(RAILS_ROOT, "pictures", current_user.id.to_s)
    picture_path = File.join(picture_dir, "#{Time.now.to_f}.png")
    FileUtils.mkdir_p(picture_dir)
    
    f = open(picture_path, "w")
    f.write(params[:image].read)
    f.close
    
    @picture = Picture.create(:path => picture_path)
    
    render :text => @picture.id
  end
end
