<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" version="1.0" xmlns:gmi="http://www.isotc211.org/2005/gmi" xmlns:gco="http://www.isotc211.org/2005/gco" xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gml="http://www.opengis.net/gml" xmlns:gts="http://www.isotc211.org/2005/gts" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xlink="http://www.w3.org/1999/xlink" xsi:schemaLocation="http://www.isotc211.org/2005/gmi">
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p><xd:b>Created on:</xd:b> Sep 30, 2010</xd:p>
			<xd:p><xd:b>Author:</xd:b> amilan</xd:p>
			<xd:p>Purpose is to present a brief HTML View of ISO 19115/19115-2 metadata</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:include href="displayElement.xsl"/>	
	<!-- HTML -->
	<xsl:template match="/">
		<html xmlns="http://www.w3.org/1999/xhtml">
			<head>
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
				<title>HTML Brief view of ISO 19115 and 19115-2</title>
				<style type="text/css">
					table.mainTable {
						width:100%;
						border-style: none;
						vertical-align:top;
					}
					table.mainTable th {
						border-style: none;
						padding: 5px 5px 5px 5px;
						font-weight: bold;
						vertical-align: top;
						text-align: left;
					}
					table.mainTable td {
						border-style: none;
						padding: 5px 5px 5px 5px;
						vertical-align:top;
					}
					table.subTable {
						width:100%;
						border-style: none;
						vertical-align:top;
					}
					table.subTable th {
						border-style: none;
						padding: 5px 5px 5px 5px;
						font-weight: bold;
						vertical-align: top;
						text-align: left;
					}
					table.subTable td {
						border-style: solid;
						border-width:1px;
						padding: 5px 5px 5px 5px;
						vertical-align:middle;
						width: 20%;
					}
					ul {
						list-style: circle inside;
						padding: 0;
						margin: 0;
					}
					dt {
						font-weight: bold;
					}</style>
			</head>
			<body>
				<table class="mainTable">
					<tr>
						<td>
							<table>
								<tr>
									<th colspan="2" align="left">
										<font size="+3">
											<xsl:for-each select="//gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title">
												<xsl:call-template name="displayElement"/>
											</xsl:for-each>
										</font>
									</th>
								</tr>
								<xsl:choose>
									<xsl:when test="//gmd:MD_BrowseGraphic/gmd:fileName">
										<tr>
											<td valign="top" align="left">
												<a href="{//gmd:MD_BrowseGraphic/gmd:fileName/gco:CharacterString}">
													<img alt="browse graphic" style="width: 300px; float: right; border: 0px" src="{//gmd:MD_BrowseGraphic/gmd:fileName/gco:CharacterString}"/>
												</a>
											</td>
											<td valign="top" align="left">
												<xsl:for-each select="//gmd:MD_DataIdentification/gmd:abstract">
													<xsl:call-template name="displayElement"/>
												</xsl:for-each>
											</td>
										</tr>
									</xsl:when>
									<xsl:otherwise>
										<tr>
											<td colspan="2">
												<xsl:for-each select="//gmd:MD_DataIdentification/gmd:abstract">
													<xsl:call-template name="displayElement"/>
												</xsl:for-each>
											</td>
										</tr>
									</xsl:otherwise>
								</xsl:choose>
							</table>
							<br/>
							<table class="subTable">
								<tr>
									<th colspan="4" align="center">
										<font size="+3">Get the Data</font>
									</th>
								</tr>
								<tr>
									<font size="+2">
										<th>Format</th>
										<th>Access</th>
										<th>Instructions</th>
										<th>Distributor</th>
									</font>
								</tr>
								<xsl:choose>
									<xsl:when test="//gmd:distributionInfo">
										<xsl:for-each select="//gmd:distributor">
											<tr>
												<td>
													<xsl:for-each select=".//gmd:distributorFormat//gmd:MD_Format">
														<xsl:for-each select="gmd:name">
															<xsl:call-template name="displayElement"/>
														</xsl:for-each>
														<br/>
														<xsl:for-each select="gmd:version">
															<xsl:call-template name="displayElement"/>
														</xsl:for-each>
													</xsl:for-each>
												</td>
												<td>
													<xsl:for-each select=".//gmd:CI_OnlineResource">
														<xsl:call-template name="listElements_onlineResource"/>
														<xsl:for-each select="gmd:function">
															<i>
																<xsl:call-template name="displayElement"/>
															</i>
														</xsl:for-each>
													</xsl:for-each>
												</td>
												<td>
													<xsl:for-each select="./gmd:MD_Distributor/gmd:distributionOrderProcess/gmd:MD_StandardOrderProcess/gmd:fees"> Fees: <xsl:call-template name="displayElement"/>
													</xsl:for-each>
													<br/>
													<xsl:for-each select="./gmd:MD_Distributor/gmd:distributionOrderProcess/gmd:MD_StandardOrderProcess/gmd:orderingInstructions"> Ordering Instructions: <xsl:call-template name="displayElement"/>
													</xsl:for-each>
												</td>
												<td>
													<xsl:for-each select="gmd:MD_Distributor/gmd:distributorContact">
														<xsl:call-template name="listElements_CI_ResponsibleParty"/>
													</xsl:for-each>
												</td>
											</tr>
										</xsl:for-each>
									</xsl:when>
									<xsl:otherwise>Distribution information is not documented.</xsl:otherwise>
								</xsl:choose>
							</table>
						</td>
					</tr>
				</table>
				<br/>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="listElements_onlineResource">
		<a>
			<xsl:attribute name="href">
				<xsl:for-each select="gmd:linkage/gmd:URL">
					<xsl:call-template name="displayElement"/>
				</xsl:for-each>
			</xsl:attribute>
			<xsl:choose>
				<xsl:when test="gmd:name">
					<xsl:for-each select="gmd:name">
						<xsl:call-template name="displayElement"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<xsl:for-each select="gmd:linkage/gmd:URL">
						<xsl:call-template name="displayElement"/>
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
		</a>
		<br/>
		<xsl:for-each select="gmd:description/gco:CharacterString">
			<xsl:call-template name="displayElement"/>
		</xsl:for-each>
		<br/>
	</xsl:template>
	<xsl:template name="listElements_CI_ResponsibleParty">
		<xsl:choose>
			<xsl:when test=".//gmd:electronicMailAddress">
				<xsl:variable name="email">
					<xsl:value-of select=".//gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress"/>
				</xsl:variable>
				<a>
					<xsl:attribute name="href">
						<xsl:value-of select="concat('mailto:',$email)"/>
					</xsl:attribute>
					<xsl:choose>
						<xsl:when test=".//gmd:individualName">
							<xsl:for-each select=".//gmd:individualName">
								<xsl:call-template name="displayElement"/>
							</xsl:for-each>
						</xsl:when>
						<xsl:when test=".//gmd:organisationName">
							<xsl:for-each select=".//gmd:organisationName">
								<xsl:call-template name="displayElement"/>
							</xsl:for-each>
						</xsl:when>
						<xsl:when test=".//gmd:positionName">
							<xsl:for-each select=".//gmd:positionName">
								<xsl:call-template name="displayElement"/>
							</xsl:for-each>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$email"/>
						</xsl:otherwise>
					</xsl:choose>
				</a>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="gmd:individualName">
						<xsl:for-each select="gmd:individualName">
							<br/>
							<xsl:call-template name="displayElement"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="gmd:organisationName">
						<xsl:for-each select="gmd:organisationName">
							<br/>
							<xsl:call-template name="displayElement"/>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="gmd:positionName">
						<xsl:for-each select="gmd:positionName">
							<br/>
							<xsl:call-template name="displayElement"/>
						</xsl:for-each>
					</xsl:when>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
			<xsl:for-each select=".//gmd:organisationName">
				<br/>
					<xsl:call-template name="displayElement"/>
			</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
