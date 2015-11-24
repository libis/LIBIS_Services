# noinspection RubyQuotedStringsInspection
def expected_ies
  {
      :amd => {
          :tech => {
              "internalIdentifier" => [
                  {"internalIdentifierType" => "SIPID", "internalIdentifierValue" => "55010"},
                  {"internalIdentifierType" => "PID",
                   "internalIdentifierValue" => "IE403595"},
                  {"internalIdentifierType" => "DepositSetID",
                   "internalIdentifierValue" => "55662"}
              ],
              "objectCharacteristics" => [
                  {
                      "objectType" => "INTELLECTUAL_ENTITY",
                      "creationDate" => "2015-10-13 14:41:56",
                      "createdBy" => "testadmin",
                      "modificationDate" => "2015-11-18 16:22:13",
                      "modifiedBy" => "testadmin",
                      "owner" => "CRS00.TESTINS.TESTDEP",
                      "groupID" => "ABC123"
                  }
              ],
              "generalIECharacteristics" => [
                  {
                      "status" => "ACTIVE",
                      "submissionReason" => "Ingest",
                      "IEEntityType" => "KADOC_PhotoAlbum",
                      "Version" => "100200300",
                      "UserDefinedA" => "AAAA",
                      "UserDefinedB" => "BBBB",
                      "UserDefinedC" => "CCCC"
                  }
              ],
              "retentionPolicy" => [
                  {
                      "policyId" => "NO_RETENTION",
                      "policyDescription" => "No Retention Policy"
                  }
              ],
              "webHarvesting" => [
                  {
                      "primarySeedURL" =>
                          "http://images.freeimages.com/images/previews/a9b/books-1419613.jpg",
                      "WCTIdentifier" => "0000",
                      "targetName" => "books-1419613.jpg",
                      "group" => "library/books",
                      "harvestDate" => "30/10/2015",
                      "harvestTime" => "15:30"
                  }
              ],
              "Collection" => [
                  {
                      "collectionId" => "23082442",
                      "collectionParentId" => "",
                      "name" => "",
                      "externalId" => "9999",
                      "externalSystem" => "CollectiveAccess",
                      "publish" => "",
                      "navigate" => ""
                  }
              ]
          },
          :rights => {
              "accessRightsPolicy" => [
                  {
                      "policyId" => "50740",
                      "policyParameters" => "",
                      "policyDescription" => "AR_IP_RANGE_KUL"
                  }
              ]
          }
      },
      :dmd => {
          "text" => "\n        ",
          "title" => "Denemarken 2015"
      },
  }
end

