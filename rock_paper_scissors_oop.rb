class Hand
  include Comparable
  attr_reader :choice
  def initialize(choice)
    @choice = choice
  end
  def <=>(another_player)
    if @choice == another_player.choice
      0
    elsif @choice == "r" && another_player.choice == "s" || @choice == "p" && another_player.choice == "r" ||
          @choice == "s" && another_player.choice == "p"
      1
    else
      -1
    end
  end
end

class Player
  attr_reader :name
  attr_accessor :hand
  def initialize(name)
    @name = name
  end
  def to_s
    "#{name} picks #{self.hand.choice}"
  end
end

class Human < Player
  def pick_hand
    begin
      puts "(P|R|S)"
      valid_choice = gets.chomp.downcase
    end until Game::CHOICES.keys.include?(valid_choice)
    self.hand = Hand.new(valid_choice)
  end
end

class Computer < Player
  def pick_hand
    self.hand = Hand.new(Game::CHOICES.keys.sample)
  end
end

class Game
  CHOICES = {"r" => "Rock", "p" => "Paper", "s" => "Scissors"}
  attr_reader :player, :computer
  def initialize
    puts "What´s your name?"
    @player = Human.new(gets.chomp.downcase.capitalize)
    @computer = Computer.new("WOPR")
  end
  def play
    player.pick_hand
    computer.pick_hand
    compare_hands
  end
  def compare_hands
    if player.hand == computer.hand
      puts "It´s a tie!"
    elsif player.hand > computer.hand
      puts "#{player.name} Wins !!"
    else
      puts "#{computer.name} Wins !!"
    end
  end
end

Game.new.play