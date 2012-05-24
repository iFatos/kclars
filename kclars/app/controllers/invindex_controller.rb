require 'stem.rb'
class InvindexController < ApplicationController
  include Stemmable
  attr_accessor :counts
 
  def initialize
    @counts = Hash.new { |h,k| h[k] = Hash.new(0) }
  end
  def index
   begin
   file = open("index.txt","r")
   s = file.read
   if s == "1"
   end
   rescue => e
    constructIndex
   end
   
   @invindices = Invindex.all  
  end

  def show
  end
 
  def constructIndex
   file = open("index.txt","w")
    file.write(1)
    file.close
   grouptext = "."
   eventstext = "."
   text = "."
   @groups = Group.all
   arr = []
   for x in 3..Group.all.length - 1
     puts "Groups " + x.to_s 
     grouptext = "."
     eventstext = "."
     text = "."
     title = Group.find(x).title != nil ? Group.find(x).title : "."
     description = Group.find(x).description != nil ? Group.find(x).description :  "."
     grouptext = grouptext + title + " " + description + "\n"
     for y in 0..Group.find(x).events.length
       print "  " + y.to_s
       eventtitle = (Group.find(x).events[y] != nil ? Group.find(x).events[y].title : ".")
       if arr.include?(eventtitle)
       else 
        arr << eventtitle
        eventdescription = Group.find(x).events[y] != nil ? Group.find(x).events[y].description :  "."
        eventstext = eventstext != nil ? eventstext : "."
        eventtitle = eventtitle != nil ? eventtitle : "."
        eventdescription = eventdescription != nil ? eventdescription : "."
        eventstext = eventstext + eventtitle + " " + eventdescription + "\n"
       end	
     end
     text = grouptext + " " + eventstext
    
     array_of_words = words_from_string("#{text}")
     count_frequency(array_of_words,x)

     
   end

   @counts.each_key { |key|
     saveEventInDB(key,@counts[key])}
  end


  def words_from_string(string)
   string.downcase.scan(/[\w']+/)
  end
  
  def count_frequency(word_list,docid)
   tf = Hash.new(0)
   dwords = 0
   for word in word_list
    if word.length > 2
     dwords += 1
     s_word = stem(word)
     tf[s_word] += 1
     @counts["#{s_word}"][docid] += 1
    end    
   end
   etf = euclideanNormalizedScore(tf)
   saveWordsInDoc(docid, dwords, etf)
  end

  def count_documents
   Group.all.size
  end

  def term_doc_occurrences(term)
   Invindex.find_by_word(term).docid.length
  end
 
  def euclideanNormalizedScore(t)
    sum = 0
    t.each { |k, v| sum += v ** 2}
    t.each { |k, v| p = t[k].to_f / sum; s = p.round(3); t[k] = s }
    return t
  end
  
  def inverse_doc_frequency(t)
    Math.log(count_documents.to_f / term_doc_occurrences(t))
  end

  

  def saveEventInDB(word, docid)
     index = Invindex.new(:word => word, :docid => docid)
     index.save 
  end
  
  

  def saveWordsInDoc(docid, words, tf)
   dword = Wordsdoc.new(:docid => docid, :words => words, :tf => tf)
   dword.save
  end 

  def show
    @word = Invindex.find(params[:id])
    @title = @word.word
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @word }
    end
  end
end
