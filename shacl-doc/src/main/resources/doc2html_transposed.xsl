<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<!-- Language parameter to the XSLT -->
	<xsl:param name="LANG">en</xsl:param>
	
	<!-- Indicates if we are producing the HTML for an HTML output of for a PDF conversion -->
	<xsl:param name="MODE">HTML</xsl:param>

	<!-- controls output style -->
	<!--
	<xsl:output indent="yes" method="xhtml" omit-xml-declaration="yes"/>
	 -->

	<!-- french labels -->
	<xsl:variable name="LABELS_FR">
		<labels>
			<entry key="TOC" label="Table des Matières" />
			<entry key="COLUMN_PROPERTY" label="Nom de la propriété" />
			<entry key="COLUMN_URI" label="URI" />
			<entry key="COLUMN_EXPECTED_VALUE" label="Valeur attendue" />
			<entry key="COLUMN_CARD" label="Card." />
			<entry key="COLUMN_DESCRIPTION" label="Description" />

			<entry key="PREFIXES.TITLE" label="Espaces de nom" />
			<entry key="PREFIXES.COLUMN.PREFIX" label="Préfixe" />
			<entry key="PREFIXES.COLUMN.URI" label="Espace de nom" />

			<entry key="METADATA.VERSION" label="Version : " />
			<entry key="METADATA.INTRODUCTION" label="Introduction" />
			<entry key="METADATA.DATECREATED" label="Date de création : " />
			<entry key="METADATA.DATE" label="Dernière modification : " />
			<entry key="METADATA.DATEISSUED" label="Date de publication : " />
			<entry key="METADATA.DATECOPYRIGHTED" label="Date de copyright : " />
			<entry key="METADATA.LICENSE" label="License : " />
			<entry key="METADATA.CREATOR" label="Auteur : " />
			<entry key="METADATA.PUBLISHER" label="Editeur : " />
			<entry key="METADATA.RIGHTHOLDER" label="Titulaire des droits : " />
			<entry key="METADATA.FEEDBACK" label="Feedback : " />
			
			<entry key="METADATA.FORMATS" label="Télécharger les données : " />

			<entry key="DIAGRAM.TITLE" label="Diagrammes" />

			<entry key="DIAGRAM.HELP"
				label="Cliquez sur le diagramme pour naviguer vers la section correspondante" />
			<entry key="DIAGRAM.VIEW" label="Voir le diagramme en PNG" />

			<entry key="DESCRIPTION.TITLE" label="Description"/>

			<entry key="LABEL_TARGETCLASS" label="Classe cible : " />
			<entry key="LABEL_NODEKIND" label="Type de noeud : " />
			<entry key="LABEL_PATTERNS" label="URIs : " />
			<entry key="LABEL_CLOSE" label="Shape fermée" />
			<entry key="LABEL_EXAMPLE" label="Exemple : "/>
			<entry key="LABEL_SUPERCLASSES" label="Hérite de : "/>
		</labels>
	</xsl:variable>

	<!-- English labels -->
	<xsl:variable name="LABELS_EN">
		<labels>
			<entry key="TOC" label="Table of Contents" />
			<entry key="COLUMN_PROPERTY" label="Property name" />
			<entry key="COLUMN_URI" label="URI" />
			<entry key="COLUMN_EXPECTED_VALUE" label="Expected value" />
			<entry key="COLUMN_CARD" label="Card." />
			<entry key="COLUMN_DESCRIPTION" label="Description" />
			<entry key="COLUMN_SKOSSCOPENOTE" label="Scope note" />
			<entry key="COLUMN_SKOSDEFINITION" label="Definition" />

			<entry key="PREFIXES.TITLE" label="Namespaces" />
			<entry key="PREFIXES.COLUMN.PREFIX" label="Prefix" />
			<entry key="PREFIXES.COLUMN.URI" label="Namespace" />

			<entry key="METADATA.DATE" label="Last updated: " />
			<entry key="METADATA.VERSION" label="Version: " />
			<entry key="METADATA.INTRODUCTION" label="Abstract" />
			<entry key="METADATA.DATECREATED" label="Creation date: " />
			<entry key="METADATA.DATEISSUED" label="Issue date: " />
			<entry key="METADATA.DATECOPYRIGHTED" label="Copyright date: " />
			<entry key="METADATA.LICENSE" label="License: " />
			<entry key="METADATA.CREATOR" label="Creator: " />
			<entry key="METADATA.PUBLISHER" label="Publisher: " />
			<entry key="METADATA.RIGHTHOLDER" label="Rightsholder: " />
			<entry key="METADATA.FEEDBACK" label="Feedback : " />
			
			<entry key="METADATA.FORMATS" label="Download serialization: " />
			
			<entry key="DIAGRAM.TITLE" label="Diagrams" />
			<entry key="DIAGRAM.HELP"
				label="Click diagram to navigate to corresponding section" />
			<entry key="DIAGRAM.VIEW" label="View as PNG" />
			
			<entry key="DESCRIPTION.TITLE" label="Description"/>

			<entry key="LABEL_TARGETCLASS" label="Target Class: " />
			<entry key="LABEL_NODEKIND" label="Nodes: " />
			<entry key="LABEL_PATTERNS" label="URI: " />
			<entry key="LABEL_CLOSE" label="Closed shape" />
			<entry key="LABEL_EXAMPLE" label="Example: "/>
			<entry key="LABEL_SUPERCLASSES" label="Inherits from: "/>
		</labels>
	</xsl:variable>


	<!-- Select labels based on language param -->
	<xsl:variable name="LABELS" select="if($LANG = 'fr') then $LABELS_FR else $LABELS_EN" />


	<!-- Principal -->
	<xsl:template match="/">
		<xsl:variable name="method">
			<xsl:choose>
				<xsl:when test="$MODE='PDF'">xhtml</xsl:when>
				<xsl:otherwise>html</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:result-document method="{$method}" omit-xml-declaration="yes" indent="yes" >
			<xsl:apply-templates />
		</xsl:result-document>
	</xsl:template>

	<xsl:template match="ShapesDocumentation">
		<!-- <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text> -->
		<!-- <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"&gt;</xsl:text>  -->
		<html lang="{$LANG}">
			<head>
				
				<meta charset="UTF-8"/>
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
				<meta name="lang" content="{$LANG}"/>
				<meta property="og:locale" content="{$LANG}"/>
				
				<xsl:variable name="var_title" select="title"/>
				<xsl:if test="$var_title != ''">
					<title><xsl:value-of select="$var_title"/></title>
					<meta name="apple-mobile-web-app-title" content="{$var_title}"/>
					<meta name="twitter:title" content="{$var_title}"/>
					<meta property="og:title" content="{$var_title}"/>
				</xsl:if>
												
			</head>
			<body>
				
				<div class="sp_container_principal container pt-4">
					
			        <xsl:choose>
			            	<xsl:when test="string-length(imgLogo) &gt; 0">
			            		<table style="width:100%">
				            		<tr>
				            			<td width="20%"><img src="{imgLogo}"/></td>
				            			<td width="80%"><h1 class="mb-4 sp_section_title_header"><xsl:value-of select="title" /></h1></td>		
				            		</tr>	
			            		</table>
			            	</xsl:when>
			            	<xsl:otherwise>
			            			<h1 class="mb-4 sp_section_title_header"><xsl:value-of select="title" /></h1>
			            	</xsl:otherwise>
			            </xsl:choose>			            
			         
					<div>
						<xsl:apply-templates select="datecreated" />
						<xsl:apply-templates select="dateissued" />
						<xsl:apply-templates select="modifiedDate" />
						<xsl:apply-templates select="yearCopyRighted" />
						<xsl:apply-templates select="versionInfo" />
						<xsl:apply-templates select="licenses" />
						<xsl:apply-templates select="creators" />
						<xsl:apply-templates select="publishers" />
						<xsl:apply-templates select="rightsHolders" />
						<xsl:apply-templates select="feedbacks" />
						<!-- section for the formats -->
						<xsl:if test="string-length(formats) &gt; 0">
							<xsl:apply-templates select="formats" />
						</xsl:if>
						<br/>						
					</div>					
					
					<xsl:apply-templates select="abstract_" />
					<xsl:apply-templates select="." mode="TOC" />
					<xsl:apply-templates select="prefixes" />
					<xsl:if test="diagrams or depictions">						
						<xsl:if test="string-length(diagrams) &gt; 0 ">
							<div class="sp_section_row mt-3">
								<div class="sp_section_col">
									<section>
										<h2 id="diagrams" class="sp_section_subtitle">
											<xsl:value-of select="$LABELS/labels/entry[@key='DIAGRAM.TITLE']/@label" />
										</h2>
										<xsl:apply-templates select="diagrams" />
										<xsl:apply-templates select="depictions"/>
									</section>
								</div>
							</div>	
						</xsl:if>						
					</xsl:if>
				
					<xsl:apply-templates select="descriptionDocument" />
					
					<xsl:apply-templates select="sections" />
				</div>
				
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="ShapesDocumentation" mode="TOC">
		<!-- Table de matieres -->
		<div class="sp_section_title_toc toc">
			<h2 id="Index"><xsl:value-of select="$LABELS/labels/entry[@key='TOC']/@label" /></h2>
			<ul role="list" class="sp_list_toc ul_type_none t-x-mode">
				<li>
					<!-- Prefixes -->
					<a href="#prefixes"><xsl:value-of select="$LABELS/labels/entry[@key='PREFIXES.TITLE']/@label" /></a>
				</li>
				<!-- Diagram -->
				<xsl:if test="string-length(diagrams) &gt; 0 or string-length(depictions) &gt; 0">
					
					<li>
						<a href="#diagrams">
							<xsl:value-of select="$LABELS/labels/entry[@key='DIAGRAM.TITLE']/@label" />
						</a>
					</li>
				</xsl:if>
				<!-- Description -->
				<xsl:if test="descriptionDocument">
					<li>
						<a href="#description">
							<xsl:value-of select="$LABELS/labels/entry[@key='DESCRIPTION.TITLE']/@label"/>
						</a>
					</li>
				</xsl:if>
				<!-- Section -->
				<xsl:for-each select="sections/section">
					<xsl:sort select="title"/>				
					<li>
						<a href="{concat('#',uri)}">
						<xsl:value-of select="title" />
						</a>
					</li>
				</xsl:for-each>
			</ul>
		</div>		
	</xsl:template>

	<xsl:template match="datecreated">
		<b>
			<xsl:value-of
				select="$LABELS/labels/entry[@key='METADATA.DATECREATED']/@label" />
		</b>
		<xsl:value-of select="." />	
		<br />
	</xsl:template>
	
	<xsl:template match="dateissued">
		<b>
			<xsl:value-of
				select="$LABELS/labels/entry[@key='METADATA.DATEISSUED']/@label" />
		</b>
		<xsl:value-of select="." />
		<br />
	</xsl:template>
	
	<xsl:template match="modifiedDate">
		<b>
			<xsl:value-of
				select="$LABELS/labels/entry[@key='METADATA.DATE']/@label" />
		</b>
		<xsl:value-of select="." />
		<br />	
	</xsl:template>
	
	<xsl:template match="yearCopyRighted">
		<b>
			<xsl:value-of
				select="$LABELS/labels/entry[@key='METADATA.DATECOPYRIGHTED']/@label" />
		</b>
		<xsl:value-of select="." />
		<br />
	</xsl:template>
	
	<xsl:template match="versionInfo">
		<b>
			<xsl:value-of
				select="$LABELS/labels/entry[@key='METADATA.VERSION']/@label" />
		</b>
		<xsl:value-of select="." />
		<br />	
	</xsl:template>

	<xsl:template match="creators">
		<b>
			<xsl:value-of
				select="$LABELS/labels/entry[@key='METADATA.CREATOR']/@label" />
		</b>
		<xsl:apply-templates />
		<br />
	</xsl:template>
	
	<xsl:template match="publishers">
		<b>
			<xsl:value-of
				select="$LABELS/labels/entry[@key='METADATA.PUBLISHER']/@label" />
		</b>
		<xsl:apply-templates />
		<br />	
	</xsl:template>
	
	<xsl:template match="rightsHolders">
		<b>
			<xsl:value-of
				select="$LABELS/labels/entry[@key='METADATA.RIGHTHOLDER']/@label" />
		</b>
		<xsl:apply-templates />
		<br />
	</xsl:template>
	
	<xsl:template match="licenses">
		<b>
			<xsl:value-of
				select="$LABELS/labels/entry[@key='METADATA.LICENSE']/@label" />
		</b>
		<xsl:apply-templates />
		<br />
	</xsl:template>
	
	<xsl:template match="feedbacks">
		<b>
			<xsl:value-of
				select="$LABELS/labels/entry[@key='METADATA.FEEDBACK']/@label" />
		</b>
		<xsl:apply-templates />	
		<br />
	</xsl:template>
	
	<!--  shared template for all values -->
	<xsl:template match="creator | publisher | rightsHolder | license | feedback">
		<xsl:choose>
			<xsl:when test="href">
				<a href="{href}" target="_blank"><xsl:value-of select="label" /></a>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="label"/>				
			</xsl:otherwise>
		</xsl:choose>
		<!-- if we have following sibling nodes, add a comma -->
		<xsl:if test="following-sibling::*">, </xsl:if>
	</xsl:template>
	
	<xsl:template match="formats">
		<b id="formats">
			<xsl:value-of select="$LABELS/labels/entry[@key='METADATA.FORMATS']/@label" />
		</b>
		<div>
			<xsl:apply-templates/>
		</div>								
	</xsl:template>
	
	<xsl:template match="format">
		<span class="sp_serialization_badge">
			<a href="{dcatURL}" target="_blank">
				<!-- JSON -->
				<xsl:if test="dctFormat = 'https://www.iana.org/assignments/media-types/application/ld+json'">
					<img src="https://img.shields.io/badge/Format-JSON_LD-blue.png" alt="JSON-LD" /> 
				</xsl:if>
				<!-- XML -->
				<xsl:if test="dctFormat = 'https://www.iana.org/assignments/media-types/application/rdf+xml'">
					<img src="https://img.shields.io/badge/Format-RDF/XML-blue.png" alt="RDF/XML" /> 
				</xsl:if>			
				<!-- N3 -->
				<xsl:if test="dctFormat = 'https://www.iana.org/assignments/media-types/application/n-triples'">
					<img src="https://img.shields.io/badge/Format-N_Triples-blue.png" alt="N-Triples" /> 			
				</xsl:if>
				<!-- ttl -->
				<xsl:if test="dctFormat = 'https://www.iana.org/assignments/media-types/text/turtle'">
					<img src="https://img.shields.io/badge/Format-TTL-blue.png" alt="TTL" /> 
				</xsl:if>				
			</a>
		</span>
	</xsl:template>
	
	
	<xsl:template match="abstract_">
		<div class="row mt-3">
			<div class="col">
				<h2 id="abstract" class="sp_section_subtitle">
					<xsl:value-of
						select="$LABELS/labels/entry[@key='METADATA.INTRODUCTION']/@label" />
				</h2>
				<!--  disable output escaping so that HTML is preserved -->
				<xsl:value-of select="." disable-output-escaping="yes" />			
			</div>
		</div>
	</xsl:template>
	
	<xsl:template match="depictions">
		<xsl:apply-templates/>		
	</xsl:template>
	
	<xsl:template match="depiction">
		<img src="{.}" style="width:100%;"/>
	</xsl:template>
	 
	<xsl:template match="diagrams">
		<xsl:apply-templates />		
	</xsl:template>
	
	<xsl:template match="diagram">
		<xsl:if test="displayTitle">
			<h3><xsl:value-of select="displayTitle" /></h3> 
		</xsl:if>
		<xsl:if test="diagramDescription">
			<p><xsl:value-of select="diagramDescription" /></p> 
		</xsl:if>
		<xsl:choose>
			<xsl:when test="$MODE = 'PDF'">
				<!--  When outputting PDF, inserts the PNG image -->
				<img src="{pngLink}" style="width:100%;" alt="a diagram representing this application profile" />
			</xsl:when>
			<xsl:otherwise>
				<!-- @disable-output-escaping prints the raw XML string as XML in the 
					document and removes XML-encoding of the characters
				-->
				<div>
					<xsl:value-of select="svg" disable-output-escaping="yes" />
				</div>
				<small class="form-text text-muted">
					<xsl:value-of
							select="$LABELS/labels/entry[@key='DIAGRAM.HELP']/@label" />
					<xsl:text> | </xsl:text>
					<a href="{pngLink}" target="_blank">
						<xsl:value-of select="$LABELS/labels/entry[@key='DIAGRAM.VIEW']/@label" />
					</a>			
				</small>
				<xsl:comment>
					<xsl:value-of select="plantUmlString" disable-output-escaping="yes" />
				</xsl:comment>	
			</xsl:otherwise>
		</xsl:choose>			
	</xsl:template>

	<!-- Description Title -->
	<xsl:template match="descriptionDocument[text() != '']">
		<div>
			<h2 id="description" class="sp_section_subtitle">
				<xsl:value-of select="$LABELS/labels/entry[@key='DESCRIPTION.TITLE']/@label" />
			</h2>
			<!--  disable output escaping so that HTML is preserved -->
			<xsl:value-of select="."  disable-output-escaping="yes"/>			
		</div>
	</xsl:template>
	
	
	<!-- Prefix -->
	<xsl:template match="prefixes">
		<div class="row mt-3">
			<div class="col">
				<section id="prefixes">
					<h2 class="sp_section_title_table">
						<xsl:value-of
							select="$LABELS/labels/entry[@key='PREFIXES.TITLE']/@label" />
					</h2>
					<table class="sp_table_prefixes table table-striped table-responsive">
						<thead>
							<tr>
								<th>
									<xsl:value-of
										select="$LABELS/labels/entry[@key='PREFIXES.COLUMN.PREFIX']/@label" />
								</th>
								<th>
									<xsl:value-of
										select="$LABELS/labels/entry[@key='PREFIXES.COLUMN.URI']/@label" />
								</th>
							</tr>
						</thead>
						<tbody>
							<xsl:apply-templates />
						</tbody>
					</table>
				</section>
			</div>
		</div>
		<br/>		
	</xsl:template>

	<xsl:template match="prefixe">
		<tr>
			<td>
				<xsl:value-of select="prefix" />
			</td>
			<td>
				<a href="{namespace}" target="_blank"><xsl:value-of select="namespace" /></a>
			</td>
		</tr>
	</xsl:template>

	<!-- Sections -->
	<xsl:template match="sections">
		<xsl:for-each select="section">
			<xsl:sort select="title"/>
			<xsl:apply-templates select="." />
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template match="section">
	<xsl:variable name = "filename">
		<xsl:if test="nameSpace = 'https://identifier.overheid.nl/tooi/def/ont/'">
		  <xsl:value-of select="localName" />
		</xsl:if>
		<xsl:if test="nameSpace != 'https://identifier.overheid.nl/tooi/def/ont/'">
		  <xsl:value-of select="replace(uri,':', '_')"/>
		</xsl:if>
	</xsl:variable>
	<xsl:variable name="fullfilename" select="concat('file:///tmp/shapes/',$filename)" />
	<xsl:variable name="correctfn" select="concat($fullfilename, '.html')" />
	
	<!-- Class -->
	<!-- Process only classes in the tooiont namespace -->
	
	<!-- indentation causes problems, because spaces on further empty lines will be interpreted as markdown makeup -->
	<xsl:result-document href="{$correctfn}" method="html" suppress-indentation="td" >
		<h3>Klasse: <xsl:value-of select="uri"/></h3>
		<table>
			<tr>
				<td>Label</td>
				<td><xsl:value-of select="title"/></td>
			</tr>
			<xsl:if test="skosDefinition != ''">
				<tr>
					<td>Definitie</td>
					<td><xsl:value-of select="skosDefinition"/></td>
				</tr>
			</xsl:if>
			<xsl:if test="superClasses/link">
				<tr>
					<td>Subklasse van</td>
					<td><xsl:call-template name="superclasses"/></td>
				</tr>
			</xsl:if>
			<xsl:if test="skosScopeNote != ''">
				<tr>
					<td>Toelichting</td>
					<td><xsl:value-of select="skosScopeNote"/></td>
				</tr>
			</xsl:if>
		</table>
	
