require_relative 'spec_helper'
require 'awesome_print'

require 'libis/services/alma/web_service'
require 'libis/services/alma/sru_service'

describe 'Alma' do

  context 'API service' do
    let(:subject) { Libis::Services::Alma::WebService.new }
    let(:record) { Hash.new }

    context 'marc' do

      before {
        data = Libis::Services::Alma::SruService.new.search('alma.local_field_983', 'KYE000486')
        data = data.first.to_hash(:convert_tags_to => lambda { |tag| tag.snakecase.to_sym })

        record = data[:record]
        record[:controlfield][0] = '9930800070101480'
        record[:datafield].insert(1, {
            subfield: '(EXLNZ-32KUL_LIBIS_NETWORK)9930800070101471',
            :@tag => '035', :@ind1 => ' ', :@ind2 => ' '
        })
        record[:datafield] << {
            subfield: ['KADOC', 'online', '201609', 'W', 'Collectie Kerk en Leven', 'local'],
            :@tag => '996', :@ind1 => ' ', :@ind2 => ' '
        }
      }

      it 'get record' do
        result = subject.get_marc('9930800070101480', 'l7xx8879c82a7d7b453a887a6e6dca8300fd').
            to_hash(:convert_tags_to => lambda { |tag| tag.snakecase.to_sym })
        # ap result
        expect(result[:bib][:record]).to deep_include(record)
      end

    end

  end

  context 'SRU service' do
    let(:subject) { Libis::Services::Alma::SruService.new }
    let(:record) { Hash.new }

    context 'marc' do

      before {
        data = Libis::Services::Alma::WebService.new.get_marc('9930800070101480', 'l7xx8879c82a7d7b453a887a6e6dca8300fd').
            to_hash(:convert_tags_to => lambda { |tag| tag.snakecase.to_sym })
        record = data[:bib][:record]
        record.cleanup!
      }

      it 'search' do
        result = subject.search('alma.local_field_983', 'KYE000486')
        expect(result.size).to be 1
        result = result.first.to_hash(:convert_tags_to => lambda { |tag| tag.snakecase.to_sym })
        expect(result[:record]).to deep_include(record)
      end
    end
  end

end
