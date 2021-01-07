class Exhibit
  attr_accessor :name,
                :cost

    def initialize(info)
      @name = info[:name]
      @cost = info[:cost]
    end


end
