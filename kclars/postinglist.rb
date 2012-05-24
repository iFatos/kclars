#Postings lists
#get the hash
i = Invindex.find_by_word("intelligence").docid
@si = " "
#convert the hash to a long string consiting of doc ids
i.each do |s|
  @si = @si + s[0].to_s + " "
end
#create an array of the @si string
p2 = @si.split(' ')
#convert each string element in the array to an integer
p2n = p2.map{|p| p.to_i}
#sort the array
p2n_sorted = p2n.sort
