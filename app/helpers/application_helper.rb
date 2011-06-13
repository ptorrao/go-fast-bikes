module ApplicationHelper
  
  def title
    base_title = "Go Fast Bikes"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