<!-- 		<xsl:variable name="TitleNodeSape" select="uri" /> -->
<!-- 		<div class="row mt-3"> -->
<!-- 			<div class="col"> -->
<!-- 				<section id="{$TitleNodeSape}"> -->
<!-- 					<h2 class="sp_section_title_table"> -->
<!-- 						<xsl:value-of select="title" /> -->
<!-- 					</h2> -->
<!-- 					<xsl:if test="description != ''"> -->
<!-- 						<p> -->
<!-- 							 disable output escaping so that HTML is preserved -->
<!-- 							<em><xsl:value-of select="description" disable-output-escaping="yes" /></em> -->
<!-- 						</p> -->
<!-- 					</xsl:if> -->
<!-- 					<xsl:if -->
<!-- 						test="targetClassLabel != '' or superClasses/link or nodeKind != '' or pattern != '' or closed='true' or skosExample != ''"> -->
<!-- 						<ul class="sp_list_description_properties sp_ul"> -->
<!-- 							<xsl:if test="targetClassLabel != ''"> -->
<!-- 								<li> -->
<!-- 									<xsl:value-of -->
<!-- 										select="$LABELS/labels/entry[@key='LABEL_TARGETCLASS']/@label" /> -->
<!-- 									<a href="{targetClassUri}"> -->
<!-- 										<xsl:value-of select="targetClassLabel" /> -->
<!-- 									</a> -->
<!-- 								</li> -->
<!-- 							</xsl:if> -->
<!-- 							<xsl:call-template name="superclasses"/> -->
<!-- 							<xsl:if test="closed='true'"> -->
<!-- 								<li> -->
<!-- 									<xsl:value-of -->
<!-- 										select="$LABELS/labels/entry[@key='LABEL_CLOSE']/@label" /> -->
<!-- 								</li> -->
<!-- 							</xsl:if> -->
<!-- 							<xsl:if test="nodeKind != ''"> -->
<!-- 								<li> -->
<!-- 									<xsl:value-of -->
<!-- 										select="$LABELS/labels/entry[@key='LABEL_NODEKIND']/@label" /> -->
<!-- 									<xsl:value-of select="nodeKind" /> -->
<!-- 								</li> -->
<!-- 							</xsl:if> -->
		
