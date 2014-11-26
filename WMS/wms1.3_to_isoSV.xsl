<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:default="http://www.opengis.net/wms" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:srv="http://www.isotc211.org/2005/srv" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.opengis.net/wms http://schemas.opengis.net/wms/1.3.0/capabilities_1_3_0.xsd">
    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Last Update: May 16, 2014. Anna.Milan@noaa.gov</xd:b></xd:p>
            <xd:p><xd:b>Created on:</xd:b> Feb 9, 2010</xd:p>
            <xd:p><xd:b>Updated:</xd:b> Apr 12, 2013</xd:p>
            <xd:p><xd:b>Author:</xd:b> john.kozimor@noaa.gov</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="default:WMS_Capabilities|WMT_MS_Capabilities|WMS_Capabilities">
        <xsl:variable name="wmsVersion" select="/default:WMS_Capabilities/@version|/WMT_MS_Capabilities/@version"/>
        <xsl:variable name="stylesheetVersion" select="1.2"/>
        <xsl:variable name="Name" select="/default:WMS_Capabilities/default:Service/default:Name|/WMT_MS_Capabilities/Service/Name"/>
        <xsl:variable name="Title" select="/default:WMS_Capabilities/default:Service/default:Title|/WMT_MS_Capabilities/Service/Title"/>
        <xsl:variable name="Abstract" select="/default:WMS_Capabilities/default:Service/default:Abstract|/WMT_MS_Capabilities/Service/Abstract"/>
        <xsl:variable name="KeywordList" select="/default:WMS_Capabilities/default:Service/default:KeywordList|/WMT_MS_Capabilities/Service/KeywordList"/>
        <xsl:variable name="OnlineResource" select="/default:WMS_Capabilities/default:Service/default:OnlineResource|/WMT_MS_Capabilities/Service/OnlineResource"/>
        <xsl:variable name="ContactPerson" select="/default:WMS_Capabilities/default:Service/default:ContactInformation/default:ContactPersonPrimary/default:ContactPerson|/WMT_MS_Capabilities/Service/ContactInformation/ContactPersonPrimary/ContactPerson"/>
        <xsl:variable name="ContactOrganization" select="/default:WMS_Capabilities/default:Service/default:ContactInformation/default:ContactPersonPrimary/default:ContactOrganization|/WMT_MS_Capabilities/Service/ContactInformation/ContactPersonPrimary/ContactOrganization"/>
        <xsl:variable name="ContactPosition" select="/default:WMS_Capabilities/default:Service[1]/default:ContactInformation[1]/default:ContactPosition[1]|/WMT_MS_Capabilities/Service[1]/ContactInformation[1]/ContactPosition[1]"/>
        <xsl:variable name="ContactAddress" select="/default:WMS_Capabilities/default:Service[1]/default:ContactInformation[1]/default:ContactAddress[1]|WMT_MS_Capabilities/Service[1]/ContactInformation[1]/ContactAddress[1]"/>
        <xsl:variable name="ContactAddressAddress" select="/default:WMS_Capabilities/default:Service[1]/default:ContactInformation[1]/default:ContactAddress[1]/default:Address|WMT_MS_Capabilities/Service[1]/ContactInformation[1]/ContactAddress[1]/Address"/>
        <xsl:variable name="ContactAddressCity" select="/default:WMS_Capabilities/default:Service[1]/default:ContactInformation[1]/default:ContactAddress[1]/default:City|WMT_MS_Capabilities/Service[1]/ContactInformation[1]/ContactAddress[1]/City"/>
        <xsl:variable name="ContactAddressStateOrProvince" select="/default:WMS_Capabilities/default:Service[1]/default:ContactInformation[1]/default:ContactAddress[1]/default:StateOrProvince|WMT_MS_Capabilities/Service[1]/ContactInformation[1]/ContactAddress[1]/StateOrProvince"/>
        <xsl:variable name="ContactAddressPostCode" select="/default:WMS_Capabilities/default:Service[1]/default:ContactInformation[1]/default:ContactAddress[1]/default:PostCode|WMT_MS_Capabilities/Service[1]/ContactInformation[1]/ContactAddress[1]/PostCode"/>
        <xsl:variable name="ContactAddressCountry" select="/default:WMS_Capabilities/default:Service[1]/default:ContactInformation[1]/default:ContactAddress[1]/default:Country|WMT_MS_Capabilities/Service[1]/ContactInformation[1]/ContactAddress[1]/Country"/>
        <xsl:variable name="ContactVoiceTelephone" select="/default:WMS_Capabilities/default:Service[1]/default:ContactInformation[1]/default:ContactVoiceTelephone[1]|/WMT_MS_Capabilities/Service[1]/ContactInformation[1]/ContactVoiceTelephone[1]"/>
        <xsl:variable name="ContactFacsimileTelephone" select="/default:WMS_Capabilities/default:Service[1]/default:ContactInformation[1]/default:ContactFacsimileTelephone[1]|/WMT_MS_Capabilities/Service[1]/ContactInformation[1]/ContactFacsimileTelephone[1]"/>
        <xsl:variable name="ContactElectronicMailAddress" select="/default:WMS_Capabilities/default:Service[1]/default:ContactInformation[1]/default:ContactElectronicMailAddress[1]|/WMT_MS_Capabilities/Service[1]/ContactInformation[1]/ContactElectronicMailAddress[1]"/>
        <xsl:variable name="GetCapabilitiesFormat" select="/default:WMS_Capabilities/default:Capability/default:Request/default:GetCapabilities/default:Format|/WMT_MS_Capabilities/Capability/Request/GetCapabilities/Format"/>
        <xsl:variable name="GetMapFormat" select="/default:WMS_Capabilities/default:Capability/default:Request/default:GetMap/default:Format|/WMT_MS_Capabilities/Capability/Request/GetMap/Format"/>
        <xsl:variable name="GetFeatureInfoFormat" select="/default:WMS_Capabilities/default:Capability/default:Request/default:GetFeatureInfo/default:Format|/WMT_MS_Capabilities/Capability/Request/GetFeatureInfo/Format"/>
        <xsl:variable name="Fees" select="/default:WMS_Capabilities/default:Service[1]/default:Fees[1]|/WMT_MS_Capabilities/Service[1]/Fees[1]"/>
        <xsl:variable name="AccessConstraints" select="/default:WMS_Capabilities/default:Service[1]/default:AccessConstraints[1]|/WMT_MS_Capabilities/Service[1]/AccessConstraints[1]"/>
        <!-- $MaxWidth and $MaxHeight not used in ISO output -->
        <xsl:variable name="MaxWidth" select="/default:WMS_Capabilities/default:Service[1]/default:MaxWidth[1]|/WMT_MS_Capabilities/Service[1]/MaxWidth[1]"/>
        <xsl:variable name="MaxHeight" select="/default:WMS_Capabilities/default:Service[1]/default:MaxHeight[1]|/WMT_MS_Capabilities/Service[1]/MaxHeight[1]"/>
        <!-- *** -->
        <xsl:variable name="GeographicBoundingBox" select="/default:WMS_Capabilities[1]/default:Capability[1]/default:Layer[1]/default:EX_GeographicBoundingBox[1]|/WMT_MS_Capabilities[1]/Capability[1]/Layer[1]/EX_GeographicBoundingBox[1]"/>
        <xsl:variable name="GeographicBoundingBoxTitle" select="/default:WMS_Capabilities[1]/default:Capability[1]/default:Layer[1]/default:Title[1]|/WMT_MS_Capabilities[1]/Capability[1]/Layer[1]/Layer[1]/Title[1]"/>
        <xsl:variable name="westBoundLongitude" select="/default:WMS_Capabilities/default:Capability[1]/default:Layer[1]/default:EX_GeographicBoundingBox[1]/default:westBoundLongitude[1]|/WMT_MS_Capabilities/Capability[1]/Layer[1]/EX_GeographicBoundingBox[1]/westBoundLongitude[1]"/>
        <xsl:variable name="eastBoundLongitude" select="/default:WMS_Capabilities/default:Capability[1]/default:Layer[1]/default:EX_GeographicBoundingBox[1]/default:eastBoundLongitude[1]|/WMT_MS_Capabilities/Capability[1]/Layer[1]/Layer[1]/EX_GeographicBoundingBox[1]/eastBoundLongitude[1]"/>
        <xsl:variable name="southBoundLongitude" select="/default:WMS_Capabilities/default:Capability[1]/default:Layer[1]/default:EX_GeographicBoundingBox[1]/ default:southBoundLatitude[1]|/WMT_MS_Capabilities/Capability[1]/Layer[1]/EX_GeographicBoundingBox[1]/southBoundLatitude[1]"/>
        <xsl:variable name="northBoundLongitude" select="/default:WMS_Capabilities/default:Capability[1]/default:Layer[1]/default:EX_GeographicBoundingBox[1]/default:northBoundLatitude[1]|/WMT_MS_Capabilities/Capability[1]/Layer[1]/Layer[1]/EX_GeographicBoundingBox[1]/northBoundLatitude[1]"/>
        <!-- $DCPType not used in ISO output directly -->
        <xsl:variable name="DCPType" select="/default:WMS_Capabilities/default:Capability/default:Request/default:GetCapabilities|/default:WMS_Capabilities/default:Capability/default:Request/default:GetCapabilities/default:DCPType/default:HTTP/default:Get/default:OnlineResource/@xlink:href|/WMT_MS_Capabilities/Capability/Request/GetCapabilities/DCPType/HTTP/Get/OnlineResource/@xlink:href"/>
        <xsl:variable name="GetCapabilities" select="/default:WMS_Capabilities/default:Capability/default:Request/default:GetCapabilities|/WMT_MS_Capabilities/Capability/Request/GetCapabilities"/>
        <xsl:variable name="GetCapabilitiesGet" select="/default:WMS_Capabilities/default:Capability/default:Request/default:GetCapabilities/default:DCPType/default:HTTP/default:Get/default:OnlineResource|/WMT_MS_Capabilities/Capability/Request/GetCapabilities/DCPType/HTTP/Get/OnlineResource"/>
        <xsl:variable name="GetCapabilitiesPost" select="/default:WMS_Capabilities/default:Capability/default:Request/default:GetCapabilities/default:DCPType/default:HTTP/default:Post/default:OnlineResource|/WMT_MS_Capabilities/Capability/Request/GetCapabilities/DCPType/HTTP/Post/OnlineResource"/>
        <xsl:variable name="GetMapOLR" select="/default:WMS_Capabilities/default:Capability/default:Request/default:GetMap/default:DCPType/default:HTTP/default:Get/default:OnlineResource|/WMT_MS_Capabilities/Capability/Request/GetMap/DCPType/HTTP/Get/OnlineResource"/>
        <xsl:variable name="GetFeatureInfoOLR" select="/default:WMS_Capabilities/default:Capability/default:Request/default:GetFeatureInfo/default:DCPType/default:HTTP/default:Get/default:OnlineResource|/WMT_MS_Capabilities/Capability/Request/GetFeatureInfo/DCPType/HTTP/Get/OnlineResource"/>
        <xsl:variable name="CRS" select="/default:WMS_Capabilities/default:Capability/default:Layer/default:CRS|/WMT_MS_Capabilities/Capability/Layer/CRS"/>

        <gmi:MI_Metadata xmlns:gmi="http://www.isotc211.org/2005/gmi" xmlns:gco="http://www.isotc211.org/2005/gco" xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:gts="http://www.isotc211.org/2005/gts" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:srv="http://www.isotc211.org/2005/srv" xsi:schemaLocation="http://www.isotc211.org/2005/gmi http://www.ngdc.noaa.gov/metadata/published/xsd/schema.xsd">
            <gmd:fileIdentifier>
                <gco:CharacterString>
                    <xsl:value-of select="substring-before(base-uri(),'.xml')"/>
                </gco:CharacterString>
            </gmd:fileIdentifier>
            <gmd:characterSet>
                <gmd:MD_CharacterSetCode codeList="http://www.ngdc.noaa.gov/metadata/published/xsd/schema/resources/Codelist/gmxCodelists.xml#MD_CharacterSetCode" codeListValue="utf8">utf8</gmd:MD_CharacterSetCode>
            </gmd:characterSet>
            <gmd:contact gco:nilReason="inapplicable"/>
            <gmd:dateStamp>
                <gco:Date>
                    <xsl:value-of select="adjust-date-to-timezone(current-date(),Z)"/>
                </gco:Date>
            </gmd:dateStamp>
            <gmd:metadataStandardName>
                <gco:CharacterString>ISO 19115-2 Geographic Information - Metadata Part 2 Extensions for imagery and gridded data</gco:CharacterString>
            </gmd:metadataStandardName>
            <gmd:metadataStandardVersion>
                <gco:CharacterString>ISO 19115-2:2009(E)</gco:CharacterString>
            </gmd:metadataStandardVersion>
            <xsl:for-each select="$CRS">
                <gmd:referenceSystemInfo>
                    <gmd:MD_ReferenceSystem>
                        <gmd:referenceSystemIdentifier><gmd:RS_Identifier>
                            <gmd:code><gco:CharacterString><xsl:value-of select="normalize-space(.)"/></gco:CharacterString></gmd:code>
                        </gmd:RS_Identifier></gmd:referenceSystemIdentifier>
                    </gmd:MD_ReferenceSystem>
                </gmd:referenceSystemInfo>
            </xsl:for-each>
            <gmd:identificationInfo>
                <srv:SV_ServiceIdentification>
                    <gmd:citation>
                        <gmd:CI_Citation>
                            <gmd:title>
                                <gco:CharacterString>
                                    <xsl:value-of select="$Title"/>
                                </gco:CharacterString>
                            </gmd:title>
                            <gmd:date gco:nilReason="unknown"/>
                            <xsl:if test="$OnlineResource">
                                <gmd:citedResponsibleParty>
                                    <gmd:CI_ResponsibleParty>
                                        <gmd:contactInfo>
                                            <gmd:CI_Contact>
                                                <gmd:onlineResource>
                                                    <gmd:CI_OnlineResource>
                                                        <gmd:linkage>
                                                            <gmd:URL>
                                                                <xsl:value-of select="$OnlineResource/@xlink:href"/>
                                                            </gmd:URL>
                                                        </gmd:linkage>
                                                    </gmd:CI_OnlineResource>
                                                </gmd:onlineResource>
                                            </gmd:CI_Contact>
                                        </gmd:contactInfo>
                                        <gmd:role/>
                                    </gmd:CI_ResponsibleParty>
                                </gmd:citedResponsibleParty>
                            </xsl:if>
                        </gmd:CI_Citation>
                    </gmd:citation>
                    <gmd:abstract>
                        <gco:CharacterString>
                            <xsl:value-of select="$Abstract"/>
                        </gco:CharacterString>
                    </gmd:abstract>
                    <gmd:pointOfContact>
                        <gmd:CI_ResponsibleParty>
                            <xsl:if test="$ContactPerson">
                                <gmd:individualName>
                                    <gco:CharacterString>
                                        <xsl:value-of select="$ContactPerson"/>
                                    </gco:CharacterString>
                                </gmd:individualName>
                            </xsl:if>
                            <xsl:if test="$ContactOrganization">
                                <gmd:organisationName>
                                    <gco:CharacterString>
                                        <xsl:value-of select="$ContactOrganization"/>
                                    </gco:CharacterString>
                                </gmd:organisationName>
                            </xsl:if>
                            <xsl:if test="normalize-space($ContactPosition)">
                                <gmd:positionName>
                                    <gco:CharacterString>
                                        <xsl:value-of select="$ContactPosition"/>
                                    </gco:CharacterString>
                                </gmd:positionName>
                            </xsl:if>
                            <xsl:if test="normalize-space($ContactVoiceTelephone) or normalize-space($ContactAddress)">
                                <gmd:contactInfo>
                                    <gmd:CI_Contact>
                                        <xsl:if test="normalize-space($ContactVoiceTelephone)">
                                            <gmd:phone>
                                                <gmd:CI_Telephone>
                                                    <gmd:voice>
                                                        <gco:CharacterString>
                                                            <xsl:value-of select="$ContactVoiceTelephone"/>
                                                        </gco:CharacterString>
                                                    </gmd:voice>
                                                    <xsl:if test="normalize-space($ContactFacsimileTelephone)">
                                                        <gmd:facsimile>
                                                            <gco:CharacterString>
                                                                <xsl:value-of select="$ContactFacsimileTelephone"/>
                                                            </gco:CharacterString>
                                                        </gmd:facsimile>
                                                    </xsl:if>
                                                </gmd:CI_Telephone>
                                            </gmd:phone>
                                        </xsl:if>
                                        <xsl:if test="normalize-space($ContactAddress)">
                                            <gmd:address>
                                                <gmd:CI_Address>
                                                    <xsl:if test="normalize-space($ContactAddressAddress)">
                                                        <gmd:deliveryPoint>
                                                            <gco:CharacterString>
                                                                <xsl:value-of select="$ContactAddressAddress"/>
                                                            </gco:CharacterString>
                                                        </gmd:deliveryPoint>
                                                    </xsl:if>
                                                    <xsl:if test="normalize-space($ContactAddressCity)">
                                                        <gmd:city>
                                                            <gco:CharacterString>
                                                                <xsl:value-of select="$ContactAddressCity"/>
                                                            </gco:CharacterString>
                                                        </gmd:city>
                                                    </xsl:if>
                                                    <xsl:if test="normalize-space($ContactAddressStateOrProvince)">
                                                        <gmd:administrativeArea>
                                                            <gco:CharacterString>
                                                                <xsl:value-of select="$ContactAddressStateOrProvince"/>
                                                            </gco:CharacterString>
                                                        </gmd:administrativeArea>
                                                    </xsl:if>
                                                    <xsl:if test="$ContactAddressPostCode">
                                                        <gmd:postalCode>
                                                            <gco:CharacterString>
                                                                <xsl:value-of select="$ContactAddressPostCode"/>
                                                            </gco:CharacterString>
                                                        </gmd:postalCode>
                                                    </xsl:if>
                                                    <xsl:if test="$ContactAddressCountry">
                                                        <gmd:country>
                                                            <gco:CharacterString>
                                                                <xsl:value-of select="$ContactAddressCountry"/>
                                                            </gco:CharacterString>
                                                        </gmd:country>
                                                    </xsl:if>
                                                    <xsl:if test="$ContactElectronicMailAddress">
                                                        <gmd:electronicMailAddress>
                                                            <gco:CharacterString>
                                                                <xsl:value-of select="$ContactElectronicMailAddress"/>
                                                            </gco:CharacterString>
                                                        </gmd:electronicMailAddress>
                                                    </xsl:if>
                                                </gmd:CI_Address>
                                            </gmd:address>
                                        </xsl:if>
                                    </gmd:CI_Contact>
                                </gmd:contactInfo>
                            </xsl:if>
                            <gmd:role>
                                <gmd:CI_RoleCode codeList="http://www.ngdc.noaa.gov/metadata/published/xsd/schema/resources/Codelist/gmxCodelists.xml#CI_RoleCode" codeListValue="pointOfContact">pointOfContact</gmd:CI_RoleCode>
                            </gmd:role>
                        </gmd:CI_ResponsibleParty>
                    </gmd:pointOfContact>
                    <xsl:for-each select="normalize-space($GetCapabilitiesFormat)">
                        <gmd:resourceFormat>
                            <gmd:MD_Format>
                                <gmd:name>
                                    <gco:CharacterString>
                                        <xsl:value-of select="normalize-space(.)"/>
                                    </gco:CharacterString>
                                </gmd:name>
                                <gmd:version gco:nilReason="unknown"/>
                                <gmd:specification>
                                    <gco:CharacterString>GetCapabilities</gco:CharacterString>
                                </gmd:specification>
                            </gmd:MD_Format>
                        </gmd:resourceFormat>
                    </xsl:for-each>
                    <xsl:for-each select="$GetMapFormat">
                        <gmd:resourceFormat>
                            <gmd:MD_Format>
                                <gmd:name>
                                    <gco:CharacterString>
                                        <xsl:value-of select="normalize-space(.)"/>
                                    </gco:CharacterString>
                                </gmd:name>
                                <gmd:version gco:nilReason="unknown"/>
                                <gmd:specification>
                                    <gco:CharacterString>GetMap</gco:CharacterString>
                                </gmd:specification>
                            </gmd:MD_Format>
                        </gmd:resourceFormat>
                    </xsl:for-each>
                    <xsl:for-each select="$GetFeatureInfoFormat">
                        <gmd:resourceFormat>
                            <gmd:MD_Format>
                                <gmd:name>
                                    <gco:CharacterString>
                                        <xsl:value-of select="normalize-space(.)"/>
                                    </gco:CharacterString>
                                </gmd:name>
                                <gmd:version gco:nilReason="unknown"/>
                                <gmd:specification>
                                    <gco:CharacterString>GetFeatureInfo</gco:CharacterString>
                                </gmd:specification>
                            </gmd:MD_Format>
                        </gmd:resourceFormat>
                    </xsl:for-each>
                    <srv:serviceType>
                        <gco:LocalName>Open Geospatial Consortium Web Map Service (WMS)</gco:LocalName>
                    </srv:serviceType>
                    <srv:serviceTypeVersion>
                        <gco:CharacterString>
                            <xsl:value-of select="normalize-space($wmsVersion)"/>
                        </gco:CharacterString>
                    </srv:serviceTypeVersion>
                    <xsl:if test="normalize-space($Fees)">
                        <srv:accessProperties>
                            <gmd:MD_StandardOrderProcess>
                                <gmd:fees>
                                    <gco:CharacterString>
                                        <xsl:value-of select="normalize-space($Fees)"/>
                                    </gco:CharacterString>
                                </gmd:fees>
                            </gmd:MD_StandardOrderProcess>
                        </srv:accessProperties>
                    </xsl:if>
                    <xsl:if test="normalize-space($AccessConstraints)">
                        <srv:restrictions>
                            <gmd:MD_Constraints>
                                <gmd:useLimitation>
                                    <gco:CharacterString>
                                        <xsl:value-of select="normalize-space($AccessConstraints)"/>
                                    </gco:CharacterString>
                                </gmd:useLimitation>
                            </gmd:MD_Constraints>
                        </srv:restrictions>
                    </xsl:if>
                    <xsl:if test="normalize-space($KeywordList)">
                        <srv:keywords>
                            <gmd:MD_Keywords>
                                <xsl:for-each select="$KeywordList/default:Keyword|$KeywordList/Keyword">
                                    <gmd:keyword>
                                        <gco:CharacterString>
                                            <xsl:value-of select="normalize-space(.)"/>
                                        </gco:CharacterString>
                                    </gmd:keyword>
                                </xsl:for-each>
                            </gmd:MD_Keywords>
                        </srv:keywords>
                    </xsl:if>
                    <srv:keywords xlink:href="http://www.ngdc.noaa.gov/docucomp/e2aebfb3-4008-4baa-812a-f7abb1c46c4a" xlink:title="Service Keywords"/>
                    <xsl:if test="$GeographicBoundingBox">
                        <srv:extent>
                            <gmd:EX_Extent>
                                <xsl:if test="normalize-space($GeographicBoundingBoxTitle)">
                                    <gmd:description>
                                        <gco:CharacterString>
                                            <xsl:value-of select="normalize-space($GeographicBoundingBoxTitle)"/>
                                        </gco:CharacterString>
                                    </gmd:description>
                                </xsl:if>
                                <gmd:geographicElement>

                                    <gmd:EX_GeographicBoundingBox>
                                        <gmd:westBoundLongitude>
                                            <gco:Decimal>
                                                <xsl:value-of select="$westBoundLongitude"/>
                                            </gco:Decimal>
                                        </gmd:westBoundLongitude>
                                        <gmd:eastBoundLongitude>
                                            <gco:Decimal>
                                                <xsl:value-of select="$eastBoundLongitude"/>
                                            </gco:Decimal>
                                        </gmd:eastBoundLongitude>
                                        <gmd:southBoundLatitude>
                                            <gco:Decimal>
                                                <xsl:value-of select="$southBoundLongitude"/>
                                            </gco:Decimal>
                                        </gmd:southBoundLatitude>
                                        <gmd:northBoundLatitude>
                                            <gco:Decimal>
                                                <xsl:value-of select="$northBoundLongitude"/>
                                            </gco:Decimal>
                                        </gmd:northBoundLatitude>
                                    </gmd:EX_GeographicBoundingBox>
                                </gmd:geographicElement>
                            </gmd:EX_Extent>
                        </srv:extent>
                    </xsl:if>
                    <srv:couplingType>
                        <srv:SV_CouplingType codeList="http://www.tc211.org/ISO19139/resources/codeList.xml#SV_CouplingType" codeListValue="tight">tight</srv:SV_CouplingType>
                    </srv:couplingType>
                    <xsl:if test="$GetCapabilities">
                        <srv:containsOperations>
                            <srv:SV_OperationMetadata>
                                <srv:operationName>
                                    <gco:CharacterString>GetCapabilities</gco:CharacterString>
                                </srv:operationName>
                                <srv:DCP/>
                                <xsl:if test="$GetCapabilitiesGet">
                                    <srv:connectPoint>
                                        <gmd:CI_OnlineResource>
                                            <gmd:linkage>
                                                <gmd:URL>
                                                    <xsl:value-of select="$GetCapabilitiesGet/@xlink:href"/>
                                                </gmd:URL>
                                            </gmd:linkage>
                                            <gmd:description>
                                                <gco:CharacterString>Get Request</gco:CharacterString>
                                            </gmd:description>
                                        </gmd:CI_OnlineResource>
                                    </srv:connectPoint>
                                </xsl:if>
                                <xsl:if test="$GetCapabilitiesPost">
                                    <srv:connectPoint>
                                        <gmd:CI_OnlineResource>
                                            <gmd:linkage>
                                                <gmd:URL>
                                                    <xsl:value-of select="$GetCapabilitiesPost/@xlink:href"/>
                                                </gmd:URL>
                                            </gmd:linkage>
                                            <gmd:description>
                                                <gco:CharacterString>Post Request</gco:CharacterString>
                                            </gmd:description>
                                        </gmd:CI_OnlineResource>
                                    </srv:connectPoint>
                                </xsl:if>
                            </srv:SV_OperationMetadata>
                        </srv:containsOperations>
                    </xsl:if>
                    <xsl:if test="$GetMapOLR">
                        <srv:containsOperations>
                            <srv:SV_OperationMetadata>
                                <srv:operationName>
                                    <gco:CharacterString>GetMap</gco:CharacterString>
                                </srv:operationName>
                                <srv:DCP/>
                                <srv:connectPoint>
                                    <gmd:CI_OnlineResource>
                                        <gmd:linkage>
                                            <gmd:URL>
                                                <xsl:value-of select="$GetMapOLR/@xlink:href"/>
                                            </gmd:URL>
                                        </gmd:linkage>
                                    </gmd:CI_OnlineResource>
                                </srv:connectPoint>
                            </srv:SV_OperationMetadata>
                        </srv:containsOperations>
                    </xsl:if>
                    <xsl:if test="$GetFeatureInfoOLR">
                        <srv:containsOperations>
                            <srv:SV_OperationMetadata>
                                <srv:operationName>
                                    <gco:CharacterString>GetFeatureInfo</gco:CharacterString>
                                </srv:operationName>
                                <srv:DCP/>
                                <srv:connectPoint>
                                    <gmd:CI_OnlineResource>
                                        <gmd:linkage>
                                            <gmd:URL>
                                                <xsl:value-of select="$GetFeatureInfoOLR/@xlink:href"/>
                                            </gmd:URL>
                                        </gmd:linkage>
                                    </gmd:CI_OnlineResource>
                                </srv:connectPoint>
                            </srv:SV_OperationMetadata>
                        </srv:containsOperations>
                    </xsl:if>
                </srv:SV_ServiceIdentification>
            </gmd:identificationInfo>
            <gmd:metadataMaintenance>
                <gmd:MD_MaintenanceInformation>
                    <gmd:maintenanceAndUpdateFrequency>
                        <gmd:MD_MaintenanceFrequencyCode codeList="http://www.ngdc.noaa.gov/metadata/published/xsd/schema/resources/Codelist/gmxCodelists.xml#MD_MaintenanceFrequencyCode" codeListValue="asNeeded">asNeeded</gmd:MD_MaintenanceFrequencyCode>
                    </gmd:maintenanceAndUpdateFrequency>
                    <gmd:maintenanceNote>
                        <gco:CharacterString>This record was translated from WMS version <xsl:value-of select="$wmsVersion"/> on <xsl:value-of select="current-date()"/> using the wms2iso stylesheet version <xsl:value-of select="$stylesheetVersion"/>. Available at <xsl:value-of select="base-uri(document(''))"/>.</gco:CharacterString>
                    </gmd:maintenanceNote>
                </gmd:MD_MaintenanceInformation>
            </gmd:metadataMaintenance>
        </gmi:MI_Metadata>
    </xsl:template>
</xsl:stylesheet>

