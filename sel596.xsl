<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0">

    <xsl:output method="html"/>

    <xsl:template match="/">
        <html>
            <head>
            </head>
            <body>
                <div style="max-width: 600px; margin: 0px auto; x-column-count: 2; x-column-gap: 40px;">
                    <xsl:apply-templates select="/tei:TEI/tei:text/tei:body/*"/>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="tei:entry">
        <span style="display: block; line-height: 1.5em; margin: 1.5em 0 1.5em -1em; text-indent: -1em;" xml:space="preserve">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:sense">
        <span style="display: block; margin: 0.5em 0 0.5em 0.5em; min-height: 1.5em; text-indent: 0em;">
            <xsl:variable name="bullet">
                <xsl:choose>
                    <xsl:when test="@n"><xsl:value-of select="@n"/></xsl:when>
                    <xsl:otherwise>▪</xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <span style="float: left; font-weight: bold; color: #999999"><xsl:value-of select="$bullet"/></span>
            <span style="display: block; margin-left: 1.5em;"><xsl:apply-templates/></span>
        </span>
    </xsl:template>

    <xsl:template match="tei:form[tei:gramGrp and not(position()=1)]">
        <span style="display: block; margin: 0.5em 0 0.5em 0.5em; min-height: 1.5em;">
            <span style="float: left; font-weight: bold; color: #999999">›</span>
            <span style="display: block; margin-left: 1.5em;"><xsl:apply-templates/></span>
        </span>
    </xsl:template>

    <xsl:template match="tei:orth">
        <span style="font-family: Arial;">
            <xsl:apply-templates/>
        </span>
        <xsl:if test="following-sibling::node()[1][name()='orth']"><xsl:text> </xsl:text><span style="color: #999999">|</span><xsl:text> </xsl:text></xsl:if>
    </xsl:template>

    <xsl:template match="tei:form[@type='lemma' or @type='compound']//tei:orth
        | tei:form[1][parent::tei:entry or parent::tei:entryFree or parent::tei:superEntry or parent::tei:re]/tei:orth[not(preceding-sibling::*)]
        | tei:form[1][not(*) and (parent::tei:entry or parent::tei:entryFree or parent::tei:superEntry or parent::tei:re)]">
        <span style="font-family: Arial; font-weight: bold; text-shadow: 0px 0px 1px #999999;">
            <xsl:apply-templates/>
        </span>
        <xsl:if test="following-sibling::*[1][name()='orth']"><xsl:text> </xsl:text><span style="color: #999999">|</span><xsl:text> </xsl:text></xsl:if>
    </xsl:template>

    <xsl:template match="tei:def | tei:etym | tei:note">
        <xsl:apply-templates/>
        <xsl:if test="following-sibling::*[1][name()='def' or name()='etym' or name()='note' or (name()='cit' and (@type='translation' or @type='trans')) or name()='quote']">
            <xsl:text> </xsl:text><span style="color: #999999">|</span><xsl:text> </xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="tei:cit">
        <xsl:apply-templates/>
        <xsl:if test="following-sibling::node()[1][name()='cit']"><xsl:text> </xsl:text><span style="color: #999999">|</span><xsl:text> </xsl:text></xsl:if>
    </xsl:template>

    <xsl:template match="tei:quote">
        <span style="font-family: Arial; font-weight: bold; color: #666666;">
            <xsl:apply-templates/>
        </span>
        <xsl:if test="following-sibling::*[1][name()='quote']"><xsl:text> </xsl:text><span style="color: #999999">|</span><xsl:text> </xsl:text></xsl:if>
    </xsl:template>

    <xsl:template match="tei:cit[@type='translation' or @type='trans']/tei:quote">
        <span style="font-family: Arial; text-shadow: 0px 0px 1px #999999;">
            <xsl:apply-templates/>
        </span>
        <xsl:if test="following-sibling::*[1][name()='quote' or name()='def' or name()='note']"><xsl:text> </xsl:text><span style="color: #999999">|</span><xsl:text> </xsl:text></xsl:if>
    </xsl:template>

    <xsl:template match="tei:cit/tei:cit[@type='translation' or @type='trans']/tei:quote">
        <span style="font-family: Arial; font-style: italic; color: #666666;">
            <xsl:apply-templates/>
        </span>
        <xsl:if test="following-sibling::*[1][name()='quote' or name()='def' or name()='note']"><xsl:text> </xsl:text><span style="color: #999999">|</span><xsl:text> </xsl:text></xsl:if>
    </xsl:template>

    <xsl:template match="tei:gram|tei:gen|tei:number|tei:case|tei:mood|tei:pos|tei:subc|tei:gramGrp[not(*)]">
        <span style="font-family: Arial; color: #000066; background-color: #eeeeee; padding: 1px 5px; border-radius: 2px;">
            <xsl:choose>
                <xsl:when test="text()|*"><xsl:apply-templates/></xsl:when>
                <xsl:otherwise><xsl:value-of select="@value"/></xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>

    <xsl:template match="tei:colloc">
        <span style="font-family: Arial; border: 1px solid #aaaaaa; padding: 0px 5px; border-radius: 2px;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:lang">
        <span style="color: #666666; font-style: italic;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:xr[not(tei:ref)]">
        <span style="border-bottom: 1px dotted #006600; font-family: Arial;">
            <xsl:choose>
                <xsl:when test="text()|*"><xsl:apply-templates/></xsl:when>
                <xsl:otherwise><xsl:value-of select="@target"/></xsl:otherwise>
            </xsl:choose>
            <xsl:text>&#160;</xsl:text> <!-- non-breaking space -->
            <span style="color: #006600; font-weight: bold;">›</span>
        </span>
        <xsl:if test="following-sibling::node()[1][name()='ref' or name()='xr']"><xsl:text> </xsl:text><span style="color: #cccccc">|</span><xsl:text> </xsl:text></xsl:if>
    </xsl:template>
</xsl:stylesheet>