<!-- 							<xsl:if test="pattern != ''"> -->
<!-- 								<li> -->
<!-- 									<xsl:value-of -->
<!-- 										select="$LABELS/labels/entry[@key='LABEL_PATTERNS']/@label" /> -->
<!-- 									<xsl:value-of select="pattern" />							 -->
<!-- 								</li> -->
<!-- 							</xsl:if> -->
<!-- 							Example -->
<!-- 							<xsl:if test="skosExample != ''"> -->
<!-- 								<li> -->
<!-- 									<xsl:value-of select="$LABELS/labels/entry[@key='LABEL_EXAMPLE']/@label"/> -->
<!-- 									<xsl:value-of select="skosExample"/>										 -->
<!-- 								</li> -->
<!-- 							</xsl:if> -->
<!-- 						</ul> -->
<!-- 					</xsl:if> -->
					<xsl:if test="count(properties/property)>0">
						<xsl:apply-templates />
					</xsl:if>
<!-- 				</section> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<br/> -->
	</xsl:result-document>
	</xsl:template>
	
	<xsl:template name="superclasses">
		<xsl:if test="superClasses/link">
			<xsl:for-each select="superClasses/link">
				<xsl:choose>
					<xsl:when test="position() = 1">
		                <a href="{href}"><xsl:value-of select="label" /></a>
		            </xsl:when>
		            <xsl:otherwise>
		                , <a href="{href}"><xsl:value-of select="label" /></a>
		            </xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>

	<!-- Properties -->

	<xsl:template match="properties">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="property">
	
	<xsl:variable name = "filename">
		<xsl:if test="ancestor::section/nameSpace = 'https://identifier.overheid.nl/tooi/def/ont/'">
		  <xsl:value-of select="localName" />
		</xsl:if>
		<xsl:if test="ancestor::section/nameSpace != 'https://identifier.overheid.nl/tooi/def/ont/'">
		  <xsl:variable name="uri" select="replace(ancestor::section/uri,':.*$', '_')"/>
		  <xsl:value-of select="concat($uri, localName)"/>
		</xsl:if>
	</xsl:variable>
	
