class ImageController < ApplicationController
  def index
  end

  def generate

    @name = params[:name]

    @position = params[:position]
    @outof = params[:outof]

    @time_start = Time.now.strftime('%H:%M:%S:%L')
    time = Time.now.strftime('%d %b %y %H:%M:%S')

    filename = (Time.now.to_f.to_s).delete(".")+'.jpg'
    source = File.join(Rails.root, 'public/ifp-world.jpg')
    @url_path_complete = File.join('/images/', filename )
    full_path_complete = File.join(Rails.root, 'public/images/', filename)
    img = MiniMagick::Image.open(source)


    img.combine_options do |c|
       c.font "Arial"
       c.pointsize "14" 
       c.fill "white"   
       c.draw "text 115,65 '#{@name}'"
       c.pointsize "40" 
       c.draw "text 115,100 '#{@position}'"
       c.pointsize "10" 
       c.draw "text 130,115 'out of #{@outof}'"
       c.fill "black"   
       c.draw "text 115,135 'created at #{time}'"
    end
           
     img.write(full_path_complete)
     @time_end = Time.now.strftime('%H:%M:%S:%L')



  end
end
