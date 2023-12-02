<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
       <xsl:template match="xml">
           <contList>
               <xsl:apply-templates/>
           </contList>
       </xsl:template>
    <xsl:template match="person">
        <person xml:id="p-{count(preceding-sibling::person)+1}"><xsl:apply-templates/></person>
    </xsl:template>
    <xsl:template match="persName">
        <persName><xsl:apply-templates/></persName>
    </xsl:template>
    <xsl:template match="birth">
        <birth when="{@when}"/><xsl:apply-templates/>
    </xsl:template>
</xsl:stylesheet>