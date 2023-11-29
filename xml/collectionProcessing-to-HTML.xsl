<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs math"
    version="3.0"
    >
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
   
   <!--2023-11-28 ebb: The line below is a variable definining a directory or collection of XML files. -->
<xsl:variable name="contributorLists" as="document-node()+" select="collection('contributorLists')"/>
    
 <xsl:variable name="authorNames" as="xs:string" select="$contributorLists//persName ! normalize-space() => distinct-values()"/>
    
    <xsl:template match="/">
        
        
        <html>
            <head>
                <title>Contributing Authors Table</title>
            <!--  CSS LINK LINE HERE!   <link/>-->
            </head>
        
       <table> 
           <tr>
               <th>Author Name</th>
               <th>Quark Issues</th>
               <th>Associated titles</th>
           </tr>
           <xsl:for-each select="$authorNames">
            <tr>
                <td><xsl:value-of select="current()"/></td>
                
                
                
            </tr>
  
        </xsl:for-each>
        </table>
        </html>
        
    </xsl:template>
    
    
    
</xsl:stylesheet>
