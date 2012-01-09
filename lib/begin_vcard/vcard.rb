require './lib/begin_vcard/parser'
module BeginVcard
  class Vcard
    include Parser
    attr_reader :vcard_lines

    def initialize card_str
      @vcard_lines = card_str.lines.to_a.map(&:strip)
      ensure_valid_vcard
      determine_version
    end

    def org
      @org ||= lines_at('ORG').last.split(':').last
    end

    def title
      @title ||= lines_at('TITLE').last.split(':').last
    end
    
    def work_po_box
      work_address_raw.split(';')[0]
    end

    def work_extended_address
      work_address_raw.split(';')[1]
    end

    def work_street_address
      work_address_raw.split(';')[2]
    end

    def work_locality
      work_address_raw.split(';')[3]
    end
    alias :work_city :work_locality 

    def work_region
      work_address_raw.split(';')[4]
    end
    alias :work_state :work_region
    alias :work_province :work_region

    def work_postal_code
      work_address_raw.split(';')[5]
    end
    alias :work_zip :work_postal_code
    alias :work_zip_code :work_postal_code

    def work_country
      work_address_raw.split(';')[6]
    end
    
    def home_po_box
      home_address_raw.split(';')[0]
    end

    def home_extended_address
      home_address_raw.split(';')[1]
    end

    def home_street_address
      home_address_raw.split(';')[2]
    end

    def home_locality
      home_address_raw.split(';')[3]
    end
    alias :home_city :home_locality 

    def home_region
      home_address_raw.split(';')[4]
    end
    alias :home_state :home_region
    alias :home_province :home_region

    def home_postal_code
      home_address_raw.split(';')[5]
    end
    alias :home_zip :home_postal_code
    alias :home_zip_code :home_postal_code

    def home_country
      home_address_raw.split(';')[6]
    end

    def email
      lines_at('EMAIL').last.split(':').last
    end
    
    def fn
      @fn ||= lines_at('FN').last.split(':').last
    end
    alias :formatted_name :fn

    # overridden in 4.0 parser module
    def n
      @n ||= lines_at('N').last.split(':').last.gsub(';',',')
    end
    alias :name :n
  end
end
