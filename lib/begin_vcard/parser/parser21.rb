module BeginVcard
  module Parser21
    def version
      '2.1'
    end

    def work_phone
      @work_phone ||=
        phone_lines.detect{|line| line.split(':').first.split(';')[1,2]==['WORK','VOICE']}.split(':').last
    end
    
    def home_phone
      @home_phone ||=
        phone_lines.detect{|line| line.split(':').first.split(';')[1,2]==['HOME','VOICE']}.split(':').last
    end
  end
end
