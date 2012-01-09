require './lib/begin_vcard/parser/parser21'
require './lib/begin_vcard/parser/parser30'
require './lib/begin_vcard/parser/parser40'
module BeginVcard
  module Parser
    private
    def lines_at key
      vcard_lines.select{|line| line.split(':').first.split(';').first == key}
    end

    def phone_lines
      lines_at('TEL')
    end

    def address_lines
      lines_at('ADR')
    end

    def determine_version
      case vcard_lines[1].split(':').last
      when '2.1'
        self.extend Parser21
      when '3.0'
        self.extend Parser30
      when '4.0'
        self.extend Parser40
      else
        raise ArgumentError, "Invalid vCard Version"
      end
    end

    def ensure_valid_vcard
      unless vcard_lines.first.match(/BEGIN:VCARD/) && vcard_lines.last.match(/END:VCARD/)
        raise ArgumentError, "Invalid vCard BEGIN or END"
      end
    end
    
    def work_address_raw
      @work_address_raw ||=
        address_lines.detect{|line| line.split(';')[1].match(/WORK/)}.split(':').last
    end
    def home_address_raw
      @home_address_raw ||=
        address_lines.detect{|line| line.split(';')[1].match(/HOME/)}.split(':').last
    end
  end
end
