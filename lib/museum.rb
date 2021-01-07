class Museum
  attr_reader :name,
              :exhibits,
              :patrons,
              :revenue

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
    @revenue = 0
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    @exhibits.find_all do |exhibit|
      patron.interests.include?(exhibit.name)
    end
  end

  def admit(patron)
    max = recommend_exhibits(patron).max_by do |exhibit|
      exhibit.cost
    end
    recommend_exhibits(patron).find_all do |exhibit|
        if exhibit.cost <= patron.spending_money
          patron.spending_money -= max.cost
          @revenue += patron.spending_money
        end
    end
    @patrons << patron
  end

  def patrons_by_exhibit_interest
    hash = Hash.new
    @exhibits.map do |exhibit|
      hash[exhibit] = @patrons.find_all do |patron|
        patron.interests.include?(exhibit.name)
      end
    end
    hash
  end

  def ticket_lottery_contestants(exhibit)
    lottery = []
    @patrons.find_all do |patron|
      patron.spending_money < exhibit.cost && patron.interests.include?(exhibit.name)
    end
  end

  def draw_lottery_winner(exhibit)
    ticket_lottery_contestants(exhibit).sample
  end

  def announce_lottery_winner(exhibit)
    return "No winners for this lottery" if draw_lottery_winner(exhibit).nil?
    "#{draw_lottery_winner(exhibit).name} has won the #{exhibit.name} exhibit lottery!"
  end

  def patrons_of_exhibit
    hash = Hash.new
    @exhibits.map do |exhibit|
      hash[exhibit] = @patrons.find_all do |patron|
        patron.spending_money > exhibit.cost && patron.interests.include?(exhibit.name)
      end
    end.flatten
  end

  def attend(patron)
    patron.spending_money -= exhibit.cost
    @revenue += patron.spending_money
  end


end