<!-- 	<xsl:value-of select="ancestor::section/uri"/> -->
	
	
<!-- 	<xsl:value-of select="$filename" /> -->
	<xsl:variable name="fullfilename" select="concat('file:///tmp/shapes/',$filename)" />
	<xsl:variable name="correctfn" select="concat($fullfilename, '.html')" />
<!-- 	<xsl:value-of select="$correctfn"/> -->
	
	<!-- indentation causes problems, because spaces on further empty lines will be interpreted as markdown makeup -->
	<xsl:result-document href="{$correctfn}" method="html" suppress-indentation="td">
	
<!-- 	<xsl:result-document href="$fullfilename" > -->
	    <h3>Property Shape: <xsl:value-of select="localName" /></h3>
		<table>
			<tr>
				<td>Subjectklasse</td>
				<!-- Expected Value -->
				<td>
					<!-- Op verzoek (voorlopig) alleen de URI -->
					<xsl:choose>
						<xsl:when test="linkNodeShapeUri != ''">
							<xsl:value-of select="linkNodeShapeUri" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:message terminate="no">WARNING: linkNodeShapeUri (URI) voor <xsl:value-of select="localName"/> ontbreekt</xsl:message>
						</xsl:otherwise>
					</xsl:choose>	
<!-- 					<xsl:choose> -->
<!-- 						<xsl:when test="linkNodeShape != ''"> -->
<!-- 							<code> -->
<!-- 								<a href="{concat('#',linkNodeShapeUri)}"> -->
<!-- 									<xsl:value-of select="linkNodeShape" /> -->
<!-- 								</a> -->
<!-- 							</code> -->
<!-- 						</xsl:when> -->
<!-- 						<xsl:otherwise> -->
<!-- 							<xsl:choose> -->
<!-- 								<xsl:when test="string-length(or) > 0"> -->
<!-- 									<xsl:variable name="nfois" -->
<!-- 										select="count(tokenize(or,','))" /> -->
<!-- 									<xsl:for-each select="tokenize(or,',')"> -->
<!-- 										<xsl:variable name="countData"> -->
<!-- 											<xsl:choose> -->
<!-- 												<xsl:when test="position() = 1"> -->
<!-- 													<xsl:value-of select="count(.)" /> -->
<!-- 												</xsl:when> -->
<!-- 												<xsl:otherwise> -->
<!-- 													<xsl:value-of select="count(.)+1" /> -->
<!-- 												</xsl:otherwise> -->
<!-- 											</xsl:choose> -->
<!-- 										</xsl:variable> -->
<!-- 										<xsl:variable name="sDataOrg" select="." /> -->
<!-- 											<code> -->
<!-- 												<a href="{concat('#',$sDataOrg)}"> -->
<!-- 													<xsl:value-of select="concat($sDataOrg,' ')" /> -->
<!-- 												</a> -->
<!-- 											</code> -->
<!-- 										<xsl:choose> -->
<!-- 											<xsl:when test="$nfois &gt; $countData"> -->
<!-- 												<code> -->
<!-- 													<xsl:text>or</xsl:text> -->
<!-- 												</code> -->
<!-- 											</xsl:when> -->
<!-- 										</xsl:choose> -->
<!-- 									</xsl:for-each> -->
<!-- 								</xsl:when> -->
<!-- 								<xsl:otherwise> -->
<!-- 									<code> -->
<!-- 										disable output espacing as we may have <sup> in rendering -->
<!-- 										<xsl:value-of disable-output-escaping="yes" select="expectedValueLabel" /> -->
<!-- 									</code> -->
<!-- 								</xsl:otherwise> -->
<!-- 							</xsl:choose> -->
<!-- 						</xsl:otherwise> -->
<!-- 					</xsl:choose> -->
					<br />
					<xsl:if test="expectedValueAdditionnalInfoIn/text()">
						<p>
							<small>
								<!-- disable output espacing as we may have <sup> in rendering -->
								<xsl:value-of disable-output-escaping="yes"
									select="concat('(',expectedValueAdditionnalInfoIn,')')" />
							</small>
						</p>
					</xsl:if>
					<xsl:if test="expectedValueAdditionnalInfoValue/text()">
						<p>
							<small>
								<xsl:value-of
									select="expectedValueAdditionnalInfoValue" />
							</small>
						</p>
					</xsl:if>
				</td>
			</tr>
			<tr>
				<td>Property</td>
				<!-- Property URI -->
				<td>
					<xsl:if test="propertyUri">
						<xsl:choose>
							<xsl:when test="propertyUri/href != ''">
								<code>
									<a href="{propertyUri/href}"><xsl:value-of select="propertyUri/label" /></a>							
								</code>	
							</xsl:when>
							<xsl:otherwise>
								<code><xsl:value-of select="propertyUri/label" /></code>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>				
				</td>
			</tr>
			<xsl:if test="label != ''">
				<tr>
					<!-- Property name -->
					<td>Label</td>
					<td>
						<xsl:value-of select="label" />
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="rangeClass != ''">
				<tr>					
					<td>Object</td>
					<td>
						<xsl:value-of select="rangeClass" />
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="description != ''">
				<tr>
					<td>Cardinaliteit</td>
					<td>
						<xsl:value-of select="cardinalite" />
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="description != ''">
				<tr>
					<td>Beschrijving</td>
					<td>
						<xsl:value-of select="description" />
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="skosScopeNote != ''">
				<tr>
					<td>Contextuele toelichting</td>
					<td>
						<xsl:value-of select="skosScopeNote" />
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="skosDefinition != ''">
			<tr>
				<td>Contextuele definitie</td>
				<td>
					<xsl:value-of select="skosDefinition" />
				</td>
			</tr>
			</xsl:if>
			<xsl:if test="tooiFrbrScope != ''">
				<tr>
					<td>FRBR</td>
					<td>
						<xsl:value-of select="tooiFrbrScope" />
					</td>
				</tr>	
			</xsl:if>
			<xsl:if test="tooiCategorie != ''">
				<tr>
					<td>TOOI-categorie</td>
					<td>
						<xsl:value-of select="tooiCategorie" />
					</td>
				</tr>
			</xsl:if>
		</table>
 		</xsl:result-document>
	</xsl:template>

	<!-- don't print what was not matched -->
	<xsl:template match="text()"></xsl:template>


</xsl:stylesheet>