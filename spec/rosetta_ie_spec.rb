# encoding: utf-8
require_relative 'spec_helper'
require 'yaml'
require 'awesome_print'
require 'pp'

require 'libis/tools/config_file'
require 'libis/services/rosetta/pds_handler'
require 'libis/services/rosetta/ie_handler'

describe 'Rosetta IE Service' do

  let(:credentials) { Libis::Tools::ConfigFile.new File.join(File.dirname(__FILE__), 'credentials-test.yml') }
  let(:pds_handler) do
    # noinspection RubyResolve
    Libis::Services::Rosetta::PdsHandler.new(credentials.pds_url)
  end

  let(:handle) do
    # noinspection RubyResolve
    pds_handler.login(
        credentials.admin.user,
        credentials.admin.password,
        credentials.admin.institute
    )
  end

  subject(:ie_handler) do
    # noinspection RubyResolve
    Libis::Services::Rosetta::IeHandler.new credentials.rosetta_url,
                                            log: credentials.debug,
                                            log_level: credentials.debug_level
  end

  before :each do
    ie_handler.pds_handle = handle
  end

  let(:expected_mets) {
    {
        amd: {
            tech: {
                'internalIdentifier' => [
                    {'internalIdentifierType' => 'SIPID', 'internalIdentifierValue' => '55010'},
                    {'internalIdentifierType' => 'PID', 'internalIdentifierValue' => 'IE403595'},
                    {'internalIdentifierType' => 'DepositSetID', 'internalIdentifierValue' => '55662'}],
                'objectCharacteristics' => [
                    {'objectType' => 'INTELLECTUAL_ENTITY',
                     'creationDate' => '2015-10-13 14:41:56',
                     'createdBy' => 'testadmin',
                     'modificationDate' => '2015-10-13 14:46:23',
                     'modifiedBy' => 'testadmin',
                     'owner' => 'CRS00.TESTINS.TESTDEP'}],
                'generalIECharacteristics' => [{'status' => 'ACTIVE'}],
                'retentionPolicy' => [
                    {'policyId' => 'NO_RETENTION',
                     'policyDescription' => 'No Retention Policy'}]
            },
            rights: {
                'accessRightsPolicy' => [
                    {'policyId' => '50740',
                     'policyParameters' => '',
                     'policyDescription' => 'AR_IP_RANGE_KUL'}]
            },
            source: {
                'metaData' => [
                    {'MID' => 'DNX_IE403595',
                     'UUID' => '23107258',
                     'creationDate' => '2015-10-13 14:41:56',
                     'createdBy' => 'testadmin',
                     'modificationDate' => '2015-10-13 14:46:23',
                     'modifiedBy' => 'testadmin',
                     'metadataType' => '21',
                     'description' => '',
                     'externalSystem' => '',
                     'externalRecordId' => '',
                     'application' => 'Test Metadata Profile'}]
            },
            digiprov: {
                'producer' => [
                    {'userName' => '',
                     'address1' => 'Willem de Croylaan 54',
                     'address2' => '',
                     'address3' => 'Heverlee',
                     'address4' => 'Belgium',
                     'address5' => '',
                     'defaultLanguage' => 'en',
                     'emailAddress' => 'lias.test.user@gmail.com',
                     'firstName' => 'Test',
                     'jobTitle' => '',
                     'lastName' => 'Deposit',
                     'middleName' => '',
                     'telephone1' => '0032 16 32 22 66',
                     'telephone2' => '',
                     'authorativeName' => 'test_producer_group',
                     'producerId' => '23106349',
                     'userIdAppId' => '23106348',
                     'webSiteUrl' => '',
                     'zip' => '3001'}],
                'producerAgent' => [
                    {'firstName' => 'Test', 'lastName' => 'Administrator', 'middleName' => ''}],
                'event' => [
                    {'eventDateTime' => '2015-10-13 14:46:23',
                     'eventType' => 'PROCESSING',
                     'eventIdentifierType' => 'DPS',
                     'eventIdentifierValue' => '130',
                     'eventOutcome1' => 'SUCCESS',
                     'eventDescription' => "Object's Metadata Record Modified",
                     'linkingAgentIdentifierType1' => 'USER',
                     'linkingAgentIdentifierValue1' => 'testadmin'}]
            }
        },
        dmd: {
            'text' => "\n        ",
            'title' => 'Nachtzicht strand Ærøskøbing'
        },
        'Preservation Master' => {
            id: 'REP403596',
            amd: {
                tech: {
                    'generalRepCharacteristics' => [
                        {'preservationType' => 'PRESERVATION_MASTER',
                         'usageType' => 'VIEW',
                         'RevisionNumber' => '1',
                         'DigitalOriginal' => 'false'}],
                    'internalIdentifier' => [
                        {'internalIdentifierType' => 'SIPID', 'internalIdentifierValue' => '55010'},
                        {'internalIdentifierType' => 'PID', 'internalIdentifierValue' => 'REP403596'},
                        {'internalIdentifierType' => 'DepositSetID', 'internalIdentifierValue' => '55662'}],
                    'objectCharacteristics' => [
                        {'objectType' => 'REPRESENTATION',
                         'creationDate' => '2015-10-13 14:41:56',
                         'createdBy' => 'testadmin',
                         'modificationDate' => '2015-10-13 14:41:56',
                         'modifiedBy' => 'testadmin',
                         'owner' => 'CRS00.TESTINS.TESTDEP'}]
                },
                rights: {},
                source: {'metaData' =>
                             [
                                 {'MID' => 'DNX_REP403596',
                                  'UUID' => '23107254',
                                  'creationDate' => '2015-10-13 14:41:56',
                                  'createdBy' => 'testadmin',
                                  'modificationDate' => '2015-10-13 14:41:56',
                                  'modifiedBy' => '',
                                  'metadataType' => '21',
                                  'description' => '',
                                  'externalSystem' => '',
                                  'externalRecordId' => ''},
                                 {'MID' => 'REP403596-1',
                                  'UUID' => '23107257',
                                  'creationDate' => '2015-10-13 14:41:56',
                                  'createdBy' => 'testadmin',
                                  'modificationDate' => '2015-10-13 14:41:56',
                                  'modifiedBy' => '',
                                  'metadataType' => '32',
                                  'description' => '',
                                  'externalSystem' => '',
                                  'externalRecordId' => ''} ]
                },
                digiprov: {}
            },
            nil => {},
            'Table of Contents' =>
                {nil => {},
                 'Nachtzicht strand Ærøskøbing' => {
                     id: 'FL403597',
                     amd: {
                         tech: {
                             'fileFixity' => [
                                 {'fixityType' => 'MD5',
                                  'fixityValue' => '22d8897eeb3adfa70794fcfac04e8602'}],
                             'objectCharacteristics' => [
                                 {'groupID' => '',
                                  'objectType' => 'FILE',
                                  'creationDate' => '2015-10-13 14:41:56',
                                  'createdBy' => 'testadmin',
                                  'modificationDate' => '2015-10-13 14:41:56',
                                  'modifiedBy' => 'testadmin',
                                  'owner' => 'CRS00.TESTINS.TESTDEP'}],
                             'internalIdentifier' => [
                                 {'internalIdentifierType' => 'SIPID',
                                  'internalIdentifierValue' => '55010'},
                                 {'internalIdentifierType' => 'PID',
                                  'internalIdentifierValue' => 'FL403597'},
                                 {'internalIdentifierType' => 'DepositSetID',
                                  'internalIdentifierValue' => '55662'}],
                             'vsOutcome' => [
                                 {'checkDate' => 'Tue Oct 13 14:42:02 CEST 2015',
                                  'type' => 'FILE_FORMAT',
                                  'vsAgent' =>
                                      'REG_SA_DROID , Version 6.01 , Signature version Binary SF v.52/ Container SF v.1',
                                  'result' => 'PASSED',
                                  'resultDetails' => '',
                                  'vsEvaluation' => 'PASSED',
                                  'vsEvaluationDetails' => ''}],
                             'fileFormat' => [
                                 {'agent' => 'REG_SA_DROID',
                                  'formatRegistry' => 'PRONOM',
                                  'formatRegistryId' => 'fmt/43',
                                  'formatRegistryRole' => '',
                                  'formatName' => 'fmt/43',
                                  'formatVersion' => '1.01',
                                  'formatDescription' => 'JPEG File Interchange Format',
                                  'formatNote' => '',
                                  'exactFormatIdentification' => 'true',
                                  'mimeType' => 'image/jpeg',
                                  'agentVersion' => '6.01',
                                  'agentSignatureVersion' => 'Binary SF v.52/ Container SF v.1',
                                  'formatLibraryVersion' => '3.007'}],
                             'generalFileCharacteristics' => [
                                 {'label' => 'Nachtzicht strand Ærøskøbing',
                                  'note' => '',
                                  'fileCreationDate' => '',
                                  'fileModificationDate' => '',
                                  'FileEntityType' => '',
                                  'compositionLevel' => '',
                                  'fileLocationType' => 'FILE',
                                  'fileLocation' => '',
                                  'fileOriginalName' => 'DSC03176.jpg',
                                  'fileOriginalPath' => 'DSC03176.jpg',
                                  'fileOriginalID' => '/deposit_storage/55001-56000/dep_55662/deposit/content/streams/DSC03176.jpg',
                                  'fileExtension' => 'jpg',
                                  'fileMIMEType' => 'image/jpeg',
                                  'fileSizeBytes' => '7694075',
                                  'formatLibraryId' => 'fmt/43',
                                  'riskLibraryIdentifiers' => ''}]
                         },
                         rights: {},
                         source: {
                             'metaData' => [
                                 {'MID' => 'DNX_FL403597',
                                  'UUID' => '23107256',
                                  'creationDate' => '2015-10-13 14:41:56',
                                  'createdBy' => 'testadmin',
                                  'modificationDate' => '2015-10-13 14:41:56',
                                  'modifiedBy' => '',
                                  'metadataType' => '21',
                                  'description' => '',
                                  'externalSystem' => '',
                                  'externalRecordId' => ''}]
                         },
                         digiprov: {
                             'event' => [
                                 {'eventDateTime' => '2015-10-13 14:42:01',
                                  'eventType' => 'VALIDATION',
                                  'eventIdentifierType' => 'DPS',
                                  'eventIdentifierValue' => '25',
                                  'eventOutcome1' => 'SUCCESS',
                                  'eventOutcomeDetail1' => 'PROCESS_ID=;PID=FL403597;FILE_EXTENSION=jpg;SIP_ID=55010;DEPOSIT_ACTIVITY_ID=55662;MF_ID=23106594;TASK_ID=48;IDENTIFICATION_METHOD=SIGNATURE;PRODUCER_ID=23106349;FORMAT_ID=fmt/43;',
                                  'eventDescription' => 'Format Identification performed on file',
                                  'linkingAgentIdentifierType1' => 'SOFTWARE',
                                  'linkingAgentIdentifierValue1' => 'REG_SA_DROID , Version 6.01 , Signature version Binary SF v.52/ Container SF v.1'}]
                         }
                     }
                 }
                }
        }
    }
  }

  let(:expected_ies) {
    {amd: {
        tech: {'internalIdentifier' =>
                   [{'internalIdentifierType' => 'SIPID', 'internalIdentifierValue' => '55010'},
                    {'internalIdentifierType' => 'PID',
                     'internalIdentifierValue' => 'IE403595'},
                    {'internalIdentifierType' => 'DepositSetID',
                     'internalIdentifierValue' => '55662'}],
               'objectCharacteristics' =>
                   [{'objectType' => 'INTELLECTUAL_ENTITY',
                     'creationDate' => '2015-10-13 14:41:56',
                     'createdBy' => 'testadmin',
                     'modificationDate' => '2015-10-13 14:46:23',
                     'modifiedBy' => 'testadmin',
                     'owner' => 'CRS00.TESTINS.TESTDEP'}],
               'generalIECharacteristics' => [{'status' => 'ACTIVE'}],
               'retentionPolicy' =>
                   [{'policyId' => 'NO_RETENTION',
                     'policyDescription' => 'No Retention Policy'}]},
        rights: {'accessRightsPolicy' =>
                     [{'policyId' => '50740',
                       'policyParameters' => '',
                       'policyDescription' => 'AR_IP_RANGE_KUL'}]},
        source: {'metaData' =>
                     [{'MID' => 'DNX_IE403595',
                       'UUID' => '23107258',
                       'creationDate' => '2015-10-13 14:41:56',
                       'createdBy' => 'testadmin',
                       'modificationDate' => '2015-10-13 14:46:23',
                       'modifiedBy' => 'testadmin',
                       'metadataType' => '21',
                       'description' => '',
                       'externalSystem' => '',
                       'externalRecordId' => '',
                       'application' => 'Test Metadata Profile'}]},
        digiprov: {'producer' =>
                       [{'userName' => '',
                         'address1' => 'Willem de Croylaan 54',
                         'address2' => '',
                         'address3' => 'Heverlee',
                         'address4' => 'Belgium',
                         'address5' => '',
                         'defaultLanguage' => 'en',
                         'emailAddress' => 'lias.test.user@gmail.com',
                         'firstName' => 'Test',
                         'jobTitle' => '',
                         'lastName' => 'Deposit',
                         'middleName' => '',
                         'telephone1' => '0032 16 32 22 66',
                         'telephone2' => '',
                         'authorativeName' => 'test_producer_group',
                         'producerId' => '23106349',
                         'userIdAppId' => '23106348',
                         'webSiteUrl' => '',
                         'zip' => '3001'}],
                   'producerAgent' =>
                       [{'firstName' => 'Test', 'lastName' => 'Administrator', 'middleName' => ''}],
                   'event' =>
                       [{'eventDateTime' => '2015-10-13 14:46:23',
                         'eventType' => 'PROCESSING',
                         'eventIdentifierType' => 'DPS',
                         'eventIdentifierValue' => '130',
                         'eventOutcome1' => 'SUCCESS',
                         'eventDescription' => "Object's Metadata Record Modified",
                         'linkingAgentIdentifierType1' => 'USER',
                         'linkingAgentIdentifierValue1' => 'testadmin'}]}},
     dmd: {'text' => "\n        ", 'title' => 'Nachtzicht strand Ærøskøbing'}} }

  it 'should get IE info' do

    mets = ie_handler.get_mets('IE403595')
    expect(mets).not_to be_nil
    expect(mets).to match expected_mets
  end

  it 'should get IE metadata' do

    metadata = ie_handler.get_metadata('IE403595')
    expect(metadata).not_to be_nil
    expect(metadata).to match expected_ies
  end

end