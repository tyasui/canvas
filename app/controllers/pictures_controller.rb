# coding: utf-8
class PicturesController < ApplicationController
  before_action :authenticate_user!
    
  def new
  end

=begin
  def edit
    @pict = Picture.find(params[:id])
    path = 'public/images/'
    picture = @pict
    if File.exist?("#{Rails.root}/#{path}/#{picture.id}.png")
      File.open("#{Rails.root}/#{path}/#{picture.id}.png",) do |f|
        f.write("#{Rails.root}/#{path}/#{picture.id}.png")
      end
    end
  end
  
  def update
    path = 'public/images/'
    picture = Picture.create
    File.open("#{Rails.root}/#{path}/#{picture.id}.png", 'wb') do |f|
      f.write Base64.decode64(params[:data].sub!('data:image/png;base64,', ''))
    end
  end
=end

  def create
    path = 'public/images/'
    picture = Picture.create

    @picture = picture
    @picture.user_id = current_user.id
    @picture.save
    
      
    File.open("#{Rails.root}/#{path}/#{picture.id}.png", 'wb') do |f|
      f.write Base64.decode64(params[:data].sub!('data:image/png;base64,', ''))
    end

    if Picture.count > 10
      picture = Picture.order(:id).first
      begin
        File.unlink
      rescue => exc
        p exc
      end
      picture.destroy
    end
    render nothing: true
  end

  def list

    @pictures = Picture.all.order(created_at: :desc)
    @users = User.all

    ids = []
    Picture.all.reverse.each do |picture|
      ids << picture.id
    end
    @response = ids.join(',')
  end


  def destroy
    @pict = Picture.find(params[:id])

#
    path = 'public/images/'
    picture = @pict
    if File.exist?("#{Rails.root}/#{path}/#{picture.id}.png")
      File.delete("#{Rails.root}/#{path}/#{picture.id}.png",)
    end
#

    @pict.destroy
    redirect_to pictures_list_path, notice: "絵を削除しました！"

  end
end
