# testing file

require 'minitest/spec'
require 'minitest/autorun'

require_relative './hw6provided'
require_relative './hw6assignment'

# manually tested for most gameplay

describe MyTetris do
  it "should be a direct subclass of Tetris" do
    MyTetris.superclass.must_equal Tetris
  end
end

describe MyBoard do
  it "should be a direct subclass of Board" do
    MyBoard.superclass.must_equal Board
  end
end

describe MyPiece do
  it "should be a direct subclass of Piece" do
    MyPiece.superclass.must_equal Piece
  end

  it "should have the original 7 in All_My_Pieces" do
    (MyPiece::All_My_Pieces & Piece::All_Pieces).must_equal Piece::All_Pieces
  end
  
  it "should_have_all_pieces_size_equal_to_10" do
    MyPiece::All_My_Pieces.size.must_equal 10
  end
  
  it "should have single cheater block" do
    MyPiece::Cheater_Block.size.must_equal 1
  end
  
  it "should have triple nested cheater block" do
    MyPiece::Cheater_Block[0][0].must_equal [0, 0]
  end
end