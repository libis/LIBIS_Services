require_relative 'spec_helper'

require 'libis/services/scope/search'
require 'libis-tools'
require 'awesome_print'

describe 'Scope search service' do
  let(:credentials) { Libis::Tools::ConfigFile.new File.join(File.dirname(__FILE__), 'credentials-test.yml') }
  let(:subject) {
    scope = Libis::Services::Scope::Search.new
    # noinspection RubyResolve
    scope.connect(credentials.scope_user, credentials.scope_passwd)
    scope
  }

  context 'query' do

    it 'by repcode' do
      data = {
          'dc:title' => 'Archief Sint-Vincentius a Paulogenootschap, Conferentie Onze-Lieve-Vrouw van de Rozenkrans Antwerpen',
          'dc:identifier' => ['BE/942855/580(ref.code)'],
          'dc:source' => ['BE/942855/580']
      }
      result = subject.query 'BE-942855-580', type: 'REPCODE'
      expect(result).to be_a(Libis::Tools::XmlDocument)
      expect(result.to_hash['record']).to deep_include(data)
    end

    it 'by id' do
      data = {
          'dc:title' => 'Archief Constant Guillaume Van Crombrugghe',
          'dc:identifier' => ['BE/942855/1569 (ref.code)'],
          'dc:source' => ['BE/942855/1569']
      }
      result = subject.query '332785', type: 'ID'
      expect(result).to be_a(Libis::Tools::XmlDocument)
      expect(result.to_hash['dc:record']).to deep_include(data)
    end

  end

end
