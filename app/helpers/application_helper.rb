module ApplicationHelper
  
  def title
    base_title = "Go Fast Bikes"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def logo
    logo = image_tag("logo.png", :alt => "Go Fast Bikes", :class => "round", :size => "975x190" )
  end	
end
