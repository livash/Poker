require_relative 'deck'
require_relative 'card_suits_faces'

class Hand
  include CardSuitsFaces
  attr_accessor :cards
  
  def initialize(cards)
    @cards = cards
  end
  
  #private
  
  def suits_hash
    return_hash = {}
    cards.each do |card|
      if return_hash[card.suit].nil?
        return_hash[card.suit] = 1
      else
        return_hash[card.suit] += 1
      end
    end

    return_hash
  end
  
  def faces_hash
    return_hash = {}
    cards.each do |card|
      if return_hash.has[card.face]
        return_hash[card.face] = 1
      else
        return_hash[card.face] += 1
      end
    end
    
    return_hash
  end
  
  def is_straight_flush?  
    is_flush? && is_straight?
  end
  
  # def sort
  #   @cards = @cards.sort do
  #     |x, y| FACE_VALUES[x.face] <=> FACE_VALUES[y.face]
  #   end
  #   @cards
  # end
  
  
  def is_four_kind?
    faces_hash.each do |val, count|
      return true if count == 4
    end
    
    false
  end
  
  def is_full_house?
    is_one_pair? && is_three_kind?
  end
  
  def is_flush?
    suits_hash.each do |suit, count|
      return true if count == 5
    end
    
    false
  end
  
  def is_straight?
    smallest = smallest_card
    aces = aces_array
    cars_ordered = []
    if smallest.face == 2 && aces.size == 1
      smallest = aces[0]
    elsif aces.size == 0
      ii = 0
      while ii <= 5 
        cards.each do |card|
          card.has_face?(FACE_VALUES.index(FACE_VALUES[smallest.face] + 1))
          ii += 1
        end
      end
    end 
    # iterate up to see that each next card is one larger than the previous one
    
    
  end
  
  def has_face?(card)
    @cards.include?(card)
  end
  
  def aces_array
    aces_arr = []
    cards.each do |card|
      aces_arr << card if card.face == :A
    end
    
    aces_arr
  end
  
  def smallest_card #but not ace
    small = cards[0]
    ace_card = nil
    cards.each do |card|
      next if card.face == :A
      small = card if FACE_VALUES[small.face] > FACE_VALUES[card.face]
    end
    
    small
  end
  
  def is_three_kind?
    faces_hash.each do |val, count|
      rturn true if count == 3
    end
    
    false
  end
  
  def is_two_pair?
    pairs == 2
  end
  
  def is_one_pair?
    pairs == 1
  end  
  
  def pairs
    pair_count = 0
    faces_hash.each do |val, count|
      pair_count += 1 if count == 2
    end
    
    pair_count
  end
  
  def high_card
    h_card = cards[0]
    cards.each do |card|
      return card if card.face == :A
      h_card = card if FACE_VALUES[h_card.face] > FACE_VALUES[card.face]
    end
    
    h_card
  end
  
end