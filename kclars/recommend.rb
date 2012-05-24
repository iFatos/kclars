#
# Author: Fatos Ismali
#
#
class Fatos

def first(s)
@s = s.queryvector
h = Hash.new(0)
h2 = Hash.new(0)
@s = Hash[@s.sort_by {|k, v| -v}[0..10]]
#get the doc ids that the query terms appear in 

@s.keys.each do |w|
     if Invindex.find_by_word(w).nil?
     else
       sorted = Hash[Invindex.find_by_word(w).docid.sort_by {|k, v| -v}[0..50]]
     sorted.keys.each do |k|
         h2[k] +=1	
      end
     end
   end
 return h2
end

#sort hash by keys - smallest to largest
def second(h2)
b = Hash[h2.sort_by { |k, v| k}]

sq = @s.keys

sum = 0 
@count = 1
rec_hash = Hash.new(0)
h2.each {|k, v|
   @count += 1
   puts @count
   sq.each do |word|
       if Wordsdoc.find_by_docid(k).tf.include?(word)
       sum += Wordsdoc.find_by_docid(k).tf[word] * @s[word] 
       end
     end
   rec_hash[k] = sum 
   sum = 0
   }

sorted_hash = Hash[rec_hash.sort_by {|k, v| -v}[0..10]]
makeRecommendations(sorted_hash)
end
@array = []
def makeRecommendations(h)
 @array = []
 h.keys.each do |x|
   @array << Group.find(x).title
 end
 return @array
end 

end


