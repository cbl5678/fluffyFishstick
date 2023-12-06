<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    exclude-result-prefixes="xs math" version="3.1">

    <!-- 2023-12-02 ebb: This stylesheet outputs geoJSON for plotting place info from the Quark contributor lists on a Leaflet web map. -->
    
    <xsl:output method="text" indent="yes"/> 

    <!--2023-11-28 ebb: The line below is a variable definining a directory or collection of XML files. -->
    <xsl:variable name="contributorLists" as="document-node()+"
        select="collection('contributorLists')"/>
    

    <xsl:template match="/">
       <xsl:variable name="places" as="xs:string+" select="$contributorLists//@where ! normalize-space() => distinct-values() => sort()"/>
        {
        "type": "FeatureCollection",
        "features": [
        
        <xsl:for-each select="$places">
            {
            "type": "Feature",
            "geometry": {
            "type": "Point",
            <!-- Call a template to perform geocoding and get coordinates -->
            "coordinates": <xsl:call-template name="geocode">
                <xsl:with-param name="placeName" select="current()"/>
            </xsl:call-template>
            },
            "properties": {
            <!-- Add other properties as needed -->
            "placeName": "<xsl:value-of select="current()"/>",
            <!-- ebb: Tree walker: Return the count of the number of times this place is mentioned. -->
            "count": <xsl:value-of select="$contributorLists//*[@where ! normalize-space() = current()] => count()"/>
            }
            }
            <!-- Add a comma if this is not the last place node -->
            <xsl:if test="position() != last()">,</xsl:if>
            
        </xsl:for-each>
     
     ]
     }
    </xsl:template>
    
    
    <!-- Template to perform geocoding API lookup -->
    <xsl:template name="geocode">
        <xsl:param name="placeName"/>
        <xsl:variable name="apiKey" select="'003dd3cc5cf8407c872d4de44b3a180f'"/>
        <xsl:variable name="url" select="concat('https://api.opencagedata.com/geocode/v1/json?q=', encode-for-uri($placeName), '&amp;key=', $apiKey)"/>
 
     <!-- <xsl:value-of select="$url"/>-->
        <!-- Make the API request and parse the JSON response -->
        <xsl:variable name="response" select="json-to-xml(unparsed-text($url))"/>
        
        <!-- Use XPath to extract the coordinates from the parsed JSON -->
      <!--  <xsl:variable name="coordinates" select="map:get('lat')"/>-->
        
        <xsl:value-of select="'[' || ($response//*[@key='geometry'])[1]/*[@key='lat'] || ', ' || ($response//*[@key='geometry'])[1]/*[@key='lng'] || ']' "/>
        

        
    </xsl:template>
    


</xsl:stylesheet>
