module BeginVcard
  module Parser40
    def version
      '4.0'
    end

    def work_phone
      @work_phone ||=
        phone_lines.detect{|line| line.split(';')[1].match(/work,voice/)}.split('tel:').last
    end
    
    def home_phone
      @home_phone ||=
        phone_lines.detect{|line| line.split(';')[1].match(/home,voice/)}.split('tel:').last
    end

    def n
      super.squeeze(',').gsub(/,$/,'')
    end
    alias :name :n
  end
end
