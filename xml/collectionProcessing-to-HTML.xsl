<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs math" version="3.0">

    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" include-content-type="no"
        indent="yes"/>

    <!--2023-11-28 ebb: The line below is a variable definining a directory or collection of XML files. -->
    <xsl:variable name="contributorLists" as="document-node()+"
        select="collection('contributorLists')"/>
    
    <!--Here's a variable for the quarkContents collection that you can use in other XSLT files -->
    <xsl:variable name="quarkContents" as="document-node()+"
        select="collection('quarkContent')"/>
    

    <xsl:variable name="authorNames" as="xs:string+"
        select="$contributorLists//persName ! normalize-space() ! upper-case(.) => distinct-values() => sort()"/>

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

                    <xsl:variable name="quarkWalker" as="xs:string+"
                        select="$contributorLists//xml[.//persName[. ! normalize-space() ! upper-case(.) = current()]] ! base-uri() ! tokenize(., '/')[last()] ! substring-after(., '_0') ! substring-before(., '.xml')"/>
                    <!--ebb: The series of XPath functions is grabbing the filepath of the file and then cutting it to get the issue number out of it.  -->
                    <tr>
                        <td>
                            <xsl:value-of select="current()"/>
                        </td>
                        <td>Issue(s) <xsl:value-of
                                select="$quarkWalker => sort() => string-join(', ')"/></td>
                        <xsl:variable name="assocTitles" as="xs:string*"
                            select="$contributorLists//person[persName[. ! normalize-space() ! upper-case(.) = current()]]//title ! normalize-space() => distinct-values()"/>
                        <!-- This is just grabbing all the <title> elements in the same <person> element with this person across the collection. -->
                        <td>
                            <xsl:value-of select="$assocTitles => string-join(', ')"/>
                        </td>
                    </tr>

                </xsl:for-each>
            </table>
        </html>

    </xsl:template>



</xsl:stylesheet>