def expected_mets
  # noinspection RubyQuotedStringsInspection
  expected_ies.merge(
      "Large" => {
          :id => "REP403621",
          :amd => {
              :tech => {
                  "objectCharacteristics" => [
                      {
                          "objectType" => "REPRESENTATION",
                          "creationDate" => "2015-10-31 11:23:13",
                          "createdBy" => "testadmin",
                          "modificationDate" => "2015-10-31 11:43:10",
                          "modifiedBy" => "testadmin",
                          "owner" => "CRS00.TESTINS.TESTDEP"
                      }
                  ],
                  "generalRepCharacteristics" => [
                      {
                          "usageType" => "VIEW",
                          "preservationType" => "DERIVATIVE_COPY",
                          "label" => "Large",
                          "RepresentationCode" => "HIGH"
                      }
                  ],
                  "internalIdentifier" => [
                      {
                          "internalIdentifierType" => "PID",
                          "internalIdentifierValue" => "REP403621"
                      }
                  ]
              },
              :rights => {
                  "accessRightsPolicy" => [
                      {"policyId" => "50740"}
                  ]
              }
          },
          "Table of Contents" => {
              "Zonsondergang Sinebjerg" => {
                  :id => "FL403622",
                  :group => "DSC03102",
                  :amd => {
                      :tech => {
                          "objectCharacteristics" => [
                              {
                                  "objectType" => "FILE",
                                  "creationDate" => "2015-10-31 11:23:13",
                                  "createdBy" => "testadmin",
                                  "modificationDate" => "2015-10-31 11:43:10",
                                  "modifiedBy" => "testadmin",
                                  "owner" => "CRS00.TESTINS.TESTDEP",
                                  "groupID" => "DSC03102"
                              }
                          ],
                          "internalIdentifier" => [
                              {
                                  "internalIdentifierType" => "PID",
                                  "internalIdentifierValue" => "FL403622"
                              }
                          ],
                          "generalFileCharacteristics" => [
                              {
                                  "label" => "Zonsondergang Sinebjerg",
                                  "note" => "",
                                  "fileCreationDate" => "",
                                  "fileModificationDate" => "",
                                  "FileEntityType" => "",
                                  "compositionLevel" => "",
                                  "fileLocationType" => "FILE",
                                  "fileLocation" => "",
                                  "fileOriginalName" => "DSC03102.jpg",
                                  "fileOriginalPath" => "",
                                  "fileOriginalID" =>
                                      "/operational_shared/operational_export_directory/IE403595/import/23230104//DSC03102.jpg",
                                  "fileExtension" => "jpg",
                                  "fileMIMEType" => "image/jpeg",
                                  "fileSizeBytes" => "216073",
                                  "formatLibraryId" => "fmt/44",
                                  "riskLibraryIdentifiers" => ""
                              }
                          ]
                      },
                  }
              },
              "Strand Ristinge" => {
                  :id => "FL403623",
                  :amd => {
                      :tech => {
                          "objectCharacteristics" => [
                              {
                                  "objectType" => "FILE",
                                  "creationDate" => "2015-10-31 11:23:13",
                                  "createdBy" => "testadmin",
                                  "modificationDate" => "2015-10-31 11:23:13",
                                  "modifiedBy" => "testadmin",
                                  "owner" => "CRS00.TESTINS.TESTDEP"
                              }
                          ],
                          "internalIdentifier" => [
                              {
                                  "internalIdentifierType" => "PID",
                                  "internalIdentifierValue" => "FL403623"
                              }
                          ],

                      },
                  }
              },
              "Nachtzicht strand Ærøskøbing" => {
                  :id => "FL403624",
                  :amd => {
                      :tech => {
                          "objectCharacteristics" => [
                              {
                                  "objectType" => "FILE",
                                  "creationDate" => "2015-10-31 11:23:13",
                                  "createdBy" => "testadmin",
                                  "modificationDate" => "2015-10-31 11:23:13",
                                  "modifiedBy" => "testadmin",
                                  "owner" => "CRS00.TESTINS.TESTDEP"
                              }
                          ],
                          "internalIdentifier" => [
                              {
                                  "internalIdentifierType" => "PID",
                                  "internalIdentifierValue" => "FL403624"
                              }
                          ],
                      }
                  }
              },
              "Strandvej schiereiland Ærøskøbing" => {
                  :id => "FL403625",
                  :amd => {
                      :tech => {
                          "objectCharacteristics" => [
                              {
                                  "objectType" => "FILE",
                                  "creationDate" => "2015-10-31 11:23:13",
                                  "createdBy" => "testadmin",
                                  "modificationDate" => "2015-10-31 11:23:13",
                                  "modifiedBy" => "testadmin",
                                  "owner" => "CRS00.TESTINS.TESTDEP"
                              }
                          ],
                          "internalIdentifier" => [
                              {
                                  "internalIdentifierType" => "PID",
                                  "internalIdentifierValue" => "FL403625"
                              }
                          ]
                      },
                  }
              },
              "Skjoldnæs Fyr - Søby" =>
                  {:id => "FL403626",
                   :amd =>
                       {:tech =>
                            {"objectCharacteristics" =>
                                 [{"objectType" => "FILE",
                                   "creationDate" => "2015-10-31 11:23:13",
                                   "createdBy" => "testadmin",
                                   "modificationDate" => "2015-10-31 11:23:13",
                                   "modifiedBy" => "testadmin",
                                   "owner" => "CRS00.TESTINS.TESTDEP"}],
                             "internalIdentifier" =>
                                 [{"internalIdentifierType" => "PID",
                                   "internalIdentifierValue" => "FL403626"}],
                            }
                       }},
              "Ingang Legoland Billund" => {
                  :id => "FL403627",
                  :amd => {
                      :tech => {
                          "objectCharacteristics" => [
                              {
                                  "objectType" => "FILE",
                                  "creationDate" => "2015-10-31 11:23:13",
                                  "createdBy" => "testadmin",
                                  "modificationDate" => "2015-10-31 11:23:13",
                                  "modifiedBy" => "testadmin",
                                  "owner" => "CRS00.TESTINS.TESTDEP"
                              }
                          ],
                          "internalIdentifier" => [
                              {
                                  "internalIdentifierType" => "PID",
                                  "internalIdentifierValue" => "FL403627"
                              }
                          ]
                      }
                  }
              }
          }
      },
      "Small" => {
          :id => "REP403628",
          :amd => {
              :tech => {
                  "objectCharacteristics" => [
                      {
                          "objectType" => "REPRESENTATION",
                          "creationDate" => "2015-10-31 11:24:55",
                          "createdBy" => "testadmin",
                          "modificationDate" => "2015-10-31 11:43:10",
                          "modifiedBy" => "testadmin",
                          "owner" => "CRS00.TESTINS.TESTDEP"
                      }
                  ],
                  "generalRepCharacteristics" => [
                      {
                          "usageType" => "VIEW",
                          "preservationType" => "DERIVATIVE_COPY",
                          "label" => "Small",
                          "RepresentationCode" => "LOW"
                      }
                  ],
                  "internalIdentifier" => [
                      {
                          "internalIdentifierType" => "PID",
                          "internalIdentifierValue" => "REP403628"
                      }
                  ]
              },
              :rights => {
                  "accessRightsPolicy" => [
                      {"policyId" => "AR_EVERYONE"}
                  ]
              },
          },
          "Table of Contents" => {
              "Zonsondergang Sinebjerg" => {
                  :id => "FL403629",
                  :group => "DSC03102",
                  :amd => {
                      :tech => {
                          "objectCharacteristics" => [
                              {
                                  "objectType" => "FILE",
                                  "creationDate" => "2015-10-31 11:24:55",
                                  "createdBy" => "testadmin",
                                  "modificationDate" => "2015-10-31 11:43:10",
                                  "modifiedBy" => "testadmin",
                                  "owner" => "CRS00.TESTINS.TESTDEP",
                                  "groupID" => "DSC03102"
                              }
                          ],
                          "internalIdentifier" => [
                              {
                                  "internalIdentifierType" => "PID",
                                  "internalIdentifierValue" => "FL403629"
                              }
                          ],
                      }
                  }
              },
              "Strand Ristinge" => {
                  :id => "FL403630",
                  :amd => {
                      :tech => {
                          "objectCharacteristics" => [
                              {
                                  "objectType" => "FILE",
                                  "creationDate" => "2015-10-31 11:24:55",
                                  "createdBy" => "testadmin",
                                  "modificationDate" => "2015-10-31 11:24:55",
                                  "modifiedBy" => "testadmin",
                                  "owner" => "CRS00.TESTINS.TESTDEP"
                              }
                          ],
                          "internalIdentifier" => [
                              {
                                  "internalIdentifierType" => "PID",
                                  "internalIdentifierValue" => "FL403630"
                              }
                          ],
                      }
                  }
              },
              "Nachtzicht strand Ærøskøbing" => {
                  :id => "FL403631",
                  :amd => {
                      :tech => {
                          "objectCharacteristics" => [
                              {
                                  "objectType" => "FILE",
                                  "creationDate" => "2015-10-31 11:24:55",
                                  "createdBy" => "testadmin",
                                  "modificationDate" => "2015-10-31 11:24:55",
                                  "modifiedBy" => "testadmin",
                                  "owner" => "CRS00.TESTINS.TESTDEP"
                              }
                          ],
                          "internalIdentifier" => [
                              {
                                  "internalIdentifierType" => "PID",
                                  "internalIdentifierValue" => "FL403631"
                              }
                          ],
                      }
                  }
              },
              "Strandvej schiereiland Ærøskøbing" => {
                  :id => "FL403632",
                  :amd => {
                      :tech => {
                          "objectCharacteristics" => [
                              {
                                  "objectType" => "FILE",
                                  "creationDate" => "2015-10-31 11:24:55",
                                  "createdBy" => "testadmin",
                                  "modificationDate" => "2015-10-31 11:24:55",
                                  "modifiedBy" => "testadmin",
                                  "owner" => "CRS00.TESTINS.TESTDEP"
                              }
                          ],
                          "internalIdentifier" => [
                              {
                                  "internalIdentifierType" => "PID",
                                  "internalIdentifierValue" => "FL403632"
                              }
                          ],
                      }
                  }
              },
              "Skjoldnæs Fyr - Søby" => {
                  :id => "FL403633",
                  :amd => {
                      :tech => {
                          "objectCharacteristics" => [
                              {
                                  "objectType" => "FILE",
                                  "creationDate" => "2015-10-31 11:24:55",
                                  "createdBy" => "testadmin",
                                  "modificationDate" => "2015-10-31 11:24:55",
                                  "modifiedBy" => "testadmin",
                                  "owner" => "CRS00.TESTINS.TESTDEP"
                              }
                          ],
                          "internalIdentifier" => [
                              {
                                  "internalIdentifierType" => "PID",
                                  "internalIdentifierValue" => "FL403633"
                              }
                          ],
                      }
                  }
              },
              "Ingang Legoland Billund" => {
                  :id => "FL403634",
                  :amd => {
                      :tech => {
                          "objectCharacteristics" => [
                              {
                                  "objectType" => "FILE",
                                  "creationDate" => "2015-10-31 11:24:55",
                                  "createdBy" => "testadmin",
                                  "modificationDate" => "2015-10-31 11:24:55",
                                  "modifiedBy" => "testadmin",
                                  "owner" => "CRS00.TESTINS.TESTDEP"
                              }
                          ],
                          "internalIdentifier" => [
                              {
                                  "internalIdentifierType" => "PID",
                                  "internalIdentifierValue" => "FL403634"
                              }
                          ],
                      }
                  }
              }
          }
      },
      "Preservation Master" => {
          :id => "REP403596",
          :amd => {
              :tech => {
                  "generalRepCharacteristics" => [
                      {
                          "preservationType" => "PRESERVATION_MASTER",
                          "usageType" => "VIEW",
                          "RevisionNumber" => "1",
                          "DigitalOriginal" => "true",
                          "label" => "Original",
                          "representationEntityType" => "JPEG Images",
                          "contentType" => "fotoalbum",
                          "contextType" => "holidays",
                          "hardwareUsed" => "Sony Alpha 77M2",
                          "physicalCarrierMedia" => "SD card",
                          "deliveryPriority" => "1",
                          "orderingSequence" => "1",
                          "RepresentationCode" => "HIGH",
                          "RepresentationOriginalName" => "K&K/2015/08",
                          "UserDefinedA" => "A1",
                          "UserDefinedB" => "B1",
                          "UserDefinedC" => "C1"
                      }
                  ],
                  "internalIdentifier" => [
                      {"internalIdentifierType" => "SIPID", "internalIdentifierValue" => "55010"},
                      {"internalIdentifierType" => "PID", "internalIdentifierValue" => "REP403596"},
                      {"internalIdentifierType" => "DepositSetID", "internalIdentifierValue" => "55662"}
                  ],
                  "objectCharacteristics" => [
                      {
                          "objectType" => "REPRESENTATION",
                          "creationDate" => "2015-10-13 14:41:56",
                          "createdBy" => "testadmin",
                          "modificationDate" => "2015-10-31 11:43:11",
                          "modifiedBy" => "testadmin",
                          "owner" => "CRS00.TESTINS.TESTDEP",
                          "groupID" => "originals"
                      }
                  ],
                  "preservationLevel" => [
                      {
                          "preservationLevelValue" => "high",
                          "preservationLevelRole" => "my album",
                          "preservationLevelRationale" => "like it",
                          "preservationLevelDateAssigned" => "01/09/2015"
                      }
                  ],
                  "environmentDependencies" => [
                      {
                          "dependencyName" => "my dependency",
                          "dependencyIdentifierType1" => "INTERNAL",
                          "dependencyIdentifierValue1" => "1",
                          "dependencyIdentifierType2" => "URI",
                          "dependencyIdentifierValue2" => "http://www.libis.be",
                          "dependencyIdentifierType3" => "INTERNAL",
                          "dependencyIdentifierValue3" => "abc"
                      }
                  ],
                  "envHardwareRegistry" => [
                      {"registryId" => "XYZ999"},
                      {"registryId" => "ABC123"}
                  ],
                  "envSoftwareRegistry" => [
                      {"registryId" => "env-software-1"}
                  ],
                  "environmentHardware" => [
                      {
                          "hardwareName" => "Sony Alpha 77 M2",
                          "hardwareType" => "Camera",
                          "hardwareOtherInformation" => "SLT"
                      }
                  ],
                  "environmentSoftware" => [
                      {
                          "softwareName" => "JPEG viewer",
                          "softwareVersion" => "0.9 beta 1",
                          "softwareType" => "App",
                          "softwareOtherInformation" => "Mobile",
                          "softwareDependancy" => "Android 4.4"
                      }
                  ],
                  "relationship" => [
                      {
                          "relationshipType" => "STRUCTURAL",
                          "relationshipSubType" => "IS_PART_OF",
                          "relatedObjectIdentifierValue1" => "123456",
                          "relatedObjectSequence1" => "6",
                          "relatedObjectIdentifierValue2" => "555555",
                          "relatedObjectSequence2" => "5",
                          "relatedObjectIdentifierValue3" => "000000",
                          "relatedObjectSequence3" => "0",
                          "relatedObjectIdentifierType1" => "rosetta_pid",
                          "relatedObjectIdentifierType2" => "rosetta_pid",
                          "relatedObjectIdentifierType3" => "rosetta_pid"
                      },
                      {
                          "relationshipType" => "DERIVATION",
                          "relationshipSubType" => "HAS_ROOT",
                          "relatedObjectIdentifierValue1" => "1",
                          "relatedObjectSequence1" => "1",
                          "relatedObjectIdentifierValue2" => "2",
                          "relatedObjectSequence2" => "2",
                          "relatedObjectIdentifierValue3" => "3",
                          "relatedObjectSequence3" => "3",
                          "relatedObjectIdentifierType1" => "rosetta_pid",
                          "relatedObjectIdentifierType2" => "rosetta_pid",
                          "relatedObjectIdentifierType3" => "rosetta_pid"
                      }
                  ],
                  "environment" => [
                      {
                          "environmentCharacteristic" => "dark",
                          "environmentPurpose" => "light condition",
                          "environmentNote" => "best viewed in dark conditions"
                      }
                  ]
              },

          },
          "Table of Contents" => {
              "Zonsondergang Sinebjerg" => {
                  :id => "FL403615",
                  :group => "DSC03102",
                  :amd => {
                      :tech => {
                          "objectCharacteristics" => [
                              {
                                  "objectType" => "FILE",
                                  "creationDate" => "2015-10-31 11:19:45",
                                  "createdBy" => "testadmin",
                                  "modificationDate" => "2015-10-31 11:43:11",
                                  "modifiedBy" => "testadmin",
                                  "owner" => "CRS00.TESTINS.TESTDEP",
                                  "groupID" => "DSC03102"
                              }
                          ],
                          "internalIdentifier" => [
                              {
                                  "internalIdentifierType" => "PID",
                                  "internalIdentifierValue" => "FL403615"
                              }
                          ],
                      }
                  },
                  :dmd => {
                      "text" => "\n        ",
                      "spatial" => "Sinebjerg",
                      "coverage" => "Denemarken 2015",
                      "subject" => "Jitse"
                  }
              },
              "Strand Ristinge" => {
                  :id => "FL403616",
                  :amd => {
                      :tech => {
                          "objectCharacteristics" => [
                              {
                                  "objectType" => "FILE",
                                  "creationDate" => "2015-10-31 11:19:45",
                                  "createdBy" => "testadmin",
                                  "modificationDate" => "2015-10-31 11:19:45",
                                  "modifiedBy" => "testadmin",
                                  "owner" => "CRS00.TESTINS.TESTDEP"
                              }
                          ],
                          "internalIdentifier" => [
                              {
                                  "internalIdentifierType" => "PID",
                                  "internalIdentifierValue" => "FL403616"
                              }
                          ],
                      }
                  }
              },
              "Nachtzicht strand Ærøskøbing" => {
                  :id => "FL403617",
                  :amd => {
                      :tech => {
                          "objectCharacteristics" => [
                              {
                                  "objectType" => "FILE",
                                  "creationDate" => "2015-10-31 11:19:45",
                                  "createdBy" => "testadmin",
                                  "modificationDate" => "2015-10-31 11:19:45",
                                  "modifiedBy" => "testadmin",
                                  "owner" => "CRS00.TESTINS.TESTDEP"
                              }
                          ],
                          "internalIdentifier" => [
                              {
                                  "internalIdentifierType" => "PID",
                                  "internalIdentifierValue" => "FL403617"
                              }
                          ],
                      }
                  }
              },
              "Strandvej schiereiland Ærøskøbing" => {
                  :id => "FL403618",
                  :amd => {
                      :tech => {
                          "objectCharacteristics" => [
                              {
                                  "objectType" => "FILE",
                                  "creationDate" => "2015-10-31 11:19:45",
                                  "createdBy" => "testadmin",
                                  "modificationDate" => "2015-10-31 11:19:45",
                                  "modifiedBy" => "testadmin",
                                  "owner" => "CRS00.TESTINS.TESTDEP"
                              }
                          ],
                          "internalIdentifier" => [
                              {
                                  "internalIdentifierType" => "PID",
                                  "internalIdentifierValue" => "FL403618"
                              }
                          ],
                      }
                  }
              },
              "Skjoldnæs Fyr - Søby" => {
                  :id => "FL403619",
                  :amd => {
                      :tech => {
                          "objectCharacteristics" => [
                              {
                                  "objectType" => "FILE",
                                  "creationDate" => "2015-10-31 11:19:45",
                                  "createdBy" => "testadmin",
                                  "modificationDate" => "2015-10-31 11:19:45",
                                  "modifiedBy" => "testadmin",
                                  "owner" => "CRS00.TESTINS.TESTDEP"
                              }
                          ],
                          "internalIdentifier" => [
                              {
                                  "internalIdentifierType" => "PID",
                                  "internalIdentifierValue" => "FL403619"
                              }
                          ],
                      }
                  }
              },
              "Ingang Legoland Billund" => {
                  :id => "FL403620",
                  :amd => {
                      :tech => {
                          "objectCharacteristics" => [
                              {
                                  "objectType" => "FILE",
                                  "creationDate" => "2015-10-31 11:19:45",
                                  "createdBy" => "testadmin",
                                  "modificationDate" => "2015-10-31 11:19:45",
                                  "modifiedBy" => "testadmin",
                                  "owner" => "CRS00.TESTINS.TESTDEP"
                              }
                          ],
                          "internalIdentifier" => [
                              {
                                  "internalIdentifierType" => "PID",
                                  "internalIdentifierValue" => "FL403620"
                              }
                          ],
                      }
                  }
              }
          }
      }
  )
end
