<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs math" version="3.0">

    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" include-content-type="no"
        indent="yes"/>

   
    <xsl:template match="/">


        <html>
            <head>
                <title><xsl:apply-templates select=".//header/title"/> Contributor Table</title>
                <link rel="stylesheet" type="text/css" href="contribStyle.css"/>
            </head>

           <body> 
               <h1><xsl:apply-templates select=".//header/title"/></h1>
               
                <h2>Editors</h2>
               <ul>
                   <xsl:for-each select=".//header/editor">
                       <li><xsl:apply-templates select="."/></li>
                   </xsl:for-each>
               </ul>
               
               
               <table>
                <tr>
                    <th>Name</th>
                    <th>Birth</th>
                    <th>Death</th>
                    <th>Bio</th>
                    <th>Titles from this issue</th>
                </tr>
                   
                   <xsl:apply-templates select=".//person"/>
                   
            </table>
 
           </body>
        </html>

    </xsl:template>
    
    
    <xsl:template match="person">
        <tr>
            <td><xsl:apply-templates select="persName"/></td>
            <td><xsl:apply-templates select="birth/@when"/></td>
            <td><xsl:apply-templates select="death/@when"/></td>
            <td><xsl:apply-templates select=".//desc"/></td>
            <td>
                <xsl:apply-templates select="toc"/>
                
            </td>

        </tr>

    </xsl:template>
    
    <xsl:template match="toc">
       <xsl:if test=".//title[string-length() > 0]"> 
           
           <xsl:apply-templates select="entry"/>
            
   
       </xsl:if>
        
    </xsl:template>
    
    <xsl:template match="entry">
        <p> 
            <q><xsl:apply-templates select="title"/></q>: pages 
            <xsl:apply-templates select="pages"/>
        </p>
        
    </xsl:template>



</xsl:stylesheet>
