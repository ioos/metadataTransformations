<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gmx="http://www.isotc211.org/2005/gmx" xmlns:gco="http://www.isotc211.org/2005/gco" xmlns:gts="http://www.isotc211.org/2005/gts" xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:sos="http://www.opengis.net/sos/1.0" xmlns:srv="http://www.isotc211.org/2005/srv" xmlns:ows="http://www.opengis.net/ows/1.1" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml"/>
  <!-- last updates (anna.milan@noaa.gov)-->
  <!-- appends ?service=SOS&request=GetCapabilities&acceptVersions=1.0.0 to the end of getCapabilities URL -->
  <!--translates gml or gml/3.2 input -->
  <!-- The stylesheet version is the revision date -->
  <xsl:variable name="stylesheetVersion" select="'2014-07-21'"/>
  <xsl:key name="uniqueObservedProperties" match="//sos:ObservationOffering/sos:observedProperty" use="@xlink:href"/>
  <xsl:template match="/">
    <gmi:MI_Metadata xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.isotc211.org/2005/gmi http://ngdc.noaa.gov/metadata/published/xsd/schema.xsd" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:gco="http://www.isotc211.org/2005/gco" xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gmx="http://www.isotc211.org/2005/gmx" xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:gss="http://www.isotc211.org/2005/gss" xmlns:gts="http://www.isotc211.org/2005/gts" xmlns:gsr="http://www.isotc211.org/2005/gsr" xmlns:gmi="http://www.isotc211.org/2005/gmi" xmlns:srv="http://www.isotc211.org/2005/srv">
      <xsl:variable name="gmlVersion">
        <xsl:value-of select="namespace-uri-for-prefix('gml',*)"/>
      </xsl:variable>
      <gmd:fileIdentifier>
        <xsl:call-template name="writeCharacterString">
          <xsl:with-param name="stringToWrite" select="/sos:Capabilities/ows:ServiceIdentification/ows:Title"/>
        </xsl:call-template>
      </gmd:fileIdentifier>
      <gmd:hierarchyLevel>
        <xsl:call-template name="writeCodelist">
          <xsl:with-param name="codeListName" select="'gmd:MD_ScopeCode'"/>
          <xsl:with-param name="codeListValue" select="'service'"/>
        </xsl:call-template>
      </gmd:hierarchyLevel>
      <xsl:for-each select="//ows:ServiceProvider">
        <gmd:contact>
          <xsl:call-template name="sosPerson2ResponsibleParty">
            <xsl:with-param name="roleCode" select="'pointOfContact'"/>
          </xsl:call-template>
        </gmd:contact>
      </xsl:for-each>
      <gmd:dateStamp>
        <gco:Date>
          <xsl:value-of select="format-date(current-date(),'[Y0001]-[M01]-[D01]')"/>
        </gco:Date>
      </gmd:dateStamp>
      <gmd:metadataStandardName>
        <gco:CharacterString>ISO 19115-2 Geographic Information - Metadata Part 2 Extensions for imagery and gridded data</gco:CharacterString>
      </gmd:metadataStandardName>
      <gmd:metadataStandardVersion>
        <gco:CharacterString>ISO 19115-2:2009(E)</gco:CharacterString>
      </gmd:metadataStandardVersion>
      <gmd:identificationInfo>
        <srv:SV_ServiceIdentification>
          <gmd:citation>
            <gmd:CI_Citation>
              <gmd:title>
                <xsl:call-template name="writeCharacterString">
                  <xsl:with-param name="stringToWrite" select="/sos:Capabilities/ows:ServiceIdentification/ows:Title"/>
                </xsl:call-template>
              </gmd:title>
              <gmd:date>
                <gmd:CI_Date>
                  <gmd:date>
                    <gco:DateTime>
                      <xsl:value-of select="/sos:Capabilities/sos:Contents/sos:ObservationOfferingList[1]/sos:ObservationOffering[contains(./@gml:id, 'all')][1]/sos:time[1]/gml:TimePeriod[1]/gml:beginPosition[1]" xmlns:gml="http://www.opengis.net/gml"/>
                    </gco:DateTime>
                  </gmd:date>
                  <gmd:dateType>
                    <gmd:CI_DateTypeCode codeList="http://www.ngdc.noaa.gov/metadata/published/xsd/schema/resources/Codelist/gmxCodelists.xml#CI_DateTypeCode" codeListValue="creation">creation</gmd:CI_DateTypeCode>
                  </gmd:dateType>
                </gmd:CI_Date>
              </gmd:date>
              <xsl:for-each select="//ows:ServiceProvider">
                <gmd:citedResponsibleParty>
                  <xsl:call-template name="sosPerson2ResponsibleParty">
                    <xsl:with-param name="roleCode" select="'originator'"/>
                  </xsl:call-template>
                </gmd:citedResponsibleParty>
              </xsl:for-each>
            </gmd:CI_Citation>
          </gmd:citation>
          <gmd:abstract>
            <xsl:call-template name="writeCharacterString">
              <xsl:with-param name="stringToWrite" select="/sos:Capabilities/ows:ServiceIdentification/ows:Abstract"/>
            </xsl:call-template>
          </gmd:abstract>
          <xsl:for-each select="//ows:ServiceProvider">
            <gmd:pointOfContact>
              <xsl:call-template name="sosPerson2ResponsibleParty">
                <xsl:with-param name="roleCode" select="'pointOfContact'"/>
              </xsl:call-template>
            </gmd:pointOfContact>
          </xsl:for-each>
          <xsl:if test="/sos:Capabilities/ows:ServiceIdentification/ows:Keywords">
            <gmd:descriptiveKeywords>
              <gmd:MD_Keywords>
                <xsl:for-each select="/sos:Capabilities/ows:ServiceIdentification/ows:Keywords/ows:Keyword">
                  <gmd:keyword>
                    <gco:CharacterString>
                      <xsl:value-of select="."/>
                    </gco:CharacterString>
                  </gmd:keyword>
                </xsl:for-each>
                <gmd:type>
                  <xsl:call-template name="writeCodelist">
                    <xsl:with-param name="codeListName" select="'gmd:MD_KeywordTypeCode'"/>
                    <xsl:with-param name="codeListValue" select="'theme'"/>
                  </xsl:call-template>
                </gmd:type>
              </gmd:MD_Keywords>
            </gmd:descriptiveKeywords>
          </xsl:if>
          <xsl:if test="/sos:Capabilities/ows:OperationsMetadata/ows:Operation[@name='GetObservation']/ows:Parameter[@name='observedProperty']/ows:AllowedValues/ows:Value">
            <gmd:descriptiveKeywords>
              <gmd:MD_Keywords>
                <xsl:for-each select="/sos:Capabilities/ows:OperationsMetadata/ows:Operation[@name='GetObservation']/ows:Parameter[@name='observedProperty']/ows:AllowedValues/ows:Value">
                  <gmd:keyword>
                    <gco:CharacterString>
                      <xsl:value-of select="."/>
                    </gco:CharacterString>
                  </gmd:keyword>
                </xsl:for-each>
                <gmd:type>
                  <xsl:call-template name="writeCodelist">
                    <xsl:with-param name="codeListName" select="'gmd:MD_KeywordTypeCode'"/>
                    <xsl:with-param name="codeListValue" select="'theme'"/>
                  </xsl:call-template>
                </gmd:type>
                <gmd:thesaurusName>
                  <gmd:CI_Citation xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gco="http://www.isotc211.org/2005/gco" uuid="358e4ad4-66ac-11df-a08a-0800200c9a66">
                    <gmd:title>
                      <gco:CharacterString>NetCDF Climate Forecast Metadata Convention Standard Names</gco:CharacterString>
                    </gmd:title>
                    <gmd:date gco:nilReason="unknown"/>
                    <gmd:citedResponsibleParty>
                      <gmd:CI_ResponsibleParty>
                        <gmd:organisationName>
                          <gco:CharacterString>NetCDF Climate and Forecast (CF) Metadata Convention Standard Names Committee</gco:CharacterString>
                        </gmd:organisationName>
                        <gmd:contactInfo>
                          <gmd:CI_Contact>
                            <gmd:onlineResource>
                              <gmd:CI_OnlineResource>
                                <gmd:linkage>
                                  <gmd:URL>http://cf-pcmdi.llnl.gov/documents</gmd:URL>
                                </gmd:linkage>
                                <gmd:name>
                                  <gco:CharacterString>CF Standard Names Home Page</gco:CharacterString>
                                </gmd:name>
                                <gmd:description>
                                  <gco:CharacterString>Description of the CF Standard Names</gco:CharacterString>
                                </gmd:description>
                                <gmd:function>
                                  <xsl:call-template name="writeCodelist">
                                    <xsl:with-param name="codeListName" select="'gmd:CI_OnLineFunctionCode'"/>
                                    <xsl:with-param name="codeListValue" select="'information'"/>
                                  </xsl:call-template>
                                </gmd:function>
                              </gmd:CI_OnlineResource>
                            </gmd:onlineResource>
                          </gmd:CI_Contact>
                        </gmd:contactInfo>
                        <gmd:role>
                          <gmd:CI_RoleCode codeList="http://www.isotc211.org/2005/resources/codeList.xml#CI_RoleCode" codeListValue="custodian">custodian</gmd:CI_RoleCode>
                        </gmd:role>
                      </gmd:CI_ResponsibleParty>
                    </gmd:citedResponsibleParty>
                  </gmd:CI_Citation>
                </gmd:thesaurusName>
              </gmd:MD_Keywords>
            </gmd:descriptiveKeywords>
          </xsl:if>
          <srv:serviceType>
            <gco:LocalName codeSpace="http://www.opengis.net">
              <xsl:value-of select="/sos:Capabilities/ows:ServiceIdentification/ows:ServiceType"/>
            </gco:LocalName>
          </srv:serviceType>
          <xsl:for-each select="/sos:Capabilities/ows:ServiceIdentification/ows:ServiceTypeVersion">
            <srv:serviceTypeVersion>
              <gco:CharacterString>
                <xsl:value-of select="."/>
              </gco:CharacterString>
            </srv:serviceTypeVersion>
          </xsl:for-each>
          <xsl:if test="/sos:Capabilities/ows:ServiceIdentification/ows:AccessConstraints">
            <srv:restrictions>
              <gmd:MD_LegalConstraints>
                <gmd:accessConstraints>
                  <xsl:call-template name="writeCodelist">
                    <xsl:with-param name="codeListName" select="'gmd:MD_RestrictionCode'"/>
                    <xsl:with-param name="codeListValue" select="'otherRestrictions'"/>
                  </xsl:call-template>
                </gmd:accessConstraints>
                <gmd:otherConstraints>
                  <xsl:call-template name="writeCharacterString">
                    <xsl:with-param name="stringToWrite" select="/sos:Capabilities/ows:ServiceIdentification/ows:AccessConstraints"/>
                  </xsl:call-template>
                </gmd:otherConstraints>
              </gmd:MD_LegalConstraints>
            </srv:restrictions>
          </xsl:if>
          <!-- <xsl:for-each select="//sos:Contents/sos:ObservationOfferingList/sos:ObservationOffering[not(contains(lower-case(@gml:id),'station')) and not(contains(lower-case(@gml:id),'offering'))]"> -->
          <xsl:choose>
            <xsl:when test="contains($gmlVersion,'3.2')">
              <xsl:for-each select="//sos:Contents/sos:ObservationOfferingList/sos:ObservationOffering">
                <srv:extent>
                  <xsl:element name="gmd:EX_Extent">
                    <xsl:if test="@gml:id='network-All'">
                      <xsl:attribute name="id">
                        <xsl:value-of select="'boundingExtent'"/>
                      </xsl:attribute>
                    </xsl:if>
                    <gmd:description>
                      <gco:CharacterString>
                        <xsl:value-of select="@gml:id"/>
                      </gco:CharacterString>
                    </gmd:description>
                    <gmd:geographicElement>
                      <xsl:element name="gmd:EX_GeographicBoundingBox">
                        <xsl:if test="@gml:id='network-All'">
                          <xsl:attribute name="id">
                            <xsl:value-of select="'boundingGeographicBoundingBox'"/>
                          </xsl:attribute>
                        </xsl:if>
                        <gmd:westBoundLongitude>
                          <gco:Decimal>
                            <xsl:value-of select="tokenize(string(gml:boundedBy/gml:Envelope/gml:lowerCorner),' ')[2]"/>
                          </gco:Decimal>
                        </gmd:westBoundLongitude>
                        <gmd:eastBoundLongitude>
                          <gco:Decimal>
                            <xsl:value-of select="tokenize(string(gml:boundedBy/gml:Envelope/gml:upperCorner),' ')[2]"/>
                          </gco:Decimal>
                        </gmd:eastBoundLongitude>
                        <gmd:southBoundLatitude>
                          <gco:Decimal>
                            <xsl:value-of select="tokenize(string(gml:boundedBy/gml:Envelope/gml:lowerCorner),' ')[1]"/>
                          </gco:Decimal>
                        </gmd:southBoundLatitude>
                        <gmd:northBoundLatitude>
                          <gco:Decimal>
                            <xsl:value-of select="tokenize(string(gml:boundedBy/gml:Envelope/gml:upperCorner),' ')[1]"/>
                          </gco:Decimal>
                        </gmd:northBoundLatitude>
                      </xsl:element>
                    </gmd:geographicElement>
                    <gmd:temporalElement>
                      <xsl:element name="gmd:EX_TemporalExtent">
                        <xsl:if test="@gml:id='network-All'">
                          <xsl:attribute name="id">
                            <xsl:value-of select="'boundingTemporalExtent'"/>
                          </xsl:attribute>
                        </xsl:if>
                        <gmd:extent>
                          <gml:TimePeriod>
                            <xsl:attribute name="gml:id" select="generate-id()"/>
                            <!-- Check to see if there are attributes on the beginPosition -->
                            <xsl:choose>
                              <xsl:when test="sos:time/gml:TimePeriod/gml:beginPosition/@*">
                                <!--<xsl:copy-of select="sos:time/gml:TimePeriod/gml:beginPosition"/>-->
                                <xsl:element name="gml:beginPosition">
                                  <xsl:copy-of select="sos:time/gml:TimePeriod/gml:beginPosition/@*"/>
                                </xsl:element>
                              </xsl:when>
                              <xsl:when test="sos:time/gml:TimePeriod/gml:beginPosition">
                                <xsl:element name="gml:beginPosition">
                                  <!-- This regular expression matches the expected time string -->
                                  <xsl:analyze-string select="sos:time/gml:TimePeriod/gml:beginPosition" regex="^[0-9]{{4}}-[0-9]{{2}}-[0-9]{{2}}T[0-9]{{2}}:[0-9]{{2}}:[0-9]{{2}}\.?\d*Z?">
                                    <xsl:matching-substring>
                                      <!-- If the dateTime string matches the regular expression - write it out -->
                                      <xsl:value-of select="."/>
                                    </xsl:matching-substring>
                                    <xsl:non-matching-substring>
                                      <xsl:choose>
                                        <xsl:when test=".">
                                          <!-- This handles the case where there is a Z in the string, but no seconds -->
                                          <xsl:value-of select="concat(substring-before(.,'Z'),':00Z')"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                          <xsl:copy-of select="."/>
                                        </xsl:otherwise>
                                      </xsl:choose>
                                    </xsl:non-matching-substring>
                                  </xsl:analyze-string>
                                </xsl:element>
                              </xsl:when>
                              <xsl:otherwise>
                                <gml:beginPosition indeterminatePosition="unknown"/>
                              </xsl:otherwise>
                            </xsl:choose>
                            <!-- Check to see if there are attributes on the endPosition -->
                            <xsl:choose>
                              <xsl:when test="sos:time/gml:TimePeriod/gml:endPosition/@*">
                                <xsl:element name="gml:endPosition">
                                  <xsl:copy-of select="sos:time/gml:TimePeriod/gml:endPosition/@*"/>
                                </xsl:element>
                                <!--<xsl:copy-of select="sos:time/gml:TimePeriod/gml:endPosition" copy-namespaces="no"/>-->
                              </xsl:when>
                              <xsl:when test="sos:time/gml:TimePeriod/gml:endPosition">
                                <xsl:element name="gml:endPosition">
                                  <!-- This regular expression matches the expected time string -->
                                  <xsl:analyze-string select="sos:time/gml:TimePeriod/gml:endPosition" regex="^[0-9]{{4}}-[0-9]{{2}}-[0-9]{{2}}T[0-9]{{2}}:[0-9]{{2}}:[0-9]{{2}}\.?\d*Z?">
                                    <xsl:matching-substring>
                                      <!-- If the dateTime string matches the regular expression - write it out -->
                                      <xsl:value-of select="."/>
                                    </xsl:matching-substring>
                                    <xsl:non-matching-substring>
                                      <xsl:choose>
                                        <xsl:when test=".">
                                          <!-- This handles the case where there is a Z in the string, but no seconds -->
                                          <xsl:value-of select="concat(substring-before(.,'Z'),':00Z')"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                          <!-- This is where I am trying to pick up the attributes for an empty element -->
                                          <xsl:copy-of select="."/>
                                        </xsl:otherwise>
                                      </xsl:choose>
                                    </xsl:non-matching-substring>
                                  </xsl:analyze-string>
                                </xsl:element>
                              </xsl:when>
                              <xsl:otherwise>
                                <gml:endPosition indeterminatePosition="unknown"/>
                              </xsl:otherwise>
                            </xsl:choose>
                          </gml:TimePeriod>
                        </gmd:extent>
                      </xsl:element>
                    </gmd:temporalElement>
                  </xsl:element>
                </srv:extent>
              </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
              <xsl:for-each select="//sos:Contents/sos:ObservationOfferingList/sos:ObservationOffering">
                <srv:extent>
                  <xsl:element name="gmd:EX_Extent">
                    <xsl:if test="@gml:id='network-All'" xmlns:gml="http://www.opengis.net/gml">
                      <xsl:attribute name="id">
                        <xsl:value-of select="'boundingExtent'"/>
                      </xsl:attribute>
                    </xsl:if>
                    <gmd:description>
                      <gco:CharacterString>
                        <xsl:value-of select="@gml:id" xmlns:gml="http://www.opengis.net/gml"/>
                      </gco:CharacterString>
                    </gmd:description>
                    <gmd:geographicElement>
                      <xsl:element name="gmd:EX_GeographicBoundingBox">
                        <xsl:if test="@gml:id='network-All'" xmlns:gml="http://www.opengis.net/gml">
                          <xsl:attribute name="id">
                            <xsl:value-of select="'boundingGeographicBoundingBox'"/>
                          </xsl:attribute>
                        </xsl:if>
                        <gmd:westBoundLongitude>
                          <gco:Decimal>
                            <xsl:value-of select="tokenize(string(gml:boundedBy/gml:Envelope/gml:lowerCorner),' ')[2]" xmlns:gml="http://www.opengis.net/gml"/>
                          </gco:Decimal>
                        </gmd:westBoundLongitude>
                        <gmd:eastBoundLongitude>
                          <gco:Decimal>
                            <xsl:value-of select="tokenize(string(gml:boundedBy/gml:Envelope/gml:upperCorner),' ')[2]" xmlns:gml="http://www.opengis.net/gml"/>
                          </gco:Decimal>
                        </gmd:eastBoundLongitude>
                        <gmd:southBoundLatitude>
                          <gco:Decimal>
                            <xsl:value-of select="tokenize(string(gml:boundedBy/gml:Envelope/gml:lowerCorner),' ')[1]" xmlns:gml="http://www.opengis.net/gml"/>
                          </gco:Decimal>
                        </gmd:southBoundLatitude>
                        <gmd:northBoundLatitude>
                          <gco:Decimal>
                            <xsl:value-of select="tokenize(string(gml:boundedBy/gml:Envelope/gml:upperCorner),' ')[1]" xmlns:gml="http://www.opengis.net/gml"/>
                          </gco:Decimal>
                        </gmd:northBoundLatitude>
                      </xsl:element>
                    </gmd:geographicElement>
                    <gmd:temporalElement>
                      <xsl:element name="gmd:EX_TemporalExtent">
                        <xsl:if test="@gml:id='network-All'" xmlns:gml="http://www.opengis.net/gml">
                          <xsl:attribute name="id">
                            <xsl:value-of select="'boundingTemporalExtent'"/>
                          </xsl:attribute>
                        </xsl:if>
                        <gmd:extent>
                          <gml:TimePeriod>
                            <xsl:attribute name="gml:id" select="generate-id()"/>
                            <!-- Check to see if there are attributes on the beginPosition -->
                            <xsl:choose>
                              <xsl:when test="sos:time/gml:TimePeriod/gml:beginPosition/@*" xmlns:gml="http://www.opengis.net/gml">
                                <!--<xsl:copy-of select="sos:time/gml:TimePeriod/gml:beginPosition" xmlns:gml="http://www.opengis.net/gml"/>-->
                                <xsl:element name="gml:beginPosition" xmlns:gml="http://www.opengis.net/gml/3.2">
                                  <xsl:copy-of select="sos:time/gml:TimePeriod/gml:beginPosition/@*" xmlns:gml="http://www.opengis.net/gml"/>
                                </xsl:element>
                              </xsl:when>
                              <xsl:when test="sos:time/gml:TimePeriod/gml:beginPosition" xmlns:gml="http://www.opengis.net/gml">
                                <xsl:element name="gml:beginPosition" xmlns:gml="http://www.opengis.net/gml/3.2">
                                  <!-- This regular expression matches the expected time string -->
                                  <xsl:analyze-string select="sos:time/gml:TimePeriod/gml:beginPosition" regex="^[0-9]{{4}}-[0-9]{{2}}-[0-9]{{2}}T[0-9]{{2}}:[0-9]{{2}}:[0-9]{{2}}\.?\d*Z?" xmlns:gml="http://www.opengis.net/gml">
                                    <xsl:matching-substring>
                                      <!-- If the dateTime string matches the regular expression - write it out -->
                                      <xsl:value-of select="."/>
                                    </xsl:matching-substring>
                                    <xsl:non-matching-substring>
                                      <xsl:choose>
                                        <xsl:when test=".">
                                          <!-- This handles the case where there is a Z in the string, but no seconds -->
                                          <xsl:value-of select="concat(substring-before(.,'Z'),':00Z')"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                          <xsl:copy-of select="."/>
                                        </xsl:otherwise>
                                      </xsl:choose>
                                    </xsl:non-matching-substring>
                                  </xsl:analyze-string>
                                </xsl:element>
                              </xsl:when>
                              <xsl:otherwise>
                                <gml:beginPosition indeterminatePosition="unknown"/>
                              </xsl:otherwise>
                            </xsl:choose>
                            <!-- Check to see if there are attributes on the endPosition -->
                            <xsl:choose>
                              <xsl:when test="sos:time/gml:TimePeriod/gml:endPosition/@*" xmlns:gml="http://www.opengis.net/gml">
                                <xsl:element name="gml:endPosition" xmlns:gml="http://www.opengis.net/gml/3.2">
                                  <xsl:copy-of select="sos:time/gml:TimePeriod/gml:endPosition/@*" xmlns:gml="http://www.opengis.net/gml"/>
                                </xsl:element>
                                <!--<xsl:copy-of select="sos:time/gml:TimePeriod/gml:endPosition" copy-namespaces="no"/>-->
                              </xsl:when>
                              <xsl:when test="sos:time/gml:TimePeriod/gml:endPosition" xmlns:gml="http://www.opengis.net/gml">
                                <xsl:element name="gml:endPosition" xmlns:gml="http://www.opengis.net/gml/3.2">
                                  <!-- This regular expression matches the expected time string -->
                                  <xsl:analyze-string select="sos:time/gml:TimePeriod/gml:endPosition" regex="^[0-9]{{4}}-[0-9]{{2}}-[0-9]{{2}}T[0-9]{{2}}:[0-9]{{2}}:[0-9]{{2}}\.?\d*Z?" xmlns:gml="http://www.opengis.net/gml">
                                    <xsl:matching-substring>
                                      <!-- If the dateTime string matches the regular expression - write it out -->
                                      <xsl:value-of select="."/>
                                    </xsl:matching-substring>
                                    <xsl:non-matching-substring>
                                      <xsl:choose>
                                        <xsl:when test=".">
                                          <!-- This handles the case where there is a Z in the string, but no seconds -->
                                          <xsl:value-of select="concat(substring-before(.,'Z'),':00Z')"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                          <!-- This is where I am trying to pick up the attributes for an empty element -->
                                          <xsl:copy-of select="."/>
                                        </xsl:otherwise>
                                      </xsl:choose>
                                    </xsl:non-matching-substring>
                                  </xsl:analyze-string>
                                </xsl:element>
                              </xsl:when>
                              <xsl:otherwise>
                                <gml:endPosition indeterminatePosition="unknown"/>
                              </xsl:otherwise>
                            </xsl:choose>
                          </gml:TimePeriod>
                        </gmd:extent>
                      </xsl:element>
                    </gmd:temporalElement>
                  </xsl:element>
                </srv:extent>
              </xsl:for-each>
            </xsl:otherwise>
          </xsl:choose>
          <srv:couplingType>
            <xsl:call-template name="writeCodelist">
              <xsl:with-param name="codeListName" select="'srv:SV_CouplingType'"/>
              <xsl:with-param name="codeListValue" select="'tight'"/>
            </xsl:call-template>
          </srv:couplingType>
          <xsl:for-each select="/sos:Capabilities/ows:OperationsMetadata/ows:Operation">
            <xsl:call-template name="writeOperation"/>
          </xsl:for-each>
        </srv:SV_ServiceIdentification>
      </gmd:identificationInfo>
      <xsl:if test="/sos:Capabilities/ows:OperationsMetadata/ows:Operation[@name='GetObservation']/ows:Parameter[@name='observedProperty']/ows:AllowedValues">
        <gmd:contentInfo>
          <gmd:MD_CoverageDescription>
            <gmd:attributeDescription>
              <xsl:attribute name="gco:nilReason">
                <xsl:value-of select="'unknown'"/>
              </xsl:attribute>
            </gmd:attributeDescription>
            <gmd:contentType>
              <xsl:call-template name="writeCodelist">
                <xsl:with-param name="codeListName" select="'gmd:MD_CoverageContentTypeCode'"/>
                <xsl:with-param name="codeListValue" select="'physicalMeasurement'"/>
              </xsl:call-template>
            </gmd:contentType>
            <xsl:for-each select="//sos:ObservationOffering/sos:observedProperty[generate-id() = generate-id(key('uniqueObservedProperties',@xlink:href)[1])]">
              <xsl:call-template name="writeVariable">
                <xsl:with-param name="variableName" select="@xlink:href"/>
              </xsl:call-template>
            </xsl:for-each>
          </gmd:MD_CoverageDescription>
        </gmd:contentInfo>
      </xsl:if>
      <gmd:distributionInfo>
        <gmd:MD_Distribution>
          <gmd:distributor>
            <gmd:MD_Distributor>
              <xsl:for-each select="//ows:ServiceProvider">
                <gmd:distributorContact>
                  <xsl:call-template name="sosPerson2ResponsibleParty">
                    <xsl:with-param name="roleCode" select="'pointOfContact'"/>
                  </xsl:call-template>
                </gmd:distributorContact>
              </xsl:for-each>
              <xsl:choose>
                <xsl:when test="count(/sos:Capabilities/ows:ServiceIdentification/ows:ServiceTypeVersion) le 1">
                  <gmd:distributorFormat>
                    <gmd:MD_Format>
                      <gmd:name>
                        <xsl:call-template name="writeCharacterString">
                          <xsl:with-param name="stringToWrite" select="/sos:Capabilities/ows:ServiceIdentification/ows:ServiceType"/>
                        </xsl:call-template>
                      </gmd:name>
                      <gmd:version>
                        <xsl:call-template name="writeCharacterString">
                          <xsl:with-param name="stringToWrite" select="/sos:Capabilities/ows:ServiceIdentification/ows:ServiceTypeVersion"/>
                        </xsl:call-template>
                      </gmd:version>
                    </gmd:MD_Format>
                  </gmd:distributorFormat>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:for-each select="/sos:Capabilities/ows:ServiceIdentification/ows:ServiceTypeVersion">
                    <gmd:distributorFormat>
                      <gmd:MD_Format>
                        <gmd:name>
                          <xsl:call-template name="writeCharacterString">
                            <xsl:with-param name="stringToWrite" select="/sos:Capabilities/ows:ServiceIdentification/ows:ServiceType"/>
                          </xsl:call-template>
                        </gmd:name>
                        <gmd:version>
                          <xsl:call-template name="writeCharacterString">
                            <xsl:with-param name="stringToWrite" select="."/>
                          </xsl:call-template>
                        </gmd:version>
                      </gmd:MD_Format>
                    </gmd:distributorFormat>
                  </xsl:for-each>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:if test="//ows:Operation[@name='GetCapabilities']/ows:DCP/ows:HTTP/ows:Post">
                <xsl:for-each select="/sos:Capabilities/ows:OperationsMetadata/ows:Operation[@name='GetCapabilities']/ows:DCP/ows:HTTP/ows:Post">
                  <gmd:distributorTransferOptions>
                    <gmd:MD_DigitalTransferOptions>
                      <gmd:onLine>
                        <gmd:CI_OnlineResource>
                          <gmd:linkage>
                            <gmd:URL>
                              <xsl:value-of select="@xlink:href"/>
                            </gmd:URL>
                          </gmd:linkage>
                          <gmd:protocol>
                            <gco:CharacterString>
                              <xsl:value-of select="'http'"/>
                            </gco:CharacterString>
                          </gmd:protocol>
                          <gmd:description>
                            <xsl:call-template name="writeCharacterString">
                              <xsl:with-param name="stringToWrite" select="'OGC Sensor Observation Service Capabilities (Post)'"/>
                            </xsl:call-template>
                          </gmd:description>
                          <gmd:function>
                            <xsl:call-template name="writeCodelist">
                              <xsl:with-param name="codeListName" select="'gmd:CI_OnLineFunctionCode'"/>
                              <xsl:with-param name="codeListValue" select="'download'"/>
                            </xsl:call-template>
                          </gmd:function>
                        </gmd:CI_OnlineResource>
                      </gmd:onLine>
                    </gmd:MD_DigitalTransferOptions>
                  </gmd:distributorTransferOptions>
                </xsl:for-each>
                <!--<gmd:distributorTransferOptions>
                  <gmd:MD_DigitalTransferOptions>
                    <gmd:onLine>
                      <gmd:CI_OnlineResource>
                        <gmd:linkage>
                          <gmd:URL>
                            <xsl:value-of
                              select="/sos:Capabilities/ows:OperationsMetadata/ows:Operation[@name='GetCapabilities']/ows:DCP/ows:HTTP/ows:Post/@xlink:href"/>
                            <xsl:if
                              test="not(contains(ows:DCP/ows:HTTP/ows:Get/@xlink:href,'request'))">
                              <xsl:value-of select="'?service=SOS&amp;request=GetCapabilities'"/>
                            </xsl:if>
                          </gmd:URL>
                        </gmd:linkage>
                        <gmd:protocol>
                          <gco:CharacterString>
                            <xsl:value-of select="'http'"/>
                          </gco:CharacterString>
                        </gmd:protocol>
                        <gmd:description>
                          <xsl:call-template name="writeCharacterString">
                            <xsl:with-param name="stringToWrite"
                              select="'OGC Sensor Observation Service Capabilities (Post)'"/>
                          </xsl:call-template>
                        </gmd:description>
                        <gmd:function>
                          <xsl:call-template name="writeCodelist">
                            <xsl:with-param name="codeListName" select="'gmd:CI_OnLineFunctionCode'"/>
                            <xsl:with-param name="codeListValue" select="'download'"/>
                          </xsl:call-template>
                        </gmd:function>
                      </gmd:CI_OnlineResource>
                    </gmd:onLine>
                  </gmd:MD_DigitalTransferOptions>
                </gmd:distributorTransferOptions>-->
              </xsl:if>
              <xsl:if test="//ows:Operation[@name='GetCapabilities']/ows:DCP/ows:HTTP/ows:Get">
                <xsl:for-each select="/sos:Capabilities/ows:OperationsMetadata/ows:Operation[@name='GetCapabilities']/ows:DCP/ows:HTTP/ows:Get">
                  <gmd:distributorTransferOptions>
                    <gmd:MD_DigitalTransferOptions>
                      <gmd:onLine>
                        <gmd:CI_OnlineResource>
                          <gmd:linkage>
                            <!--<xsl:comment><xsl:value-of select="/sos:Capabilities/ows:OperationsMetadata/ows:Operation[@name='GetCapabilities']/ows:DCP/ows:HTTP/ows:Get/@xlink:href"/></xsl:comment>-->
                            <gmd:URL>
                              <xsl:choose>
                                <xsl:when test="contains(@xlink:href,'?')">
                                  <xsl:value-of select="concat(@xlink:href, 'service=SOS&amp;request=GetCapabilities&amp;acceptVersions=1.0.0')"/>
                                </xsl:when>
                                <xsl:when test="not(contains(@xlink:href,'?'))">
                                  <xsl:value-of select="concat(@xlink:href, '?service=SOS&amp;request=GetCapabilities&amp;acceptVersions=1.0.0')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                  <xsl:value-of select="@xlink:href"/>
                                </xsl:otherwise>
                              </xsl:choose>                              
                            </gmd:URL>
                          </gmd:linkage>
                          <gmd:protocol>
                            <gco:CharacterString>
                              <xsl:value-of select="'http'"/>
                            </gco:CharacterString>
                          </gmd:protocol>
                          <gmd:description>
                            <xsl:call-template name="writeCharacterString">
                              <xsl:with-param name="stringToWrite" select="'OGC Sensor Observation Service Capabilities (Get)'"/>
                            </xsl:call-template>
                          </gmd:description>
                          <gmd:function>
                            <xsl:call-template name="writeCodelist">
                              <xsl:with-param name="codeListName" select="'gmd:CI_OnLineFunctionCode'"/>
                              <xsl:with-param name="codeListValue" select="'download'"/>
                            </xsl:call-template>
                          </gmd:function>
                        </gmd:CI_OnlineResource>
                      </gmd:onLine>
                    </gmd:MD_DigitalTransferOptions>
                  </gmd:distributorTransferOptions>
                </xsl:for-each>
              </xsl:if>
            </gmd:MD_Distributor>
          </gmd:distributor>
        </gmd:MD_Distribution>
      </gmd:distributionInfo>
      <gmd:metadataMaintenance>
        <gmd:MD_MaintenanceInformation>
          <gmd:maintenanceAndUpdateFrequency>
            <gmd:MD_MaintenanceFrequencyCode codeList="http://www.ngdc.noaa.gov/metadata/published/xsd/schema/resources/Codelist/gmxCodelists.xml#MD_MaintenanceFrequencyCode" codeListValue="unknown">unknown</gmd:MD_MaintenanceFrequencyCode>
          </gmd:maintenanceAndUpdateFrequency>
          <gmd:maintenanceNote>
            <gco:CharacterString>This record was translated from SOS Capabilities using SOS2ISO_MI.xsl Version <xsl:value-of select="$stylesheetVersion"/> at <xsl:value-of select="current-dateTime()"/>.</gco:CharacterString>
          </gmd:maintenanceNote>
        </gmd:MD_MaintenanceInformation>
      </gmd:metadataMaintenance>
    </gmi:MI_Metadata>
  </xsl:template>
  <xsl:template name="writeCharacterString">
    <xsl:param name="stringToWrite"/>
    <xsl:choose>
      <xsl:when test="string($stringToWrite)">
        <gco:CharacterString>
          <xsl:value-of select="normalize-space($stringToWrite)"/>
        </gco:CharacterString>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="gco:nilReason">
          <xsl:value-of select="'missing'"/>
        </xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="writeCodelist">
    <xsl:param name="codeListName"/>
    <xsl:param name="codeListValue"/>
    <xsl:variable name="codeListLocation" select="'http://www.ngdc.noaa.gov/metadata/published/xsd/schema/resources/Codelist/gmxCodelists.xml'"/>
    <xsl:element name="{$codeListName}">
      <xsl:attribute name="codeList">
        <xsl:value-of select="$codeListLocation"/>
        <xsl:value-of select="'#'"/>
        <xsl:value-of select="$codeListName"/>
      </xsl:attribute>
      <xsl:attribute name="codeListValue">
        <xsl:value-of select="$codeListValue"/>
      </xsl:attribute>
      <xsl:value-of select="$codeListValue"/>
    </xsl:element>
  </xsl:template>
  <xsl:template name="sosPerson2ResponsibleParty">
    <xsl:param name="roleCode"/>
    <gmd:CI_ResponsibleParty>
      <xsl:if test="normalize-space(ows:ServiceContact/ows:IndividualName)">
        <gmd:individualName>
          <xsl:call-template name="writeCharacterString">
            <xsl:with-param name="stringToWrite" select="ows:ServiceContact/ows:IndividualName"/>
          </xsl:call-template>
        </gmd:individualName>
      </xsl:if>
      <xsl:if test="normalize-space(ows:ProviderName)">
        <gmd:organisationName>
          <xsl:call-template name="writeCharacterString">
            <xsl:with-param name="stringToWrite" select="ows:ProviderName"/>
          </xsl:call-template>
        </gmd:organisationName>
      </xsl:if>
      <xsl:if test="normalize-space(ows:ServiceContact/ows:PositionName)">
        <gmd:positionName>
          <xsl:call-template name="writeCharacterString">
            <xsl:with-param name="stringToWrite" select="ows:ServiceContact/ows:PositionName"/>
          </xsl:call-template>
        </gmd:positionName>
      </xsl:if>
      <gmd:contactInfo>
        <gmd:CI_Contact>
          <xsl:if test="normalize-space(ows:ServiceContact/ows:ContactInfo/ows:Phone/ows:Voice) or normalize-space(ows:ServiceContact/ows:ContactInfo/ows:Phone/ows:Facsimile)">
            <gmd:phone>
              <gmd:CI_Telephone>
                <gmd:voice>
                  <xsl:call-template name="writeCharacterString">
                    <xsl:with-param name="stringToWrite" select="ows:ServiceContact/ows:ContactInfo/ows:Phone/ows:Voice"/>
                  </xsl:call-template>
                </gmd:voice>
                <gmd:facsimile>
                  <xsl:call-template name="writeCharacterString">
                    <xsl:with-param name="stringToWrite" select="ows:ServiceContact/ows:ContactInfo/ows:Phone/ows:Facsimile"/>
                  </xsl:call-template>
                </gmd:facsimile>
              </gmd:CI_Telephone>
            </gmd:phone>
          </xsl:if>
          <xsl:if test="normalize-space(ows:ServiceContact/ows:ContactInfo/ows:Address)">
            <gmd:address>
              <gmd:CI_Address>
                <xsl:if test="normalize-space(ows:ServiceContact/ows:ContactInfo/ows:Address/ows:DeliveryPoint)">
                  <xsl:for-each select="ows:ServiceContact/ows:ContactInfo/ows:Address/ows:DeliveryPoint">
                    <gmd:deliveryPoint>
                      <xsl:call-template name="writeCharacterString">
                        <xsl:with-param name="stringToWrite" select="."/>
                      </xsl:call-template>
                    </gmd:deliveryPoint>
                  </xsl:for-each>
                </xsl:if>
                <xsl:if test="normalize-space(ows:ServiceContact/ows:ContactInfo/ows:Address/ows:City)">
                  <gmd:city>
                    <xsl:call-template name="writeCharacterString">
                      <xsl:with-param name="stringToWrite" select="ows:ServiceContact/ows:ContactInfo/ows:Address/ows:City"/>
                    </xsl:call-template>
                  </gmd:city>
                </xsl:if>
                <xsl:if test="normalize-space(ows:ServiceContact/ows:ContactInfo/ows:Address/ows:AdministrativeArea)">
                  <gmd:administrativeArea>
                    <xsl:call-template name="writeCharacterString">
                      <xsl:with-param name="stringToWrite" select="ows:ServiceContact/ows:ContactInfo/ows:Address/ows:AdministrativeArea"/>
                    </xsl:call-template>
                  </gmd:administrativeArea>
                </xsl:if>
                <xsl:if test="normalize-space(ows:ServiceContact/ows:ContactInfo/ows:Address/ows:PostalCode)">
                  <gmd:postalCode>
                    <xsl:call-template name="writeCharacterString">
                      <xsl:with-param name="stringToWrite" select="ows:ServiceContact/ows:ContactInfo/ows:Address/ows:PostalCode"/>
                    </xsl:call-template>
                  </gmd:postalCode>
                </xsl:if>
                <xsl:if test="normalize-space(ows:ServiceContact/ows:ContactInfo/ows:Address/ows:Country)">
                  <gmd:country>
                    <xsl:call-template name="writeCharacterString">
                      <xsl:with-param name="stringToWrite" select="ows:ServiceContact/ows:ContactInfo/ows:Address/ows:Country"/>
                    </xsl:call-template>
                  </gmd:country>
                </xsl:if>
                <xsl:if test="normalize-space(ows:ServiceContact/ows:ContactInfo/ows:Address/ows:ElectronicMailAddress)">
                  <gmd:electronicMailAddress>
                    <xsl:call-template name="writeCharacterString">
                      <xsl:with-param name="stringToWrite" select="ows:ServiceContact/ows:ContactInfo/ows:Address/ows:ElectronicMailAddress"/>
                    </xsl:call-template>
                  </gmd:electronicMailAddress>
                </xsl:if>
              </gmd:CI_Address>
            </gmd:address>
          </xsl:if>
          <gmd:onlineResource>
            <gmd:CI_OnlineResource>
              <gmd:linkage>
                <gmd:URL>
                  <xsl:value-of select="ows:ProviderSite/@xlink:href"/>
                </gmd:URL>
              </gmd:linkage>
              <gmd:function>
                <xsl:call-template name="writeCodelist">
                  <xsl:with-param name="codeListName" select="'gmd:CI_OnLineFunctionCode'"/>
                  <xsl:with-param name="codeListValue" select="'information'"/>
                </xsl:call-template>
              </gmd:function>
            </gmd:CI_OnlineResource>
          </gmd:onlineResource>
          <xsl:if test="normalize-space(org-contact-info/business-hours)">
            <gmd:hoursOfService>
              <xsl:call-template name="writeCharacterString">
                <xsl:with-param name="stringToWrite" select="org-contact-info/business-hours"/>
              </xsl:call-template>
            </gmd:hoursOfService>
          </xsl:if>
          <xsl:if test="normalize-space(contact-instructions)">
            <gmd:contactInstructions>
              <xsl:call-template name="writeCharacterString">
                <xsl:with-param name="stringToWrite" select="contact-instructions"/>
              </xsl:call-template>
            </gmd:contactInstructions>
          </xsl:if>
        </gmd:CI_Contact>
      </gmd:contactInfo>
      <gmd:role>
        <xsl:call-template name="writeCodelist">
          <xsl:with-param name="codeListName" select="'gmd:CI_RoleCode'"/>
          <xsl:with-param name="codeListValue" select="$roleCode"/>
        </xsl:call-template>
      </gmd:role>
    </gmd:CI_ResponsibleParty>
  </xsl:template>
  <xsl:template name="writeVariable">
    <xsl:param name="variableName"/>
    <gmd:dimension>
      <gmd:MD_Band>
        <gmd:sequenceIdentifier>
          <gco:MemberName>
            <gco:aName>
              <xsl:element name="gmx:Anchor">
                <xsl:attribute name="xlink:href" select="$variableName"/>
                <xsl:attribute name="xlink:actuate" select="'onRequest'"/>
                <xsl:choose>
                  <xsl:when test="contains($variableName,'#')">
                    <xsl:value-of select="substring-after($variableName,'#')"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="tokenize($variableName,'/')[last()]"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:element>
            </gco:aName>
            <gco:attributeType gco:nilReason="unknown"/>
          </gco:MemberName>
        </gmd:sequenceIdentifier>
      </gmd:MD_Band>
    </gmd:dimension>
  </xsl:template>
  <xsl:template name="writeOperation">
    <srv:containsOperations>
      <srv:SV_OperationMetadata>
        <srv:operationName>
          <gco:CharacterString>
            <xsl:value-of select="@name"/>
          </gco:CharacterString>
        </srv:operationName>
        <srv:DCP gco:nilReason="unknown"/>
        <xsl:for-each select="ows:Parameter">
          <srv:parameters>
            <srv:SV_Parameter>
              <srv:name>
                <gco:aName>
                  <gco:CharacterString>
                    <xsl:value-of select="@name"/>
                  </gco:CharacterString>
                </gco:aName>
                <gco:attributeType gco:nilReason="unknown"/>
              </srv:name>
              <srv:description>
                <gco:CharacterString>
                  <xsl:text>Allowed values: </xsl:text>
                  <xsl:for-each select="ows:AllowedValues/ows:Value">
                    <xsl:if test="position()!=1">
                      <xsl:text>, </xsl:text>
                    </xsl:if>
                    <xsl:value-of select="."/>
                  </xsl:for-each>
                </gco:CharacterString>
              </srv:description>
              <srv:optionality>
                <gco:CharacterString>Optional</gco:CharacterString>
              </srv:optionality>
              <srv:repeatability>
                <gco:Boolean>false</gco:Boolean>
              </srv:repeatability>
              <srv:valueType>
                <gco:TypeName>
                  <gco:aName>
                    <gco:CharacterString>CharacterString</gco:CharacterString>
                  </gco:aName>
                </gco:TypeName>
              </srv:valueType>
            </srv:SV_Parameter>
          </srv:parameters>
        </xsl:for-each>
        <xsl:if test="ows:DCP/ows:HTTP/ows:Post">
          <xsl:for-each select="ows:DCP/ows:HTTP/ows:Post">
            <srv:connectPoint>
              <gmd:CI_OnlineResource>
                <gmd:linkage>
                  <gmd:URL>
                    <xsl:value-of select="./@xlink:href"/>
                  </gmd:URL>
                </gmd:linkage>
                <gmd:protocol>
                  <gco:CharacterString>
                    <xsl:value-of select="'http'"/>
                  </gco:CharacterString>
                </gmd:protocol>
                <gmd:description>
                  <xsl:call-template name="writeCharacterString">
                    <xsl:with-param name="stringToWrite" select="'OGC Sensor Observation Service Capabilities (Post)'"/>
                  </xsl:call-template>
                </gmd:description>
                <gmd:function>
                  <xsl:call-template name="writeCodelist">
                    <xsl:with-param name="codeListName" select="'gmd:CI_OnLineFunctionCode'"/>
                    <xsl:with-param name="codeListValue" select="'download'"/>
                  </xsl:call-template>
                </gmd:function>
              </gmd:CI_OnlineResource>
            </srv:connectPoint>
          </xsl:for-each>
        </xsl:if>
        <xsl:if test="ows:DCP/ows:HTTP/ows:Get">          
          <xsl:for-each select="ows:DCP/ows:HTTP/ows:Get">
            <srv:connectPoint>
              <gmd:CI_OnlineResource>
                <gmd:linkage>
                  <gmd:URL>                    
                    <xsl:choose>
                      <xsl:when test="contains(./@xlink:href,'?')">                        
                        <xsl:value-of select="concat(./@xlink:href, 'service=SOS&amp;request=GetCapabilities&amp;acceptVersions=1.0.0')"/>
                      </xsl:when>
                      <xsl:when test="not(contains(./@xlink:href,'?'))">
                        <xsl:value-of select="concat(./@xlink:href, '?service=SOS&amp;request=GetCapabilities&amp;acceptVersions=1.0.0')"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="./@xlink:href"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </gmd:URL>
                </gmd:linkage>
                <gmd:protocol>
                  <gco:CharacterString>
                    <xsl:value-of select="'http'"/>
                  </gco:CharacterString>
                </gmd:protocol>
                <gmd:description>
                  <xsl:call-template name="writeCharacterString">
                    <xsl:with-param name="stringToWrite" select="'OGC Sensor Observation Service Capabilities (Get)'"/>
                  </xsl:call-template>
                </gmd:description>
                <gmd:function>
                  <xsl:call-template name="writeCodelist">
                    <xsl:with-param name="codeListName" select="'gmd:CI_OnLineFunctionCode'"/>
                    <xsl:with-param name="codeListValue" select="'download'"/>
                  </xsl:call-template>
                </gmd:function>
              </gmd:CI_OnlineResource>
            </srv:connectPoint>
            <!--<srv:connectPoint>
            <gmd:CI_OnlineResource>
              <gmd:linkage>
                <gmd:URL>
                  <xsl:value-of select="ows:DCP/ows:HTTP/ows:Get/@xlink:href"/>
                  <xsl:choose>
                    <xsl:when test="contains(ows:DCP/ows:HTTP/ows:Get/@xlink:href,'?')">
                      <xsl:value-of select="concat(ows:DCP/ows:HTTP/ows:Get/@xlink:href, 'service=SOS&amp;request=GetCapabilities&amp;acceptVersions=1.0.0')"/>
                    </xsl:when>
                    <xsl:when test="not(contains(ows:DCP/ows:HTTP/ows:Get/@xlink:href,'?'))">
                      <xsl:value-of select="concat(ows:DCP/ows:HTTP/ows:Get/@xlink:href, '?service=SOS&amp;request=GetCapabilities&amp;acceptVersions=1.0.0')"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="ows:DCP/ows:HTTP/ows:Get/@xlink:href"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </gmd:URL>
              </gmd:linkage>
              <gmd:protocol>
                <gco:CharacterString>
                  <xsl:value-of select="'http'"/>
                </gco:CharacterString>
              </gmd:protocol>
              <gmd:description>
                <xsl:call-template name="writeCharacterString">
                  <xsl:with-param name="stringToWrite" select="'OGC Sensor Observation Service Capabilities (Get)'"/>
                </xsl:call-template>
              </gmd:description>
              <gmd:function>
                <xsl:call-template name="writeCodelist">
                  <xsl:with-param name="codeListName" select="'gmd:CI_OnLineFunctionCode'"/>
                  <xsl:with-param name="codeListValue" select="'download'"/>
                </xsl:call-template>
              </gmd:function>
            </gmd:CI_OnlineResource>
          </srv:connectPoint>--></xsl:for-each>
        </xsl:if>
      </srv:SV_OperationMetadata>
    </srv:containsOperations>
  </xsl:template>
</xsl:stylesheet>
