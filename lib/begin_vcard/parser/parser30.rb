module BeginVcard
  module Parser30
    def version
      '3.0'
    end
    
    def home_phone
      @home_phone ||=
        phone_lines.detect{|line| line.split(':').first.split(';').last == 'TYPE=HOME,VOICE'}.split(':').last
    end

    def work_phone
      @work_phone ||=
        phone_lines.detect{|line| line.split(':').first.split(';').last == 'TYPE=WORK,VOICE'}.split(':').last
    end
  end
end
