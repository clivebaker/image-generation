class ImageController < ApplicationController
  
  $names = [
    {:id=>1, :name=>"Claudio Ortolina", :avatar=>"claudio.jpg" },
    {:id=>2, :name=>"Clive Baker", :avatar=>"clive.jpg" },
    {:id=>3, :name=>"Rimak Krivickas", :avatar=>"rimas.jpg" },
    {:id=>4, :name=>"Spencer Turner", :avatar=>"spencer.jpg" }  
    ]
    
  
  
  def index
    
    
    
    
  end

  def generate




    person = $names.select {|f| f[:id] == params["name"].to_i  }.first
    @name = person[:name]


    @position = params[:position]
    @outof = params[:outof]

    @time_start = Time.now.strftime('%H:%M:%S:%L')
    time = Time.now.strftime('%d %b %y %H:%M:%S')

    filename = (Time.now.to_f.to_s).delete(".")+'.jpg'
    source = File.join(Rails.root, 'public/ifp-world.jpg')
    @url_path_complete = File.join('/images/', filename )
    full_path_complete = File.join(Rails.root, 'public/images/', filename)
    avatar_path = File.join(Rails.root, 'public/avatars', person[:avatar])
    box_path = File.join(Rails.root, 'public', 'box_overlay.png')
    
    img = MiniMagick::Image.open(source)

    percentage = ((@position.to_f/@outof.to_f)*100).to_i
    percentage = percentage==100 ? 99 : percentage

    bounds = {:upper=>220, :lower=>5}

    box_location = (bounds[:upper]-bounds[:lower]) * (100-percentage) / 100 + bounds[:lower]


    img.combine_options do |c|
       c.font "NettoComp-Regular"
       c.pointsize "14" 
       c.fill "white"   
       c.draw "text 115,65 '#{@name}'"
       c.pointsize "40" 
       c.draw "text 115,100 '#{@position}'"
       c.pointsize "10" 
       c.draw "text 130,115 'out of #{@outof}'"
       c.fill "black"   
       c.draw "text 115,135 'created at #{time}'"
       
       c.draw "image over 13,49 0,0 '#{avatar_path}'"
       
       c.draw "image over #{box_location},142 0,0 '#{box_path}'"
       c.pointsize "9" 
       c.draw "text #{box_location+5},155 'TOP #{percentage}%'"
       
       
       
    end
           
     img.write(full_path_complete)
     @time_end = Time.now.strftime('%H:%M:%S:%L')



  end
end
