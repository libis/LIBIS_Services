require_relative 'spec_helper'
require 'awesome_print'

require 'libis/services/primo/limo'

describe 'Primo Limo service' do
  let(:subject) { Libis::Services::Primo::Limo.new }

  context 'marc' do

    let(:record) {
      {
          leader: '10244cam  2200409 i 4500',
          controlfield: ['20150326194601.0', '130610s2014    xxk      b    001 0 eng  ', '9992161785401471'],
          datafield: [
              {
                  subfield: %w(9781444167245 paperback),
                  :@tag => '020', :@ind1 => ' ', :@ind2 => ' '
              }, {
                  subfield: '40023930092',
                  :@tag => '024', :@ind1 => '8', :@ind2 => ' '
              }, {
                  subfield: '(BeLVLBS)9992161785401471',
                  :@tag => '035', :@ind1 => ' ', :@ind2 => ' '
              }, {
                  subfield: %w(DLC eng rda),
                  :@tag => '040', :@ind1 => ' ', :@ind2 => ' '
              }, {
                  subfield: ['The companion to development studies', 'edited by Vandana Desai and Robert B. Potter.'],
                  :@tag => '245', :@ind1 => '0', :@ind2 => '4'
              }, {
                  subfield: '3rd ed.',
                  :@tag => '250', :@ind1 => ' ', :@ind2 => ' '
              }, {
                  subfield: %w(London Routledge 2014.),
                  :@tag => '264', :@ind1 => ' ', :@ind2 => '1'
              }, {
                  subfield: ['XXII, 603 p.', '25 cm'],
                  :@tag => '300', :@ind1 => ' ', :@ind2 => ' '
              }, {
                  subfield: %w(text txt rdacontent),
                  :@tag => '336', :@ind1 => ' ', :@ind2 => ' '
              }, {
                  subfield: %w(unmediated n rdamedia),
                  :@tag => '337', :@ind1 => ' ', :@ind2 => ' '
              }, {
                  subfield: %w(volume nc rdacarrier),
                  :@tag => '338', :@ind1 => ' ', :@ind2 => ' '
              }, {
                  subfield: 'Development in a global-historical context / Ruth Craggs -- The Third World, developing countries, the South, emerging markets and rising powers / Klaus Dodds -- The nature of development studies / Robert B. Potter -- The impasse in development studies / Frans J. Schuurman -- Development and economic growth / A.P. Thirlwall -- Development and social welfare/human rights / Jennifer A. Elliott -- Development as freedom / Patricia Northover -- Race and development / Denise Ferreira da Silva -- Culture and development / Susanne Schech -- Ethics and development / Des Gasper -- New institutional economics and development / Philipp Lepenies -- Measuring development : from GDP to the HDI and wider approaches / Robert B. Potter -- The measurement of poverty / Howard White -- The millennium development goals / Jonathan Rigg -- BRICS and development / José E. Cassiolato -- Theories, strategies and ideologies of development : an overview / Robert B. Potter^^^^',
                  :@tag => '505', :@ind1 => '0', :@ind2 => ' '
              }, {
                  subfield: ['^^', "Smith, Ricardo and the world marketplace, 1776 to 2012 : back to the future and beyond / David Sapsford -- Enlightenment and the era of modernity / Marcus Power -- Dualistic and unilinear concepts of development / Tohy Binns -- Neoliberalism : globalization's neoconservative enforce of austerity / Dennis Conway -- Dependency theories : from ECLA to Andre Gunder Frank and beyond / Dennis Conway and Nikolas Heynen -- The New World Group of dependency scholars : reflections of a Caribbean avant-garde movement / Don D. Marshall -- World-systems theory : core, semiperipheral, and peripheral regions / Thomas Klak -- Indigenous knowledge and development / John Briggs -- Participatory development / Giles Mohan -- Postcolonialism / Cheryl McEwan -- Postmodernism and development / David Simon -- Post-development / James D. Sidaway -- Social capital and development / Anthony Bebbington and Katherine E. Foo -- Globalisation : an overview / Andrew Herod^^^^"],
                  :@tag => '505', :@ind1 => '0', :@ind2 => ' '
              }, {
                  subfield: ['^^', 'The new international division of labour / Alan Gilbert -- Global shift : industrialization and development / Ray Kiely -- Globalisation/localisation and development / Warwick E. Murray and John Overton -- Trade and industrial policy in developing countries / David Greenaway and Chris Milner -- The knowledge-based economy and digital divisions of labour / Mark Graham -- Corporate social responsibility and development / Dorothea Kleine -- The informal economy in cities of the South / Sylvia Chant -- Child labour / Sally Lloyd-Evans -- Migration and transnationalism / Katie D. Willis -- Diaspora and development / Claire Mercer and Ben Page -- Rural poverty / Edward Heinemann -- Rural livelihoods in a context of new scarcities / Annelies Zoomers -- Food security / Richard Tiffin -- Famine / Stephen Devereux -- Genetically modified crops and development / Matin Qaim -- Rural cooperatives : a new millennium? / Deborah R. Sick, Baburao S. Baviskar and Donald W. Attwood^^^^'],
                  :@tag => '505', :@ind1 => '0', :@ind2 => ' '
              }, {
                  subfield: ['^^', 'Land reform / Ruth Hall, Saturnino M. Borras Jr. and Ben White -- Gender, agriculture and land rights / Susie Jacobs -- The sustainable intensification of agriculture / Jules Pretty -- Urbanization in low- and middle-income nations in Africa, Asia and Latin America / David Satterthwaite -- Urban bias / Gareth A. Jones and Stuart Corbridge -- Global cities and the production of uneven development / Christof Parnreiter -- Studies in comparative urbanism / Colin McFarlane -- Prosperity or poverty? : Wealth, inequality and deprivation in urban areas / Carole Rakodi -- Housing the urban poor / Alan Gilbert -- Urbanization and environment in low- and middle-income nations / David Satterthwaite -- Transport and urban development / Eduardo Alcantara Vasconcellos -- Cities, crime and development / Paula Meth -- Sustainable development / Michael Redclift -- International regulation and the environment / Giles Atkinson --'],
                  :@tag => '505', :@ind1 => '0', :@ind2 => ' '
              }, {
                  subfield: "Climate change and development / Emily Boyd -- A changing climate and African development / Chukwumerije Okereke -- Vulnerability and disasters / Terry Cannon -- Ecosystem services and development / Tim Daw -- Natural resource management : a critical appraisal / Jayalaxshmi Mistry -- Water and hydropolitics / Jessica Budds and Alex Loftus -- Energy and development / Subhes C. Bhattacharyya -- Tourism and environment / Matthew Louis Bishop -- Transport and sustainability : developmental pathways / Robin Hickman -- Demographic change and gender / Tiziana Leone and Ernestina Coast -- Women and the state / Kathleen Staudt -- Gender, families and households / Ann Varley -- Feminism and feminist issues in the South : a critique of the \"development\" paradigm / Madhu Purnima Kishwar -- Rethinking gender and empowerment / Jane Parpart -- Gender and globalisation / Harriot Beazley and Vandana Desai^^^^",
                  :@tag => '505', :@ind1 => '8', :@ind2 => ' '
              }, {
                  subfield: ['^^', "Migrant women in the new economy : understanding the gender-migration-care nexus / Kavita Datta -- Women and political representation / Shirin M. Rai -- Sexuality and development / Andrea Cornwall -- Indigenous fertility control / Tulsi Patel -- Nutritional problems, policies and intervention strategies in developing economies / Prakash Shetty -- Motherhood, mortality and health care / Maya Unnithan-Kumar -- The development impacts of HIV/AIDS / Lora Sabin, Marion McNabb, and Mary Bachman DeSilva -- Ageing and poverty / Vandana Desai -- Health disparity : from \"health inequality\" to \"health inequity\" : the move to a moral paradigm in global health disparity / Hazel R. Barrett -- Disability / Ruth Evans -- Social protection in development context / Sarah Cook and Katja Hujo -- Female participation in education / Christopher Colclough -- The challenge of skill formation and training / Jeemol Unni^^^^"],
                  :@tag => '505', :@ind1 => '8', :@ind2 => ' '
              }, {
                  subfield: ['^^', "Development education, global citizenship and international volunteering / Matt Baillie Smith -- Gender- and age-based violence / Cathy McIlwaine -- Fragile states / Tom Goodfellow -- Refugees / Richard Black and Ceri Oeppen -- Humanitarian aid / Phil O'Keefe and Joanne Rose -- Global war on terror, development and civil society / Jude Howell -- Peace-building partnerships and human security / Timothy M. Shaw -- Nationalism / Michel Seymour -- Ethnic conflict and the state / Rajesh Venugopal -- Religions and development / Emma Tomalin -- Foreign aid in a changing world / Stephen Brown -- The rising powers as development donors and partners / Emma Mawdsley -- Aid conditionality / Jonathan R.W. Temple -- Aid effectiveness / Jonathan Glennie -- Global governance issues and the current crisis / Isabella Massa and José Brambila-Macias -- Change agents : a history of hope in NGOs, civil society, and the 99% / Alison Van Rooy -- Corruption and development / Susan Rose-Ackerman^^^^"],
                  :@tag => '505', :@ind1 => '8', :@ind2 => ' '
              }, {
                  subfield: ['^^', "The role of non-governmental organizations (NGOs) / Vandana Desai -- Non-government public action networks and global policy processes / Barbara Rugendyke -- Multilateral institutions : \"developing countries\" and \"emerging markets\" : stability or change? / Morten Bøås -- Is there a legal right to development? / Radha D'Souza."],
                  :@tag => '505', :@ind1 => '8', :@ind2 => ' '
              }, {
                  subfield: ["\"With over 115 concise and authoritative chapters covering a wide range of disciplines the book is divided into ten sections covering the nature of development, the theories and strategies of development, rural development, urbanization, gender, globalization, health and education, the political economy of violence and insecurity, environment and development, governance and development. This new third edition of The Companion to Development Studies is an essential read for students of development studies at all levels - from undergraduate to graduate - and across several disciplines including geography, international relations, politics, economics, sociology and anthropology\"--", 'Provided by publisher.'],
                  :@tag => '520', :@ind1 => ' ', :@ind2 => ' '
              }, {
                  subfield: ["\"The Companion to Development Studies contains over 109 chapters written by leading international experts within the field to provide a concise and authoritative overview of the key theoretical and practical issues dominating contemporary development studies. Covering a wide range of disciplines the book is divided into ten sections, each prefaced by a section introduction written by the editors. The sections cover: the nature of development, theories and strategies of development, globalization and development, rural development, urbanization and development, environment and development, gender, health and education, the political economy of violence and insecurity, and governance and development. This third edition has been extensively updated and contains 45 new contributions from leading authorities, dealing with pressing contemporary issues such as race and development, ethics and development, BRICs and development, global financial crisis, the knowledge based economy and digital divide, food security, GM crops, comparative urbanism, cities and crime, energy, water hydropolitics, climate change, disability, fragile states, global war on terror, ethnic conflict, legal rights to development, ecosystems services for development, just to name a few. Existing chapters have been thoroughly revised to include cutting-edge developments, and to present updated further reading and websites\"--", 'Provided by publisher.'],
                  :@tag => '520', :@ind1 => ' ', :@ind2 => ' '
              }, {
                  subfield: 'Includes bibliographical references and index.',
                  :@tag => '504', :@ind1 => ' ', :@ind2 => ' '
              }, {
                  subfield: 'Economic development.',
                  :@tag => '650', :@ind1 => ' ', :@ind2 => '0'
              }, {
                  subfield: 'Development economics.',
                  :@tag => '650', :@ind1 => ' ', :@ind2 => '0'
              }, {
                  subfield: 'Globalization.',
                  :@tag => '650', :@ind1 => ' ', :@ind2 => '0'
              }, {
                  subfield: %w(UDC 304.5 Development),
                  :@tag => '650', :@ind1 => ' ', :@ind2 => '7'
              }, {
                  subfield: ['Developing countries', 'Social conditions.'],
                  :@tag => '651', :@ind1 => ' ', :@ind2 => '0'
              }, {
                  subfield: ['Desai, Vandana', '1965-', 'edt'],
                  :@tag => '700', :@ind1 => '1', :@ind2 => ' '
              }, {
                  subfield: ['Potter, Robert B.', 'edt'],
                  :@tag => '700', :@ind1 => '1', :@ind2 => ' '
              }, {
                  subfield: %w(32KUL_LIBIS_NETWORK P 71174288370001471),
                  :@tag => 'INST', :@ind1 => ' ', :@ind2 => ' '
              }, {
                  subfield: %w(32KUL_KUL P 21355561730001488),
                  :@tag => 'INST', :@ind1 => ' ', :@ind2 => ' '
              }
          ],
          :@xmlns => 'http://www.loc.gov/MARC21/slim', :'@xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance', :'@xsi:schema_location' => 'http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd'
          # }
      }
    }

    it 'get record' do
      result = subject.get_marc('32LIBIS_ALMA_DS71174288370001471')
      if result.is_a?(Libis::Tools::XmlDocument)
        result = result.to_hash(:convert_tags_to => lambda { |tag| tag.snakecase.to_sym })
        check_container(record, result[:record])
      end
    end

  end

  context 'pnx' do

    let(:record) {
      {
          control: {
              sourcerecordid: '71174288370001471',
              sourceid: '32LIBIS_ALMA_DS',
              recordid: '32LIBIS_ALMA_DS71174288370001471',
              originalsourceid: %w(32KUL_LIBIS_NETWORK 32KUL_KUL),
              sourceformat: 'MARC21',
              sourcesystem: 'Alma',
              almaid: %w(32KUL_LIBIS_NETWORK:71174288370001471 32KUL_KUL:21355561730001488)
          },
          display: {
              type: 'book',
              title: ['The companion to development studies', 'edited by Vandana Desai and Robert B. Potter.'],
              creator: 'Desai, Vandana (1965)  (Editor) ; Potter, Robert B.  (Editor)',
              edition: '3rd ed.',
              publisher: 'London: Routledge, 2014',
              creationdate: '2014',
              format: 'XXII, 603 p. 25 cm',
              identifier: '$$CISBN:$$V9781444167245',
              subject: ['Development', 'Developing countries Social conditions.', 'Economic development.', 'Development economics.', 'Globalization.'],
              # description: 'edited by Vandana Desai and Robert B. Potter.',
              language: 'eng',
              source: 'Catalogue',
              coverage: [
                  'Development in a global-historical context / Ruth Craggs -- The Third World, developing countries, the South, emerging markets and rising powers / Klaus Dodds -- The nature of development studies / Robert B. Potter -- The impasse in development studies / Frans J. Schuurman -- Development and economic growth / A.P. Thirlwall -- Development and social welfare/human rights / Jennifer A. Elliott -- Development as freedom / Patricia Northover -- Race and development / Denise Ferreira da Silva -- Culture and development / Susanne Schech -- Ethics and development / Des Gasper -- New institutional economics and development / Philipp Lepenies -- Measuring development : from GDP to the HDI and wider approaches / Robert B. Potter -- The measurement of poverty / Howard White -- The millennium development goals / Jonathan Rigg -- BRICS and development / José E. Cassiolato -- Theories, strategies and ideologies of development : an overview / Robert B. Potter^^^^',
                  "Smith, Ricardo and the world marketplace, 1776 to 2012 : back to the future and beyond / David Sapsford -- Enlightenment and the era of modernity / Marcus Power -- Dualistic and unilinear concepts of development / Tohy Binns -- Neoliberalism : globalization's neoconservative enforce of austerity / Dennis Conway -- Dependency theories : from ECLA to Andre Gunder Frank and beyond / Dennis Conway and Nikolas Heynen -- The New World Group of dependency scholars : reflections of a Caribbean avant-garde movement / Don D. Marshall -- World-systems theory : core, semiperipheral, and peripheral regions / Thomas Klak -- Indigenous knowledge and development / John Briggs -- Participatory development / Giles Mohan -- Postcolonialism / Cheryl McEwan -- Postmodernism and development / David Simon -- Post-development / James D. Sidaway -- Social capital and development / Anthony Bebbington and Katherine E. Foo -- Globalisation : an overview / Andrew Herod^^^^",
                  'The new international division of labour / Alan Gilbert -- Global shift : industrialization and development / Ray Kiely -- Globalisation/localisation and development / Warwick E. Murray and John Overton -- Trade and industrial policy in developing countries / David Greenaway and Chris Milner -- The knowledge-based economy and digital divisions of labour / Mark Graham -- Corporate social responsibility and development / Dorothea Kleine -- The informal economy in cities of the South / Sylvia Chant -- Child labour / Sally Lloyd-Evans -- Migration and transnationalism / Katie D. Willis -- Diaspora and development / Claire Mercer and Ben Page -- Rural poverty / Edward Heinemann -- Rural livelihoods in a context of new scarcities / Annelies Zoomers -- Food security / Richard Tiffin -- Famine / Stephen Devereux -- Genetically modified crops and development / Matin Qaim -- Rural cooperatives : a new millennium? / Deborah R. Sick, Baburao S. Baviskar and Donald W. Attwood^^^^',
                  'Land reform / Ruth Hall, Saturnino M. Borras Jr. and Ben White -- Gender, agriculture and land rights / Susie Jacobs -- The sustainable intensification of agriculture / Jules Pretty -- Urbanization in low- and middle-income nations in Africa, Asia and Latin America / David Satterthwaite -- Urban bias / Gareth A. Jones and Stuart Corbridge -- Global cities and the production of uneven development / Christof Parnreiter -- Studies in comparative urbanism / Colin McFarlane -- Prosperity or poverty? : Wealth, inequality and deprivation in urban areas / Carole Rakodi -- Housing the urban poor / Alan Gilbert -- Urbanization and environment in low- and middle-income nations / David Satterthwaite -- Transport and urban development / Eduardo Alcantara Vasconcellos -- Cities, crime and development / Paula Meth -- Sustainable development / Michael Redclift -- International regulation and the environment / Giles Atkinson --',
                  "Climate change and development / Emily Boyd -- A changing climate and African development / Chukwumerije Okereke -- Vulnerability and disasters / Terry Cannon -- Ecosystem services and development / Tim Daw -- Natural resource management : a critical appraisal / Jayalaxshmi Mistry -- Water and hydropolitics / Jessica Budds and Alex Loftus -- Energy and development / Subhes C. Bhattacharyya -- Tourism and environment / Matthew Louis Bishop -- Transport and sustainability : developmental pathways / Robin Hickman -- Demographic change and gender / Tiziana Leone and Ernestina Coast -- Women and the state / Kathleen Staudt -- Gender, families and households / Ann Varley -- Feminism and feminist issues in the South : a critique of the \"development\" paradigm / Madhu Purnima Kishwar -- Rethinking gender and empowerment / Jane Parpart -- Gender and globalisation / Harriot Beazley and Vandana Desai^^^^",
                  "Migrant women in the new economy : understanding the gender-migration-care nexus / Kavita Datta -- Women and political representation / Shirin M. Rai -- Sexuality and development / Andrea Cornwall -- Indigenous fertility control / Tulsi Patel -- Nutritional problems, policies and intervention strategies in developing economies / Prakash Shetty -- Motherhood, mortality and health care / Maya Unnithan-Kumar -- The development impacts of HIV/AIDS / Lora Sabin, Marion McNabb, and Mary Bachman DeSilva -- Ageing and poverty / Vandana Desai -- Health disparity : from \"health inequality\" to \"health inequity\" : the move to a moral paradigm in global health disparity / Hazel R. Barrett -- Disability / Ruth Evans -- Social protection in development context / Sarah Cook and Katja Hujo -- Female participation in education / Christopher Colclough -- The challenge of skill formation and training / Jeemol Unni^^^^",
                  "Development education, global citizenship and international volunteering / Matt Baillie Smith -- Gender- and age-based violence / Cathy McIlwaine -- Fragile states / Tom Goodfellow -- Refugees / Richard Black and Ceri Oeppen -- Humanitarian aid / Phil O'Keefe and Joanne Rose -- Global war on terror, development and civil society / Jude Howell -- Peace-building partnerships and human security / Timothy M. Shaw -- Nationalism / Michel Seymour -- Ethnic conflict and the state / Rajesh Venugopal -- Religions and development / Emma Tomalin -- Foreign aid in a changing world / Stephen Brown -- The rising powers as development donors and partners / Emma Mawdsley -- Aid conditionality / Jonathan R.W. Temple -- Aid effectiveness / Jonathan Glennie -- Global governance issues and the current crisis / Isabella Massa and José Brambila-Macias -- Change agents : a history of hope in NGOs, civil society, and the 99% / Alison Van Rooy -- Corruption and development / Susan Rose-Ackerman^^^^",
                  "The role of non-governmental organizations (NGOs) / Vandana Desai -- Non-government public action networks and global policy processes / Barbara Rugendyke -- Multilateral institutions : \"developing countries\" and \"emerging markets\" : stability or change? / Morten Bøås -- Is there a legal right to development? / Radha D'Souza."
              ],
              availlibrary: '$$IKUL$$LKUL_WBIB_LIB$$1WBIB: Openrek-collectie (CBA)$$2(3 304.5 2014 )$$Savailable$$X32KUL_KUL$$YWBIB$$ZWBIB$$P1',
              lds04: [
                  "\"With over 115 concise and authoritative chapters covering a wide range of disciplines the book is divided into ten sections covering the nature of development, the theories and strategies of development, rural development, urbanization, gender, globalization, health and education, the political economy of violence and insecurity, environment and development, governance and development. This new third edition of The Companion to Development Studies is an essential read for students of development studies at all levels - from undergraduate to graduate - and across several disciplines including geography, international relations, politics, economics, sociology and anthropology\"-- Provided by publisher.",
                  "\"The Companion to Development Studies contains over 109 chapters written by leading international experts within the field to provide a concise and authoritative overview of the key theoretical and practical issues dominating contemporary development studies. Covering a wide range of disciplines the book is divided into ten sections, each prefaced by a section introduction written by the editors. The sections cover: the nature of development, theories and strategies of development, globalization and development, rural development, urbanization and development, environment and development, gender, health and education, the political economy of violence and insecurity, and governance and development. This third edition has been extensively updated and contains 45 new contributions from leading authorities, dealing with pressing contemporary issues such as race and development, ethics and development, BRICs and development, global financial crisis, the knowledge based economy and digital divide, food security, GM crops, comparative urbanism, cities and crime, energy, water hydropolitics, climate change, disability, fragile states, global war on terror, ethnic conflict, legal rights to development, ecosystems services for development, just to name a few. Existing chapters have been thoroughly revised to include cutting-edge developments, and to present updated further reading and websites\"-- Provided by publisher."
              ],
              lds10: 'P',
              lds13: '9781444167245',
              lds21: 'WBIBphysical201503',
              lds12: 'KUL,32LIBISNET,KUL',
              availinstitution: '$$IKUL$$Savailable',
              availpnx: 'available'
          },
          links: {
              thumbnail: %w($$Tbeeldendatabank_thumb $$Tamazon_thumb $$Tsyndetics_thumb $$Tgoogle_thumb),
              linktoexcerpt: '$$Tsyndetics_excerpt$$Elinktoexcerpt'
          },
          search: {
              creatorcontrib: [
                  'Desai Vandana',
                  'Desai Vandana 1965',
                  'Desai, V',
                  'Desai, Vandana 1965-',
                  'Vandana Desai',
                  'desaivandana1965',
                  'Potter Robert B',
                  'Potter, R',
                  'Potter, Robert B',
                  'Robert B Potter',
                  'potterrobertb',
                  'edited by Vandana Desai and Robert B. Potter.'
              ],
              title: 'The companion to development studies',
              subject: [
                  'Economic development.',
                  'Development economics.',
                  'Globalization.',
                  '304.5 Development',
                  'Developing countries Social conditions.'
              ],
              fulltext: 'fulltext',
              general: [
                  '(BeLVLBS)9992161785401471',
                  'LBS019992161785401471',
                  '3rd ed.',
                  'London Routledge 2014.',
                  'text txt',
                  'unmediated n',
                  'volume nc',
                  'XXII, 603 p. 25 cm',
                  'Development in a global-historical context / Ruth Craggs -- The Third World, developing countries, the South, emerging markets and rising powers / Klaus Dodds -- The nature of development studies / Robert B. Potter -- The impasse in development studies / Frans J. Schuurman -- Development and economic growth / A.P. Thirlwall -- Development and social welfare/human rights / Jennifer A. Elliott -- Development as freedom / Patricia Northover -- Race and development / Denise Ferreira da Silva -- Culture and development / Susanne Schech -- Ethics and development / Des Gasper -- New institutional economics and development / Philipp Lepenies -- Measuring development : from GDP to the HDI and wider approaches / Robert B. Potter -- The measurement of poverty / Howard White -- The millennium development goals / Jonathan Rigg -- BRICS and development / José E. Cassiolato -- Theories, strategies and ideologies of development : an overview / Robert B. Potter^^^^',
                  "Smith, Ricardo and the world marketplace, 1776 to 2012 : back to the future and beyond / David Sapsford -- Enlightenment and the era of modernity / Marcus Power -- Dualistic and unilinear concepts of development / Tohy Binns -- Neoliberalism : globalization's neoconservative enforce of austerity / Dennis Conway -- Dependency theories : from ECLA to Andre Gunder Frank and beyond / Dennis Conway and Nikolas Heynen -- The New World Group of dependency scholars : reflections of a Caribbean avant-garde movement / Don D. Marshall -- World-systems theory : core, semiperipheral, and peripheral regions / Thomas Klak -- Indigenous knowledge and development / John Briggs -- Participatory development / Giles Mohan -- Postcolonialism / Cheryl McEwan -- Postmodernism and development / David Simon -- Post-development / James D. Sidaway -- Social capital and development / Anthony Bebbington and Katherine E. Foo -- Globalisation : an overview / Andrew Herod^^^^",
                  'The new international division of labour / Alan Gilbert -- Global shift : industrialization and development / Ray Kiely -- Globalisation/localisation and development / Warwick E. Murray and John Overton -- Trade and industrial policy in developing countries / David Greenaway and Chris Milner -- The knowledge-based economy and digital divisions of labour / Mark Graham -- Corporate social responsibility and development / Dorothea Kleine -- The informal economy in cities of the South / Sylvia Chant -- Child labour / Sally Lloyd-Evans -- Migration and transnationalism / Katie D. Willis -- Diaspora and development / Claire Mercer and Ben Page -- Rural poverty / Edward Heinemann -- Rural livelihoods in a context of new scarcities / Annelies Zoomers -- Food security / Richard Tiffin -- Famine / Stephen Devereux -- Genetically modified crops and development / Matin Qaim -- Rural cooperatives : a new millennium? / Deborah R. Sick, Baburao S. Baviskar and Donald W. Attwood^^^^',
                  'Land reform / Ruth Hall, Saturnino M. Borras Jr. and Ben White -- Gender, agriculture and land rights / Susie Jacobs -- The sustainable intensification of agriculture / Jules Pretty -- Urbanization in low- and middle-income nations in Africa, Asia and Latin America / David Satterthwaite -- Urban bias / Gareth A. Jones and Stuart Corbridge -- Global cities and the production of uneven development / Christof Parnreiter -- Studies in comparative urbanism / Colin McFarlane -- Prosperity or poverty? : Wealth, inequality and deprivation in urban areas / Carole Rakodi -- Housing the urban poor / Alan Gilbert -- Urbanization and environment in low- and middle-income nations / David Satterthwaite -- Transport and urban development / Eduardo Alcantara Vasconcellos -- Cities, crime and development / Paula Meth -- Sustainable development / Michael Redclift -- International regulation and the environment / Giles Atkinson --',
                  "Climate change and development / Emily Boyd -- A changing climate and African development / Chukwumerije Okereke -- Vulnerability and disasters / Terry Cannon -- Ecosystem services and development / Tim Daw -- Natural resource management : a critical appraisal / Jayalaxshmi Mistry -- Water and hydropolitics / Jessica Budds and Alex Loftus -- Energy and development / Subhes C. Bhattacharyya -- Tourism and environment / Matthew Louis Bishop -- Transport and sustainability : developmental pathways / Robin Hickman -- Demographic change and gender / Tiziana Leone and Ernestina Coast -- Women and the state / Kathleen Staudt -- Gender, families and households / Ann Varley -- Feminism and feminist issues in the South : a critique of the \"development\" paradigm / Madhu Purnima Kishwar -- Rethinking gender and empowerment / Jane Parpart -- Gender and globalisation / Harriot Beazley and Vandana Desai^^^^",
                  "Migrant women in the new economy : understanding the gender-migration-care nexus / Kavita Datta -- Women and political representation / Shirin M. Rai -- Sexuality and development / Andrea Cornwall -- Indigenous fertility control / Tulsi Patel -- Nutritional problems, policies and intervention strategies in developing economies / Prakash Shetty -- Motherhood, mortality and health care / Maya Unnithan-Kumar -- The development impacts of HIV/AIDS / Lora Sabin, Marion McNabb, and Mary Bachman DeSilva -- Ageing and poverty / Vandana Desai -- Health disparity : from \"health inequality\" to \"health inequity\" : the move to a moral paradigm in global health disparity / Hazel R. Barrett -- Disability / Ruth Evans -- Social protection in development context / Sarah Cook and Katja Hujo -- Female participation in education / Christopher Colclough -- The challenge of skill formation and training / Jeemol Unni^^^^",
                  "Development education, global citizenship and international volunteering / Matt Baillie Smith -- Gender- and age-based violence / Cathy McIlwaine -- Fragile states / Tom Goodfellow -- Refugees / Richard Black and Ceri Oeppen -- Humanitarian aid / Phil O'Keefe and Joanne Rose -- Global war on terror, development and civil society / Jude Howell -- Peace-building partnerships and human security / Timothy M. Shaw -- Nationalism / Michel Seymour -- Ethnic conflict and the state / Rajesh Venugopal -- Religions and development / Emma Tomalin -- Foreign aid in a changing world / Stephen Brown -- The rising powers as development donors and partners / Emma Mawdsley -- Aid conditionality / Jonathan R.W. Temple -- Aid effectiveness / Jonathan Glennie -- Global governance issues and the current crisis / Isabella Massa and José Brambila-Macias -- Change agents : a history of hope in NGOs, civil society, and the 99% / Alison Van Rooy -- Corruption and development / Susan Rose-Ackerman^^^^",
                  "The role of non-governmental organizations (NGOs) / Vandana Desai -- Non-government public action networks and global policy processes / Barbara Rugendyke -- Multilateral institutions : \"developing countries\" and \"emerging markets\" : stability or change? / Morten Bøås -- Is there a legal right to development? / Radha D'Souza.",
                  "\"With over 115 concise and authoritative chapters covering a wide range of disciplines the book is divided into ten sections covering the nature of development, the theories and strategies of development, rural development, urbanization, gender, globalization, health and education, the political economy of violence and insecurity, environment and development, governance and development. This new third edition of The Companion to Development Studies is an essential read for students of development studies at all levels - from undergraduate to graduate - and across several disciplines including geography, international relations, politics, economics, sociology and anthropology\"-- Provided by publisher.",
                  "\"The Companion to Development Studies contains over 109 chapters written by leading international experts within the field to provide a concise and authoritative overview of the key theoretical and practical issues dominating contemporary development studies. Covering a wide range of disciplines the book is divided into ten sections, each prefaced by a section introduction written by the editors. The sections cover: the nature of development, theories and strategies of development, globalization and development, rural development, urbanization and development, environment and development, gender, health and education, the political economy of violence and insecurity, and governance and development. This third edition has been extensively updated and contains 45 new contributions from leading authorities, dealing with pressing contemporary issues such as race and development, ethics and development, BRICs and development, global financial crisis, the knowledge based economy and digital divide, food security, GM crops, comparative urbanism, cities and crime, energy, water hydropolitics, climate change, disability, fragile states, global war on terror, ethnic conflict, legal rights to development, ecosystems services for development, just to name a few. Existing chapters have been thoroughly revised to include cutting-edge developments, and to present updated further reading and websites\"-- Provided by publisher.",
                  'The companion to development studies',
                  'Desai Vandana',
                  'Desai Vandana 1965',
                  'Desai, V',
                  'Desai, Vandana 1965-',
                  'Vandana Desai',
                  'desaivandana1965',
                  'Potter Robert B',
                  'Potter, R',
                  'Potter, Robert B',
                  'Robert B Potter',
                  'potterrobertb',
                  'edited by Vandana Desai and Robert B Potter',
                  '9992161785401471'
              ],
              sourceid: '32LIBIS_ALMA_DS',
              recordid: '32LIBIS_ALMA_DS71174288370001471',
              isbn: [
                  '9781444167245 paperback',
                  '40023930092',
                  '9781444167245'
              ],
              toc: [
                  'Development in a global-historical context / Ruth Craggs -- The Third World, developing countries, the South, emerging markets and rising powers / Klaus Dodds -- The nature of development studies / Robert B. Potter -- The impasse in development studies / Frans J. Schuurman -- Development and economic growth / A.P. Thirlwall -- Development and social welfare/human rights / Jennifer A. Elliott -- Development as freedom / Patricia Northover -- Race and development / Denise Ferreira da Silva -- Culture and development / Susanne Schech -- Ethics and development / Des Gasper -- New institutional economics and development / Philipp Lepenies -- Measuring development : from GDP to the HDI and wider approaches / Robert B. Potter -- The measurement of poverty / Howard White -- The millennium development goals / Jonathan Rigg -- BRICS and development / José E. Cassiolato -- Theories, strategies and ideologies of development : an overview / Robert B. Potter^^^^',
                  "Smith, Ricardo and the world marketplace, 1776 to 2012 : back to the future and beyond / David Sapsford -- Enlightenment and the era of modernity / Marcus Power -- Dualistic and unilinear concepts of development / Tohy Binns -- Neoliberalism : globalization's neoconservative enforce of austerity / Dennis Conway -- Dependency theories : from ECLA to Andre Gunder Frank and beyond / Dennis Conway and Nikolas Heynen -- The New World Group of dependency scholars : reflections of a Caribbean avant-garde movement / Don D. Marshall -- World-systems theory : core, semiperipheral, and peripheral regions / Thomas Klak -- Indigenous knowledge and development / John Briggs -- Participatory development / Giles Mohan -- Postcolonialism / Cheryl McEwan -- Postmodernism and development / David Simon -- Post-development / James D. Sidaway -- Social capital and development / Anthony Bebbington and Katherine E. Foo -- Globalisation : an overview / Andrew Herod^^^^",
                  'The new international division of labour / Alan Gilbert -- Global shift : industrialization and development / Ray Kiely -- Globalisation/localisation and development / Warwick E. Murray and John Overton -- Trade and industrial policy in developing countries / David Greenaway and Chris Milner -- The knowledge-based economy and digital divisions of labour / Mark Graham -- Corporate social responsibility and development / Dorothea Kleine -- The informal economy in cities of the South / Sylvia Chant -- Child labour / Sally Lloyd-Evans -- Migration and transnationalism / Katie D. Willis -- Diaspora and development / Claire Mercer and Ben Page -- Rural poverty / Edward Heinemann -- Rural livelihoods in a context of new scarcities / Annelies Zoomers -- Food security / Richard Tiffin -- Famine / Stephen Devereux -- Genetically modified crops and development / Matin Qaim -- Rural cooperatives : a new millennium? / Deborah R. Sick, Baburao S. Baviskar and Donald W. Attwood^^^^',
                  'Land reform / Ruth Hall, Saturnino M. Borras Jr. and Ben White -- Gender, agriculture and land rights / Susie Jacobs -- The sustainable intensification of agriculture / Jules Pretty -- Urbanization in low- and middle-income nations in Africa, Asia and Latin America / David Satterthwaite -- Urban bias / Gareth A. Jones and Stuart Corbridge -- Global cities and the production of uneven development / Christof Parnreiter -- Studies in comparative urbanism / Colin McFarlane -- Prosperity or poverty? : Wealth, inequality and deprivation in urban areas / Carole Rakodi -- Housing the urban poor / Alan Gilbert -- Urbanization and environment in low- and middle-income nations / David Satterthwaite -- Transport and urban development / Eduardo Alcantara Vasconcellos -- Cities, crime and development / Paula Meth -- Sustainable development / Michael Redclift -- International regulation and the environment / Giles Atkinson --',
                  "Climate change and development / Emily Boyd -- A changing climate and African development / Chukwumerije Okereke -- Vulnerability and disasters / Terry Cannon -- Ecosystem services and development / Tim Daw -- Natural resource management : a critical appraisal / Jayalaxshmi Mistry -- Water and hydropolitics / Jessica Budds and Alex Loftus -- Energy and development / Subhes C. Bhattacharyya -- Tourism and environment / Matthew Louis Bishop -- Transport and sustainability : developmental pathways / Robin Hickman -- Demographic change and gender / Tiziana Leone and Ernestina Coast -- Women and the state / Kathleen Staudt -- Gender, families and households / Ann Varley -- Feminism and feminist issues in the South : a critique of the \"development\" paradigm / Madhu Purnima Kishwar -- Rethinking gender and empowerment / Jane Parpart -- Gender and globalisation / Harriot Beazley and Vandana Desai^^^^",
                  "Migrant women in the new economy : understanding the gender-migration-care nexus / Kavita Datta -- Women and political representation / Shirin M. Rai -- Sexuality and development / Andrea Cornwall -- Indigenous fertility control / Tulsi Patel -- Nutritional problems, policies and intervention strategies in developing economies / Prakash Shetty -- Motherhood, mortality and health care / Maya Unnithan-Kumar -- The development impacts of HIV/AIDS / Lora Sabin, Marion McNabb, and Mary Bachman DeSilva -- Ageing and poverty / Vandana Desai -- Health disparity : from \"health inequality\" to \"health inequity\" : the move to a moral paradigm in global health disparity / Hazel R. Barrett -- Disability / Ruth Evans -- Social protection in development context / Sarah Cook and Katja Hujo -- Female participation in education / Christopher Colclough -- The challenge of skill formation and training / Jeemol Unni^^^^",
                  "Development education, global citizenship and international volunteering / Matt Baillie Smith -- Gender- and age-based violence / Cathy McIlwaine -- Fragile states / Tom Goodfellow -- Refugees / Richard Black and Ceri Oeppen -- Humanitarian aid / Phil O'Keefe and Joanne Rose -- Global war on terror, development and civil society / Jude Howell -- Peace-building partnerships and human security / Timothy M. Shaw -- Nationalism / Michel Seymour -- Ethnic conflict and the state / Rajesh Venugopal -- Religions and development / Emma Tomalin -- Foreign aid in a changing world / Stephen Brown -- The rising powers as development donors and partners / Emma Mawdsley -- Aid conditionality / Jonathan R.W. Temple -- Aid effectiveness / Jonathan Glennie -- Global governance issues and the current crisis / Isabella Massa and José Brambila-Macias -- Change agents : a history of hope in NGOs, civil society, and the 99% / Alison Van Rooy -- Corruption and development / Susan Rose-Ackerman^^^^",
                  "The role of non-governmental organizations (NGOs) / Vandana Desai -- Non-government public action networks and global policy processes / Barbara Rugendyke -- Multilateral institutions : \"developing countries\" and \"emerging markets\" : stability or change? / Morten Bøås -- Is there a legal right to development? / Radha D'Souza."
              ],
              rsrctype: 'book',
              creationdate: '2014',
              startdate: '20140101',
              enddate: '20141231',
              addsrcrecordid: %w(9992161785401471 9992121337301488),
              searchscope: %w(32LIBIS_ALMA_DS 32LIBIS_ALMA_DS_P KUL KUL_WBIB_LIB KUL_P 32LIBISNET 32LIBISNET_P),
              scope: %w(32LIBIS_ALMA_DS 32LIBIS_ALMA_DS_P KUL KUL_WBIB_LIB KUL_P 32LIBISNET 32LIBISNET_P),
              lsr04: %w(AcquisitionDate201503WBIBphysical CollectionWBIBWBIB Callnumber330452014 AcquisitionTagcluster3WBIBphysical),
              lsr35: '9992161785401471'
          },
          sort: {
              title: 'The companion to development studies',
              creationdate: '20140101',
              author: 'Desai, Vandana (1965) (Editor) ; Potter, Robert B. (Editor)',
              lso01: 'The companion to development studies',
              lso02: '20140101'
          },
          facets: {
              language: 'eng',
              creationdate: '2014',
              topic: [
                  'Economic development.',
                  'Development economics.',
                  'Globalization.',
                  'Development',
                  'Developing countries Social conditions.'
              ],
              collection: 'LIBISnet Catalogue',
              toplevel: 'print_copies',
              prefilter: 'books',
              rsrctype: 'books',
              creatorcontrib: [
                  'Desai, V',
                  'Potter, R'
              ],
              library: 'KUL_WBIB_LIB',
              atoz: 'T'
          },
          dedup: {
              t: '1',
              c2: '9781444167245P',
              c3: 'companiontodevelopmentstudiesengbookALMAAlma-P',
              c4: '2014',
              f3: '9781444167245',
              f5: 'companiontodevelopmentstudiesALMA-P',
              f6: '2014',
              f7: 'companion to development studiesALMA',
              f9: 'xxk',
              f13: '3rd ed.',
              f20: '9992161785401471'
          },
          frbr: {
              t: '1',
              k1: '$$KDESAIVANDANAPOTTERROBERTB$$AA',
              k3: '$$Kthe companion to development studies$$AT'
          },
          delivery: {
              institution: %w(KUL 32LIBISNET),
              delcategory: %w(Alma-P$$I32LIBISNET Alma-P$$IKUL)
          },
          ranking: {
              booster1: '1',
              booster2: '1'
          },
          addata: {
              aulast: 'Desai',
              aufirst: 'Vandana',
              addau: [
                  'Desai, Vandana',
                  'Potter, Robert B'
              ],
              btitle: [
                  'The companion to development studies',
                  'edited by Vandana Desai and Robert B. Potter.'
              ],
              date: '2014',
              risdate: '2014',
              isbn: '9781444167245',
              format: 'book',
              genre: 'book',
              ristype: 'BOOK',
              notes: 'Includes bibliographical references and index.',
              abstract: [
                  "\"With over 115 concise and authoritative chapters covering a wide range of disciplines the book is divided into ten sections covering the nature of development, the theories and strategies of development, rural development, urbanization, gender, globalization, health and education, the political economy of violence and insecurity, environment and development, governance and development. This new third edition of The Companion to Development Studies is an essential read for students of development studies at all levels - from undergraduate to graduate - and across several disciplines including geography, international relations, politics, economics, sociology and anthropology\"--",
                  "\"The Companion to Development Studies contains over 109 chapters written by leading international experts within the field to provide a concise and authoritative overview of the key theoretical and practical issues dominating contemporary development studies. Covering a wide range of disciplines the book is divided into ten sections, each prefaced by a section introduction written by the editors. The sections cover: the nature of development, theories and strategies of development, globalization and development, rural development, urbanization and development, environment and development, gender, health and education, the political economy of violence and insecurity, and governance and development. This third edition has been extensively updated and contains 45 new contributions from leading authorities, dealing with pressing contemporary issues such as race and development, ethics and development, BRICs and development, global financial crisis, the knowledge based economy and digital divide, food security, GM crops, comparative urbanism, cities and crime, energy, water hydropolitics, climate change, disability, fragile states, global war on terror, ethnic conflict, legal rights to development, ecosystems services for development, just to name a few. Existing chapters have been thoroughly revised to include cutting-edge developments, and to present updated further reading and websites\"--"
              ]
          },
          browse: {
              author: '$$DDesai, Vandana (1965) (Editor) ; Potter, Robert B. (Editor)$$EDesai, Vandana (1965) (Editor) ; Potter, Robert B. (Editor)',
              title: [
                  '$$DThe companion to development studies',
                  '$$Dedited by Vandana Desai and Robert B. Potter.$$EThe companion to development studies$$Eedited by Vandana Desai and Robert B. Potter.'
              ],
              subject: [
                  '$$DDevelopment$$EDevelopment',
                  '$$DDeveloping countries Social conditions.$$EDeveloping countries Social conditions.',
                  '$$DEconomic development.$$EEconomic development.',
                  '$$DDevelopment economics.$$EDevelopment economics.',
                  '$$DGlobalization.$$EGlobalization.'
              ],
              institution: %w(KUL 32LIBISNET)
          }

      }
    }

    it 'get record' do
      result = subject.get_pnx('32LIBIS_ALMA_DS71174288370001471')
      if result.is_a?(Libis::Tools::XmlDocument)
        result = result.to_hash(:convert_tags_to => lambda { |tag| tag.snakecase.to_sym })
        check_container(record, result[:record])
      end
    end

  end

end
