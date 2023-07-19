<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs" version="2.0">

    <xsl:output indent="yes" method="xml" encoding="UTF-8" omit-xml-declaration="no"/>

    <!-- Template sur la racine et le teiHeader-->
    <xsl:template match="/">

        <TEI xmlns="http://www.tei-c.org/ns/1.0">
            <!-- Début du teiHeader -->
            <teiHeader>
                <!-- Le fileDesc est obligatoire -->
                <fileDesc>
                    <!-- Copie des balises de titre -->
                    <xsl:if test="./code/title">
                        <titleStmt>
                            <title xml:lang="ch">
                                <xsl:value-of select="./code/title[@lang = 'ch']"/>
                            </title>
                        </titleStmt>
                    </xsl:if>
                    <xsl:if test="not(./code/title)">
                        <titleStmt>
                            <title xml:lang="ch">
                                <xsl:value-of select="./code/description/title[@lang = 'ch']"/>
                            </title>
                        </titleStmt>
                    </xsl:if>

                    <!-- Informations relatives à l'édition électronique -->
                    <editionStmt>
                        <edition> This edition was encoded for the COREL project, in order to publish a corpus of documents on legal history of Imperial China.</edition>
                        <respStmt>
                            <resp>XSLT Transformation made by</resp>
                            <persName>
                                <surname>Nguyen</surname>
                                <forename>Maëva</forename>
                            </persName>
                        </respStmt>
                    </editionStmt>

                    <!-- Informations concernant la publication de la présente édition-->
                    <publicationStmt>
                        <authority>Le Collège de France</authority>
                        <authority>École Française d'Extrême-Orient</authority>
                        <pubPlace>Paris</pubPlace>
                        <date when='2023-07'>July 2023</date>
                        <availability>
                            <licence target='https://www.etalab.gouv.fr/licence-ouverte-open-licence/'>
                                Open licence Etalab
                            </licence>
                        </availability>
                    </publicationStmt>

                    <!-- Informations sur le texte source -->
                    <sourceDesc>
                       <p> The XML documents we transformed into XML-TEI were originally edited and published by the LSC project.
                           The editions are available online on their website as a trilingual edition of the codes.
                           <bibl>
                            <title xml:lang="ch">
                                <xsl:value-of select="./code/title[@lang='ch']"/>
                            </title>, originally published in
                            <date>
                                <xsl:if test="//code[@id='code1646']">
                                    <xsl:attribute name="when">1646</xsl:attribute>
                                    <xsl:text>1646</xsl:text>
                                </xsl:if>
                                <xsl:if test="//code[@id='DQLL1740']">
                                    <xsl:attribute name="when">1740</xsl:attribute>
                                    <xsl:text>1740</xsl:text></xsl:if>
                                <xsl:if test="//code[@id='DQLLGY']">
                                    <xsl:attribute name="when">1871</xsl:attribute>
                                    <xsl:text>1871</xsl:text></xsl:if>
                                <xsl:if test="//code[@id='HDSLXB']">
                                    <xsl:attribute name="when">1899</xsl:attribute>
                                    <xsl:text>1899</xsl:text></xsl:if>
                                <xsl:if test="//code[@id='DuliCunyi']">
                                    <xsl:attribute name="when">1906</xsl:attribute>
                                    <xsl:text>1906</xsl:text></xsl:if>
                            </date>
                        </bibl></p>
                    </sourceDesc>
                </fileDesc>

                <encodingDesc>
                    <!-- Description du projet d'encodage-->
                    <projectDesc>
                        <p>
                            This XML-TEI encoding is based on the transformation of XML documents, in order
                            to publish a digital edition of the Qing's codes (1644-1911) for the COREL project.
                            This edition differs from the previous one in XML : it was made to put an accent on the
                            original sources' structure and provide an example of how to encode legal sources.
                        </p>
                    </projectDesc>
                </encodingDesc>
            </teiHeader>
            <!-- Fin du teiHeader -->
            
            <text xml:lang="ch">
                <!-- Ajout de l'id du code -->
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="./code/@id"/>
                </xsl:attribute>
                <xsl:apply-templates/>
            </text>
        </TEI>
    </xsl:template>

    <!-- Template pour le front -->
    <xsl:template match="/code">
        <!-- Début des pièces liminaires s'il y en a-->
        <xsl:if test="./chart">
        <front>
            <!-- Nouvelle section : chart -->
                <div type="chart">
                    <!-- Pour les titres -->
                    <head>
                        <xsl:value-of select="./chart/title[@lang = 'ch']"/>
                    </head>
                    <!-- Boucle sur les balises part -->
                    <xsl:for-each select="./chart/part">
                        
                            <div type='table'>
                                <xsl:attribute name='n'>
                                    <xsl:value-of select="./@id"/>
                                </xsl:attribute>
                                <!-- Pour les titres -->
                            <head>
                                <xsl:value-of select="./title[@lang = 'ch']"/>
                            </head>
                            <!-- La balise content -->
                            <xsl:for-each select="./content[@lang = 'ch']">
                                <!-- La table -->
                                <xsl:for-each select="./TABLE">
                                    <table>
                                        <!-- Les rangs-->
                                        <xsl:for-each select="TR">
                                            <row>
                                                <!-- Les cellules-->
                                                <xsl:for-each select="TD">
                                                  <cell>
                                                  <!-- Les attributs colspan et rowspan si nécessaires -->
                                                    <xsl:if test="./@COLSPAN">
                                                        <xsl:attribute name="cols">
                                                            <xsl:value-of select="./@COLSPAN"/>
                                                        </xsl:attribute>
                                                    </xsl:if>
                                                    <xsl:if test="./@ROWSPAN">
                                                        <xsl:attribute name="rows">
                                                            <xsl:value-of select="./@ROWSPAN"/>
                                                        </xsl:attribute>
                                                    </xsl:if>
                                                  <!-- Fin des attributs -->

                                                  <!-- Reproduction des paragraphes -->
                                                    <xsl:for-each select="./P">
                                                        <p>
                                                            <xsl:value-of select="."/>
                                                            <xsl:for-each select="BR">
                                                                <lb/>
                                                            </xsl:for-each>
                                                        </p>
                                                    </xsl:for-each>
                                                  <!-- Fin des paragraphes-->
                                                  </cell>
                                                </xsl:for-each>
                                                <!-- Fin des cellules -->
                                            </row>
                                        </xsl:for-each>
                                        <!-- Fin des rangs-->
                                    </table>
                                </xsl:for-each>
                                <!-- Fin des tables-->
                            </xsl:for-each>
                            <!-- Fin du content-->
                        </div>
                    </xsl:for-each>
                    
                </div>
                <!-- Fin de la div type chart-->
            
        </front>
        </xsl:if>
        <xsl:apply-templates select="/code/document"/>
    </xsl:template>

    <!-- Nouveau template pour le code de 1740 -->
    <xsl:template match="/code[@id='DQLL1740']/document">
        <body>
            <!-- Pour les titres -->
            <head>
                <xsl:value-of select="./title[@lang = 'ch']"/>
            </head>
            <!-- Nouvelle section : balise bu -->
            <xsl:if test="./bu">
                <!-- Boucle pour reproduire chaque bu -->
                <xsl:for-each select="./bu">
                    <div type="chapter">
                        <!-- Récupération de l'attribut -->
                        <xsl:attribute name="n">
                            <xsl:value-of select="./@id"/>
                        </xsl:attribute>
                        <pb/>
                        <!-- Titres -->
                        <head>
                            <xsl:value-of select="./title[@lang = 'ch']"/>
                        </head>
                        <!-- Nouvelle div : men -->
                        <xsl:for-each select="./men">
                            <div type="section">
                                <!-- Récupération de l'attribut id -->
                                <xsl:attribute name="n">
                                    <xsl:value-of select="./@id"/>
                                </xsl:attribute>
                                <pb/>
                                <!-- Titre -->
                                <head>
                                    <xsl:value-of select="./title[@lang = 'ch']"/>
                                </head>
                                <!-- Boucle sur les lu -->
                                <xsl:for-each select="./lu">
                                    <div type="statute">
                                        <!-- Attribut -->
                                        <xsl:attribute name="n">
                                            <xsl:value-of select="./@id"/>
                                        </xsl:attribute>
                                        <pb/>
                                        <!-- Titres -->
                                        <head>
                                            <xsl:value-of select="./title[@lang = 'ch']"/>
                                        </head>
                                       
                                        <!-- Boucle sur le content -->
                                        <xsl:for-each select="./content[@lang ='ch']/p">
                                            <p>
                                                <xsl:apply-templates/>
                                            </p>
                                        </xsl:for-each>
                                        <!-- Fin de la boucle content-->
                                        
                                                
                                           
                                      <!-- Nouvelle section : li -->
                                    <xsl:for-each select="./li">
                                        <div type="substatute">
                                            <xsl:attribute name="n">
                                                <xsl:value-of select="./@id"/>
                                            </xsl:attribute>
                                            <pb/>
                                            <xsl:for-each select="./content[@lang='ch']">
                                                <p>
                                                    <xsl:apply-templates/>
                                                </p>
                                            </xsl:for-each>
                                        </div>
                                    </xsl:for-each>
                                    <!-- Fin de la div lu-->
                                    </div>
                                </xsl:for-each>
                                <!-- Fin de la balise-->
                            </div>
                            <!-- Fin de la div type men-->
                        </xsl:for-each>
                        <!-- Fin de la condition men-->
                    </div>
                    <!-- Fin de la div bu-->
                </xsl:for-each>
                <!-- Fin de la boucle sur les bu-->
            </xsl:if>
            <!-- Fin de la condition bu-->
        </body>
    </xsl:template>
    
    <!-- Nouveau template pour le code de 1646 -->
    <xsl:template match="/code[@id='code1646']/document">
        
        <body>
            <!-- Pour les titres -->
            <head>
                <xsl:value-of select="./title[@lang = 'ch']"/>
            </head>
            <!-- Nouvelle section : balise bu -->
            <xsl:if test="./bu">
                <!-- Boucle pour reproduire chaque bu -->
                <xsl:for-each select="./bu">
                    <div type="chapter">
                        <!-- Récupération de l'attribut -->
                        <xsl:attribute name="n">
                            <xsl:value-of select="./@id"/>
                        </xsl:attribute>
                        <pb/>
                        <!-- Titres -->
                        <head>
                            <xsl:value-of select="./title[@lang = 'ch']"/>
                        </head>
                        <!-- Nouvelle div : men -->
                        <xsl:for-each select="./men">
                            <div type="section">
                                <!-- Récupération de l'attribut id -->
                                <xsl:attribute name="n">
                                    <xsl:value-of select="./@id"/>
                                </xsl:attribute>
                                <pb/>
                                <!-- Titre -->
                                <head>
                                    <xsl:value-of select="./title[@lang = 'ch']"/>
                                </head>
                                <!-- Boucle sur les lu -->
                                <xsl:for-each select="./lu">
                                    <div type="statute">
                                        <!-- Attribut -->
                                        <xsl:attribute name="n">
                                            <xsl:value-of select="./@id"/>
                                        </xsl:attribute>
                                        <pb/>
                                        <!-- Titres -->
                                        <head>
                                            <xsl:value-of select="./title[@lang = 'ch']"/>
                                        </head>
                                        
                                        <!-- Boucle sur le content -->
                                        <xsl:for-each select="./content[@lang ='ch']">
                                            <p>
                                                <xsl:apply-templates/>
                                            </p>
                                        </xsl:for-each>
                                        <!-- Fin de la boucle content-->
                                        
                                        
                                        
                                    <!-- Nouvelle section : li -->
                                    <xsl:for-each select="./li">
                                        <div type="substatute">
                                            <xsl:attribute name="n">
                                                <xsl:value-of select="./@id"/>
                                            </xsl:attribute>
                                            <pb/>
                                            <xsl:for-each select="./content[@lang='ch']">
                                                <p>
                                                    <xsl:apply-templates/>
                                                </p>
                                            </xsl:for-each>
                                        </div>
                                    </xsl:for-each>
                                    <!-- Fin de la div lu-->
                                    </div>  
                                </xsl:for-each>
                                <!-- Fin de la balise-->
                            </div>
                            <!-- Fin de la div type men-->
                        </xsl:for-each>
                        <!-- Fin de la condition men-->
                    </div>
                    <!-- Fin de la div bu-->
                </xsl:for-each>
                <!-- Fin de la boucle sur les bu-->
            </xsl:if>
            <!-- Fin de la condition bu-->
        </body>
    </xsl:template>

    <!-- Nouveau template pour le code de 1871 -->
    <xsl:template match="/code[@id='DQLLGY']/document">
        
        <body>
            <!-- Pour les titres -->
            <head>
                <xsl:value-of select="./title[@lang = 'ch']"/>
            </head>
            <!-- Nouvelle section : balise bu -->
            <xsl:if test="./bu">
                <!-- Boucle pour reproduire chaque bu -->
                <xsl:for-each select="./bu">
                    <div type="chapter">
                        <!-- Récupération de l'attribut -->
                        <xsl:attribute name="n">
                            <xsl:value-of select="./@id"/>
                        </xsl:attribute>
                        <pb/>
                        <!-- Titres -->
                        <head>
                            <xsl:value-of select="./title[@lang = 'ch']"/>
                        </head>
                        <!-- Nouvelle div : men -->
                        <xsl:for-each select="./men">
                            <div type="section">
                                <!-- Récupération de l'attribut id -->
                                <xsl:attribute name="n">
                                    <xsl:value-of select="./@id"/>
                                </xsl:attribute>
                                <pb/>
                                <!-- Titre -->
                                <head>
                                    <xsl:value-of select="./title[@lang = 'ch']"/>
                                </head>
                                <!-- Boucle sur les lu -->
                                <xsl:for-each select="./lu">
                                    <div type="statute">
                                        <!-- Attribut -->
                                        <xsl:attribute name="n">
                                            <xsl:value-of select="./@id"/>
                                        </xsl:attribute>
                                        <pb/>
                                        <!-- Titres -->
                                        <head>
                                            <xsl:value-of select="./title[@lang = 'ch']"/>
                                        </head>
                                        
                                        <!-- Boucle sur le content -->
                                        <xsl:for-each select="./content">
                                            <p>
                                                <xsl:apply-templates/>
                                            </p>
                                        </xsl:for-each>
                                        <!-- Fin de la boucle content-->
                                        <xsl:for-each select="./part">
                                            <div>
                                                <head><xsl:value-of select="./title"/>
                                                </head>
                                                <xsl:for-each select="./content">
                                                    <p>
                                                        <xsl:apply-templates/>
                                                    </p>
                                                </xsl:for-each>
                                                
                                                <!-- Nouvelle section : li -->
                                                <xsl:for-each select="./li">
                                                    <div type="substatute">
                                                        <xsl:attribute name="n">
                                                            <xsl:value-of select="./@id"/>
                                                        </xsl:attribute>
                                                        <pb/>
                                                        <xsl:for-each select="./content">
                                                            <p>
                                                                <xsl:apply-templates/>
                                                            </p>
                                                        </xsl:for-each>
                                                    </div>
                                                </xsl:for-each>
                                            </div>
                                        </xsl:for-each>
                                        
                                        
                                    </div>  
                                    <!-- Fin de la div lu-->
                                </xsl:for-each>
                                <!-- Fin de la balise-->
                            </div>
                            <!-- Fin de la div type men-->
                        </xsl:for-each>
                        <!-- Fin de la condition men-->
                    </div>
                    <!-- Fin de la div bu-->
                </xsl:for-each>
                <!-- Fin de la boucle sur les bu-->
            </xsl:if>
            <!-- Fin de la condition bu-->
        </body>
    </xsl:template>
    
    <!-- Nouveau template pour le HDSLXB -->
    <xsl:template match="/code[@id='HDSLXB']/document">
        
        <body>
            <!-- Pour les titres -->
            <head>
                <xsl:value-of select="./title[@lang = 'ch']"/>
            </head>
            <!-- Nouvelle section : balise bu -->
            <xsl:if test="./bu">
                <!-- Boucle pour reproduire chaque bu -->
                <xsl:for-each select="./bu">
                    <div type="chapter">
                        <!-- Récupération de l'attribut -->
                        <xsl:attribute name="n">
                            <xsl:value-of select="./@id"/>
                        </xsl:attribute>
                        <pb/>
                        <!-- Titres -->
                        <head>
                            <xsl:value-of select="./title[@lang = 'ch']"/>
                        </head>
                        <!-- Nouvelle div : men -->
                        <xsl:for-each select="./men">
                            <div type="section">
                                <!-- Récupération de l'attribut id -->
                                <xsl:attribute name="n">
                                    <xsl:value-of select="./@id"/>
                                </xsl:attribute>
                                <pb/>
                                <!-- Titre -->
                                <head>
                                    <xsl:value-of select="./title[@lang = 'ch']"/>
                                </head>
                                <!-- Boucle sur les lu -->
                                <xsl:for-each select="./lu">
                                    <div type="statute">
                                        <!-- Attribut -->
                                        <xsl:attribute name="n">
                                            <xsl:value-of select="./@id"/>
                                        </xsl:attribute>
                                        <pb/>
                                        <!-- Titres -->
                                        <head>
                                            <xsl:value-of select="./title[@lang = 'ch']"/>
                                        </head>
                                        
                                        <!-- Boucle sur le content -->
                                        <xsl:for-each select="./content[@lang='ch']">
                                            <p>
                                                <xsl:apply-templates/>
                                            </p>
                                        </xsl:for-each>
                                        <!-- Fin de la boucle content-->
                                        <xsl:for-each select="./part">
                                            <xsl:if test='./xingzhi'>
                                            <div>
                                                <pb/>
                                                <head><xsl:value-of select="./title"/>
                                                </head>
                                               <xsl:for-each select="./xingzhi">
                                                   <head><xsl:value-of select="./title"/></head>
                                                   <xsl:for-each select="./enum">
                                                       <list>
                                                           <xsl:for-each select="./item">
                                                               <item>
                                                                   <date>
                                                                       <xsl:attribute name="when">
                                                                           <xsl:value-of select="./@date"/>
                                                                       </xsl:attribute>
                                                                       <xsl:value-of select="./@date"/>
                                                                   </date>
                                                                   <xsl:for-each select="content[@lang='ch']">
                                                                       <p><xsl:apply-templates/></p>
                                                                   </xsl:for-each>
                                                               </item>
                                                           </xsl:for-each>
                                                       </list>
                                                   </xsl:for-each>
                                               </xsl:for-each>
                                                
                                                <xsl:for-each select="./reshen">
                                                    <div>
                                                        <pb/>
                                                        <head><xsl:value-of select="./title"/></head>
                                                    <xsl:for-each select="./enum">
                                                        <list>
                                                            <xsl:for-each select="./item">
                                                                <item>
                                                                    <date>
                                                                        <xsl:attribute name="when">
                                                                            <xsl:value-of select="./@date"/>
                                                                        </xsl:attribute>
                                                                        <xsl:value-of select="./@date"/>
                                                                    </date>
                                                                    <xsl:for-each select="content[@lang='ch']">
                                                                        <p><xsl:apply-templates/></p>
                                                                    </xsl:for-each>
                                                                </item>
                                                            </xsl:for-each>
                                                        </list>
                                                    </xsl:for-each></div>
                                                </xsl:for-each>
                                            </div></xsl:if>
                                            
                                                <!-- Nouvelle section : li -->
                                                <xsl:for-each select="./li">
                                                    <div type="substatute">
                                                        <xsl:attribute name="n">
                                                            <xsl:value-of select="./@id"/>
                                                        </xsl:attribute>
                                                        <pb/>
                                                        <xsl:for-each select="./content[@lang='ch']">
                                                            <p>
                                                                <xsl:apply-templates/>
                                                            </p>
                                                        </xsl:for-each>
                                                    </div>
                                                </xsl:for-each>
                                                <xsl:if test="./enum">
                                                   <xsl:for-each select="./enum"><div>
                                                       <head><xsl:value-of select="./preceding-sibling::title"/></head>
                                                       
                                                       <list>
                                                           <xsl:for-each select="./item"><item>
                                                               <date>
                                                                   <xsl:attribute name="when">
                                                                       <xsl:value-of select="./@date"/>
                                                                   </xsl:attribute>
                                                                   <xsl:value-of select="./@date"/>
                                                               </date>
                                                               <p><xsl:apply-templates/></p>
                                                           </item></xsl:for-each>
                                                       </list>
                                                   </div></xsl:for-each>
                                                </xsl:if>
                                           
                                        </xsl:for-each>
                                        
                                        
                                    </div>  
                                    <!-- Fin de la div lu-->
                                </xsl:for-each>
                                <!-- Fin de la balise-->
                            </div>
                            <!-- Fin de la div type men-->
                        </xsl:for-each>
                        <!-- Fin de la condition men-->
                    </div>
                    <!-- Fin de la div bu-->
                </xsl:for-each>
                <!-- Fin de la boucle sur les bu-->
            </xsl:if>
            <!-- Fin de la condition bu-->
        </body>
    </xsl:template>
    
    <!-- Nouveau template pour le code de 1906 -->
    <xsl:template match="/code[@id='DuliCunyi']/document">
        <body>
            <!-- Pour les titres -->
            <head>
                <xsl:value-of select="./title[@lang = 'ch']"/>
            </head>
            <!-- Nouvelle section : balise bu -->
            <xsl:if test="./bu">
                <!-- Boucle pour reproduire chaque bu -->
                <xsl:for-each select="./bu">
                    <div type="chapter">
                        <!-- Récupération de l'attribut -->
                        <xsl:attribute name="n">
                            <xsl:value-of select="./@id"/>
                        </xsl:attribute>
                        <pb/>
                        <!-- Titres -->
                        <head>
                            <xsl:value-of select="./title[@lang = 'ch']"/>
                        </head>
                        <!-- Nouvelle div : men -->
                        <xsl:for-each select="./men">
                            <div type="section">
                                <!-- Récupération de l'attribut id -->
                                <xsl:attribute name="n">
                                    <xsl:value-of select="./@id"/>
                                </xsl:attribute>
                                <pb/>
                                <!-- Titre -->
                                <head>
                                    <xsl:value-of select="./title"/>
                                </head>
                                <!-- Boucle sur les lu -->
                                <xsl:for-each select="./lu">
                                    <div type="statute">
                                        <!-- Attribut -->
                                        <xsl:attribute name="n">
                                            <xsl:value-of select="./@id"/>
                                        </xsl:attribute>
                                        <pb/>
                                        <!-- Titres -->
                                        <head>
                                            <xsl:value-of select="./title[@lang = 'ch']"/>
                                        </head>
                                        
                                        <!-- Boucle sur le content -->
                                        <xsl:for-each select="./content[@lang ='ch']">
                                            <p>
                                                <xsl:apply-templates/>
                                            </p>
                                        </xsl:for-each>
                                        <!-- Fin de la boucle content-->
                                        
                                        
                                        
                                    <!-- Nouvelle section : li -->
                                    <xsl:for-each select="./li">
                                        <div type="substatute">
                                            <xsl:attribute name="n">
                                                <xsl:value-of select="./@id"/>
                                            </xsl:attribute>
                                            <pb/>
                                            <xsl:for-each select="./content[@lang='ch']">
                                                <p>
                                                    <xsl:apply-templates/>
                                                </p>
                                            </xsl:for-each>
                                        </div>
                                    </xsl:for-each>
                                    <!-- Fin de la div lu-->
                                    </div>  
                                </xsl:for-each>
                                <!-- Fin de la balise-->
                            </div>
                            <!-- Fin de la div type men-->
                        </xsl:for-each>
                        <!-- Fin de la condition men-->
                    </div>
                    <!-- Fin de la div bu-->
                </xsl:for-each>
                <!-- Fin de la boucle sur les bu-->
            </xsl:if>
            <!-- Fin de la condition bu-->
        </body>
    </xsl:template>
    
    <xsl:template match="//personname">
        <persName>
            <xsl:value-of select="."/>
        </persName>
    </xsl:template>
    

    <xsl:template match="//propername">
        <placeName>
            <xsl:value-of select="."/>
        </placeName>
    </xsl:template>

    <xsl:template match="//bookname">
        <bibl>
            <xsl:value-of select="."/>
        </bibl>
    </xsl:template>

    <xsl:template match="//inf">
        <note type='official'>
            <xsl:value-of select="."/>
        </note>
    </xsl:template>
</xsl:stylesheet>
