module EventsHelper
  def truncate_descevent(description)
   
    charcount = 30
    if description != nil
      description.length > charcount ? (description[0..30] + "...") : description
    end
  end
end
