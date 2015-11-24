require_relative 'spec_helper'
require 'awesome_print'

require 'libis/services/alma/web_service'

describe 'Alma web service' do
  let(:subject) { Libis::Services::Alma::WebService.new }

  context 'marc' do

    let(:record) {
      {
          leader: '01206nas  2200337u  4500',
          controlfield: ['9930800070101480', '20151015113543.0', '881205c19679999be  r|p||     0|||a|dut c'],
          datafield: [
              {
                  subfield: '(BeLVLBS)003080007LBS01-Aleph',
                  :@tag => '035', :@ind1 => ' ', :@ind2 => ' '
              }, {
                  subfield: '(EXLNZ-32KUL_LIBIS_NETWORK)9930800070101471',
                  :@tag => '035', :@ind1 => ' ', :@ind2 => ' '
              }, {
                  subfield: 'Kerk en leven. Bisdom Antwerpen (0991).',
                  :@tag => '245', :@ind1 => '0', :@ind2 => '0'
              }, {
                  subfield: 'K & L',
                  :@tag => '246', :@ind1 => '3', :@ind2 => '3'
              }, {
                  subfield: ['Antwerpen', 'Kerk en leven,', '1967-.'],
                  :@tag => '260', :@ind1 => ' ', :@ind2 => ' '
              }, {
                  subfield: 'Weekly',
                  :@tag => '310', :@ind1 => ' ', :@ind2 => ' '
              }, {
                  subfield: %w(text rdacontent),
                  :@tag => '336', :@ind1 => ' ', :@ind2 => ' '
              }, {
                  subfield: %w(computer rdamedia),
                  :@tag => '337', :@ind1 => ' ', :@ind2 => ' '
              }, {
                  subfield: ['online resource', 'rdacarrier'],
                  :@tag => '338', :@ind1 => ' ', :@ind2 => ' '
              }, {
                  subfield: 'Online',
                  :@tag => '340', :@ind1 => ' ', :@ind2 => ' '
              }, {
                  subfield: 'Digitale kopie van de gedrukte uitgave',
                  :@tag => '500', :@ind1 => ' ', :@ind2 => ' '
              }, {
                  subfield: 'E-journals',
                  :@tag => '653', :@ind1 => ' ', :@ind2 => '6'
              }, {
                  subfield: 'Collectie Kerk en Leven',
                  :@tag => '699', :@ind1 => ' ', :@ind2 => ' '
              }, {
                  subfield: ['KADOC', 'C1', 'Kerken en religie', '(ODIS-HT)'],
                  :@tag => '650', :@ind1 => ' ', :@ind2 => '7'
              }, {
                  subfield: ['KADOC', 'Antwerpen [deelgemeente in gemeente Antwerpen - BE]', '(ODIS-GEO)10560000006504'],
                  :@tag => '650', :@ind1 => ' ', :@ind2 => '7'
              }, {
                  subfield: ['KADOC', 'Bisdom Antwerpen (1961-heden)', '(ODIS-ORG)9284'],
                  :@tag => '650', :@ind1 => ' ', :@ind2 => '7'
              }, {
                  subfield: ['KADOC', 'Studiecentrum voor Zielzorg en Predicatie', '(ODIS-ORG)24894'],
                  :@tag => '650', :@ind1 => ' ', :@ind2 => '7'
              }, {
                  subfield: 'KYE000486',
                  :@tag => '983', :@ind1 => ' ', :@ind2 => ' '
              }, {
                  subfield: ['EKAD', '(2007)39-42, 44, 46-49, 51-52'],
                  :@tag => '993', :@ind1 => ' ', :@ind2 => ' '
              }, {
                  subfield: ['EKAD', '(2008)1-28, 32-53'],
                  :@tag => '993', :@ind1 => ' ', :@ind2 => ' '
              }, {
                  subfield: ['EKAD', '(2009)1-34, 36-38'],
                  :@tag => '993', :@ind1 => ' ', :@ind2 => ' '
              }, {
                  subfield: ['EKAD', '(2011)1-13, 15-36, 45-52'],
                  :@tag => '993', :@ind1 => ' ', :@ind2 => ' '
              }, {
                  subfield: ['EKAD', 'KADOC elektronische tijdschriften'],
                  :@tag => '995', :@ind1 => ' ', :@ind2 => ' '
              }, {
                  subfield: ['EKAD', 'KADOC lopende periodiek'],
                  :@tag => '995', :@ind1 => ' ', :@ind2 => ' '
              }, {
                  subfield: ['KADOC', 'online', '201510', 'W', 'Collectie Kerk en Leven', 'local'],
                  :@tag => '996', :@ind1 => ' ', :@ind2 => ' '
              }
          ],
      }
    }

    it 'get record' do
      result = subject.get_marc('9930800070101480', 'l7xx8879c82a7d7b453a887a6e6dca8300fd').
          to_hash(:convert_tags_to => lambda { |tag| tag.snakecase.to_sym })
      check_container(record, result[:bib][:record])
    end

  end

end