class Recommendations
  # -------------------------------------------------
  # Euclidean distance 
  # -------------------------------------------------
  
  # Returns a distance-based similarity score for person 1 and person 2
  
  def sim_distance( prefs, person1 , person2 )
    # Get the list of shared_items
    si = {}
    for item in prefs[person1].keys
      if prefs[person2].include? item
        si[item] = 1
      end
    end
    
    # if they have no ratings in common, return 0
    return 0 if si.length == 0
     # Add up the squares of all the differences
    squares = []
    for item in prefs[person1].keys
      if prefs[person2].include? item
        squares << (prefs[person1][item] - prefs[person2][item]) ** 2
      end
    end
    
    sum_of_squares = squares.inject { |sum,value| sum += value }
    return 1/(1 + sum_of_squares)
  end
  
  # Returns the Pearson correlation coefficient for p1 and p2
  def sim_pearson( prefs, p1, p2)
    # Get the list of mutually rated items
    si = {}
    for item in prefs[p1].keys
      si[item] = 1 if prefs[p2].include? item
    end

    # Find the number of elements
    n = si.length
    puts n 
    # If there are no ratings in common, return 0
    return 0 if n == 0

    # Add up all the preferences
    sum1 = si.keys.inject(0) { |sum,value| sum += prefs[p1][value] }
    sum2 = si.keys.inject(0) { |sum,value| sum += prefs[p2][value] }
    puts "sum1 #{sum1}"
    puts "sum2 #{sum2}"
    # Sum up the squares
    sum1Sq = si.keys.inject(0) { |sum,value| sum += prefs[p1][value] ** 2 }
    sum2Sq = si.keys.inject(0) { |sum,value| sum += prefs[p2][value] ** 2 }

    # Sum up the products
    pSum = si.keys.inject(0) { |sum,value| sum += (prefs[p1][value] * prefs[p2][value])}
    puts "pSum #{pSum}"
    # Calculate the Pearson score
    num = pSum - (sum1*sum2/n)
    puts "num #{num}"
    den = Math.sqrt((sum1Sq - (sum1 ** 2)/n) * (sum2Sq - (sum2 ** 2)/n))
    puts "den #{den}"
    return 0 if den == 0
    r = num / den
  end
  
  
  # Ranking the critics
  # TODO lacks the score-function-as-paramter aspect of original.
  
  def topMatches( prefs, person, n=5, scorefunc = :sim_pearson )
    scores = []
    for other in prefs.keys
      if scorefunc == :sim_pearson
        scores << [ sim_pearson(prefs,person,other), other] if other != person
      else
        scores << [sim_distance(prefs,person,other), other] if other != person
      end
    end
    return scores.sort.reverse.slice(0,n)
  end
  
  # Gets recommendations for a person by using a wieghted average
  # of every  other user's rankings
  # uses sim_pearson only
  def getRecommendations( prefs, person, scorefunc = :sim_pearson )
    totals = {}
    simSums = {}
    for other in prefs.keys
      # don't compare me to myself
      next if other == person
      
      if scorefunc == :sim_pearson
        sim = sim_pearson( prefs, person, other )
      else
        sim = sim_pearson( prefs, person, other )
      end
      puts "rec sim val: #{sim}"
      #ignore scores of zero or lower
      next if sim <= 0
      
      for item in prefs[other].keys
        # only score movies I haven't seen yet
        if !prefs[person].include? item or prefs[person][item] == 0
          # similarity * score
          totals.default = 0
          totals[item] += prefs[other][item] * sim
          # sum of similarities
          simSums.default = 0
          simSums[item] += sim
        end
      end
    end
    
    # create a normalised list
    rankings = []
    totals.each do |item,total|
      rankings << [total/simSums[item], item]
    end
    
    # Return the sorted list
    return rankings.sort.reverse
  end
  
  
end #recommendation class

class App
  def run
    # A dictionary of movie critics and their ratings of a small
    # set of movies
    critics = {'Lisa Rose'=> {'Lady in the Water'=> 2.5, 'Snakes on a Plane'=> 3.5,
 'Just My Luck'=> 3.0, 'Superman Returns'=> 3.5, 'You, Me and Dupree'=> 2.5, 
 'The Night Listener'=> 3.0},
 'Gene Seymour'=> {'Lady in the Water'=> 3.0, 'Snakes on a Plane'=> 3.5, 
 'Just My Luck'=> 1.5, 'Superman Returns'=> 5.0, 'The Night Listener'=> 3.0, 
 'You, Me and Dupree'=> 3.5}, 
 'Michael Phillips'=> {'Lady in the Water'=> 2.5, 'Snakes on a Plane'=> 3.0,
 'Superman Returns'=> 3.5, 'The Night Listener'=> 4.0},
 'Claudia Puig'=> {'Snakes on a Plane'=> 3.5, 'Just My Luck'=> 3.0,
 'The Night Listener'=> 4.5, 'Superman Returns'=> 4.0, 
 'You, Me and Dupree'=> 2.5},
 'Mick LaSalle'=> {'Lady in the Water'=> 3.0, 'Snakes on a Plane'=> 4.0, 
 'Just My Luck'=> 2.0, 'Superman Returns'=> 3.0, 'The Night Listener'=> 3.0,
 'You, Me and Dupree'=> 2.0}, 
 'Jack Matthews'=> {'Lady in the Water'=> 3.0, 'Snakes on a Plane'=> 4.0,
 'The Night Listener'=> 3.0, 'Superman Returns'=> 5.0, 'You, Me and Dupree'=> 3.5},
 'Toby'=> {'Snakes on a Plane'=>4.5,'You, Me and Dupree'=>1.0,'Superman Returns'=>4.0}
    }
    
    
  end
  
  def runS(h)
    
    # votes = {
    #       
    #       'Chirag' => { 'Slide 1' => 1, 'Slide 2' => 0, 'Slide 3' => -1, 'Slide 4' => 1, 'Slide 5' => 0, 'Slide 6' => -1, 'Slide 7' => 1 },
    #       'Zaid'   => { 'Slide 1' => 1, 'Slide 2' => -1, 'Slide 3' => -1, 'Slide 4' => 0, 'Slide 5' => 0, 'Slide 6' => 1 },
    #       'Fatos'  => { 'Slide 1' => -1, 'Slide 2' => 0, 'Slide 3' => 1, 'Slide 4' => -1, 'Slide 5' => 1, 'Slide 6' => 0 }
    #       
    #     }
    
     return h
    
  end
  
end

# app = App.new
# app.run
# 
# load "recommendations.rb"
# app = App.new
# recomm = Recommendations.new
# votes = app.runSmartvu


