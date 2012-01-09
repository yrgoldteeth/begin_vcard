require 'minitest/autorun'
require './lib/begin_vcard/vcard'

VALID_21 = <<EOF
BEGIN:VCARD
VERSION:2.1
N:Chiclitz;Clayton
FN:Clayton Chiclitz
ORG:Yoyodyne Corp.
TITLE:Founder
TEL;WORK;VOICE:(111) 555-1212
TEL;HOME;VOICE:(404) 555-1212
ADR;WORK:PO Box 45;Suite 106;100 Waters Edge;San Narciso;CA;99999;United States of America
ADR;HOME:PO Box 46;Suite 105;49 W.A.S.T.E St.;San Narciso;CA;99999;United States of America
EMAIL;PREF;INTERNET:trystero@example.com
REV:20080494T195243Z
END:VCARD
EOF

VALID_30 = <<EOF
BEGIN:VCARD
VERSION:3.0
N:Chiclitz;Clayton
FN:Clayton Chiclitz
ORG:Yoyodyne Corp.
TITLE:Founder
PHOTO;VALUE=URL;TYPE=GIF:http://www.example.com/dir_photos/my_photo.gif
TEL;TYPE=WORK,VOICE:(111) 555-1212
TEL;TYPE=HOME,VOICE:(404) 555-1212
ADR;TYPE=WORK:PO Box 45;Suite 106;100 Waters Edge;San Narciso;CA;99999;United States of America
ADR;TYPE=HOME:PO Box 46;Suite 105;49 W.A.S.T.E St.;San Narciso;CA;99999;United States of America
EMAIL;TYPE=PREF,INTERNET:trystero@example.com
REV:2008-04-24T19:52:43Z
END:VCARD
EOF

VALID_40 = <<EOF
BEGIN:VCARD
VERSION:4.0
N:Chiclitz;Clayton;;;
FN:Clayton Chiclitz
ORG:Yoyodyne Corp.
TITLE:Founder
PHOTO:http://www.example.com/dir_photos/my_photo.gif
TEL;TYPE="work,voice";VALUE=uri:tel:+1-111-555-1212
TEL;TYPE="home,voice";VALUE=uri:tel:+1-404-555-1212
ADR;TYPE=work;LABEL="49 W.A.S.T.E St.\nSan Narciso, CA 99999\nUnited States of America"
:;;49 W.A.S.T.E St.;San Narciso;CA;99999;United States of America
EMAIL:trystero@example.com
REV:20080494T195243Z
END:VCARD
EOF

INVALID = <<EOF
BEGIN:VCARD
VERSION:99.0
END:VCARD
EOF

