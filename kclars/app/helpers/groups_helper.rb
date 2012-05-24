module GroupsHelper
  
  def truncate_desc(description)
    wordcount = 4
    if description != nil
    description.split[0..(wordcount-1)].join(" ") + (description.split.size > wordcount ? "..." : "")
    end
  end

  def truncate_descevent(description)
   
    charcount = 30
    if description != nil
      description.length > charcount ? (description[0..30] + "...") : description
    end
  end
  
end
