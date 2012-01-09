module BeginVcard
  class Result
    include Enumerable

    attr_accessor :cards

    def initialize card_list=[]
      @cards = card_list
    end

    def each
      cards.each{|c| yield c}
    end

    def push card
      cards << card
    end
    alias :<< :push

  end
end
