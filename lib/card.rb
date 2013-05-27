
require_relative 'card_suits_faces'
class Card
  include CardSuitsFaces
  attr_reader :suit, :face
  
  def initialize(suit, face)
    @suit = suit
    @face = face
  end
  
  def <=>(another_card)
      if FACE_VALUES[self.face] < FACE_VALUES[another_card.face]
        -1
      elsif FACE_VALUES[self.face] > FACE_VALUES[another_card.face]
        1
      else
        0
      end
    end
  
end