describe BeginVcard::Vcard do
  before do
    @vcard_21 = BeginVcard::Vcard.new(VALID_21)
    @vcard_30 = BeginVcard::Vcard.new(VALID_30)
    @vcard_40 = BeginVcard::Vcard.new(VALID_40)
  end
  
  describe '#email' do
    it 'returns the email' do
      @vcard_21.email.must_equal 'trystero@example.com'
      @vcard_30.email.must_equal 'trystero@example.com'
      @vcard_40.email.must_equal 'trystero@example.com'
    end
  end
  
  describe '#work_country / #home_country' do
    it 'returns the street address' do
      @vcard_21.work_country.must_equal 'United States of America'
      @vcard_21.home_country.must_equal 'United States of America'
      @vcard_30.work_country.must_equal 'United States of America'
      @vcard_30.home_country.must_equal 'United States of America'
    end
  end
  
  describe '#work_postal_code / #home_postal_code' do
    it 'returns the street address' do
      @vcard_21.work_postal_code.must_equal '99999'
      @vcard_21.home_postal_code.must_equal '99999'
      @vcard_30.work_postal_code.must_equal '99999'
      @vcard_30.home_postal_code.must_equal '99999'
    end
  end
  
  describe '#work_region / #home_region' do
    it 'returns the street address' do
      @vcard_21.work_region.must_equal 'CA'
      @vcard_21.home_region.must_equal 'CA'
      @vcard_30.work_region.must_equal 'CA'
      @vcard_30.home_region.must_equal 'CA'
    end
  end
  
  describe '#work_locality / #home_locality' do
    it 'returns the street address' do
      @vcard_21.work_locality.must_equal 'San Narciso'
      @vcard_21.home_locality.must_equal 'San Narciso'
      @vcard_30.work_locality.must_equal 'San Narciso'
      @vcard_30.home_locality.must_equal 'San Narciso'
    end
  end

  describe '#work_street_address / #home_street_address' do
    it 'returns the street address' do
      @vcard_21.work_street_address.must_equal '100 Waters Edge'
      @vcard_21.home_street_address.must_equal '49 W.A.S.T.E St.'
      @vcard_30.work_street_address.must_equal '100 Waters Edge'
      @vcard_30.home_street_address.must_equal '49 W.A.S.T.E St.'
    end
  end

  describe '#work_extended_address / #home_extended_address' do
    it 'returns the extended address' do
      @vcard_21.work_extended_address.must_equal 'Suite 106'
      @vcard_21.home_extended_address.must_equal 'Suite 105'
      @vcard_30.work_extended_address.must_equal 'Suite 106'
      @vcard_30.home_extended_address.must_equal 'Suite 105'
    end
  end
  
  describe '#work_po_box / #home_po_box' do
    it 'returns the extended address' do
      @vcard_21.work_po_box.must_equal 'PO Box 45'
      @vcard_21.home_po_box.must_equal 'PO Box 46'
      @vcard_30.work_po_box.must_equal 'PO Box 45'
      @vcard_30.home_po_box.must_equal 'PO Box 46'
    end
  end

  describe '#home_phone' do
    it 'returns the home phone record' do
      @vcard_21.home_phone.must_equal '(404) 555-1212'
      @vcard_30.home_phone.must_equal '(404) 555-1212'
      @vcard_40.home_phone.must_equal '+1-404-555-1212'
    end
  end

  describe '#work_phone' do
    it 'returns the work phone record' do
      @vcard_21.work_phone.must_equal '(111) 555-1212'
      @vcard_30.work_phone.must_equal '(111) 555-1212'
      @vcard_40.work_phone.must_equal '+1-111-555-1212'
    end
  end

  describe '#title' do
    it 'returns the title record' do
      @vcard_21.title.must_equal 'Founder'
      @vcard_30.title.must_equal 'Founder'
      @vcard_40.title.must_equal 'Founder'
    end
  end
  
  describe '#org' do
    it 'returns the organization record' do
      @vcard_21.org.must_equal 'Yoyodyne Corp.'
      @vcard_30.org.must_equal 'Yoyodyne Corp.'
      @vcard_40.org.must_equal 'Yoyodyne Corp.'
    end
  end

  describe '#fn / #formatted_name' do
    it 'returns the formatted name record' do
      @vcard_21.fn.must_equal 'Clayton Chiclitz'
      @vcard_30.formatted_name.must_equal 'Clayton Chiclitz'
      @vcard_40.fn.must_equal 'Clayton Chiclitz'
    end
  end

  describe '#n / #name' do
    it 'returns the name record' do
      @vcard_21.n.must_equal 'Chiclitz,Clayton'
      @vcard_30.name.must_equal 'Chiclitz,Clayton'
      @vcard_40.name.must_equal 'Chiclitz,Clayton'
    end
  end

  describe '#version' do
    it 'returns the version number' do
      @vcard_21.version.must_equal '2.1'
      @vcard_30.version.must_equal '3.0'
      @vcard_40.version.must_equal '4.0'
    end
  end

  describe '#initialize' do
    describe 'with a string that has an invalid vCard version' do
      it 'raises an ArgumentError' do
        proc {BeginVcard::Vcard.new(INVALID)}.must_raise ArgumentError, "Invalid vCard BEGIN or END"
      end
    end

    describe 'with a string missing valid BEGIN or END lines' do
      it 'raises an ArgumentError' do
        proc {BeginVcard::Vcard.new('ooooooo')}.must_raise ArgumentError, "Invalid vCard Version"
      end
    end
  end
end
