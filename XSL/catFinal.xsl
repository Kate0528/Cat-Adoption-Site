<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
  version="2.0">
  <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" name="html"/>
  <xsl:include href="blockAndInlineElements.xsl"/>
  <xsl:template match="/">
    <xsl:call-template name="pageHome"/>
    <xsl:call-template name="pageAbout"/>
    <xsl:call-template name="pageFullView">
      <xsl:with-param name="navType" select="'hierarchy'"/>
    </xsl:call-template>
    <xsl:call-template name="pageFullView">
      <xsl:with-param name="navType" select="'index'"/>
    </xsl:call-template>
    <xsl:call-template name="pageFullView">
      <xsl:with-param name="navType" select="'sequence'"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="pageFullView">
    <xsl:param name="navType"/>
    <xsl:for-each select="//cat">
      <xsl:variable name="itemId" select="@id"/>
      <xsl:result-document href="../html/{$itemId}_{$navType}.html" format="html">
        <html>
          <head>
            <title><xsl:value-of select="//about/title"></xsl:value-of></title>
            <meta charset="utf-8">
              <xsl:text> </xsl:text>
            </meta>
            <link href="css/cat.css" rel="stylesheet">
              <xsl:text> </xsl:text>
            </link>
          </head>
          <body>
            <div class="page">
              <div class="bannerLogoArea">
                <xsl:call-template name="bannerLogo"></xsl:call-template>
              </div>
              <div class="bannerArea">
                <xsl:call-template name="bannerArea"/>
              </div>
              <div class="localNavArea">
                <xsl:call-template name="localNavSwitch">
                  <xsl:with-param name="navType" select="$navType"/>
                </xsl:call-template>
              </div>
              <div class="contentArea">
                <xsl:call-template name="fullView">
                  <xsl:with-param name="itemId" select="$itemId"/>
                  <xsl:with-param name="navType" select="$navType"/>
                </xsl:call-template>
              </div>
            </div>
          </body>
        </html>
      </xsl:result-document>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="pageHome">
    <xsl:result-document href="../html/index.html" format="html">
      <html>
        <head>
          <title><xsl:value-of select="//about/title"></xsl:value-of></title>
          <meta charset="utf-8">
            <xsl:text> </xsl:text>
          </meta>
          <link href="css/cat.css" rel="stylesheet">
            <xsl:text> </xsl:text>
          </link>
        </head>
        <body>
          <div class="page">
            <div class="bannerLogoArea">
              <xsl:call-template name="bannerLogo"></xsl:call-template>
            </div>
            <div class="bannerArea">
              <xsl:call-template name="bannerArea"/>
            </div>
            <div class="contentArea">
              <xsl:call-template name="partialViews"></xsl:call-template>
            </div>
          </div>
        </body>
      </html>
    </xsl:result-document>
  </xsl:template>
  <xsl:template name="pageAbout">
    <xsl:result-document href="../html/about.html" format="html">
      <html>
        <head>
          <title><xsl:value-of select="//about/title"></xsl:value-of></title>
          <meta charset="utf-8">
            <xsl:text> </xsl:text>
          </meta>
          <link href="css/cat.css" rel="stylesheet">
            <xsl:text> </xsl:text>
          </link>
        </head>
        <body>
          <div class="page">
            <div class="bannerLogoArea">
              <xsl:call-template name="bannerLogo"></xsl:call-template>
            </div>
            <div class="bannerArea">
              <xsl:call-template name="bannerArea"/>
            </div>
            <div class="contentArea">
              <h1>About the Website and the Author</h1>
              <h2>About the Website</h2>
              <h>Website Name: <xsl:value-of select="//about/title"/></h>
              <h2>About the Author</h2>
              <xsl:apply-templates select="//about/description"></xsl:apply-templates>
              <h2>About the Sources</h2>
              <p>Please note all listed cats has already been adopted during this semester.</p>
              <xsl:for-each select="//sourceDefs/sourceDef">
              <p>
                <a href="{url}"><xsl:value-of select="name"/></a>
              </p>
              </xsl:for-each>
            </div>
          </div>
        </body>
      </html>
    </xsl:result-document>
  </xsl:template>
  <xsl:template name="bannerLogo"><a href="index.html" class="globalTitleItem"><img src="images/CATS.jpg" alt="Cat Adoption" style="width:200px;height:156px;"/></a>
  </xsl:template>
  <xsl:template name="bannerArea">
    <a href="index.html" class="globalNavItem"><xsl:value-of select="//about/title"/>     
    </a>
    <a href="index.html" class="globalNavItem">Home</a>
    <a href="about.html" class="globalNavItem">About</a>
    <a href="CAT_40667429_hierarchy.html" class="globalNavItem">Hierarchy</a>
    <a href="CAT_40667429_index.html" class="globalNavItem">Index</a>
    <a href="CAT_40722652_sequence.html" class="globalNavItem">Sequence</a>
  </xsl:template>
  <xsl:template name="fullView">
    <xsl:param name="itemId"/>
    <xsl:param name="navType"></xsl:param>
    <xsl:for-each select="//cat[@id=$itemId]">
      <xsl:variable name="sourceId"><xsl:value-of select="name"/></xsl:variable>
      <xsl:variable name="jpgURL">images/<xsl:value-of select="images/image/@fileName"/></xsl:variable>
      <h1><xsl:value-of select="name"/></h1>
      <div class="partialViewContent">
        <img class="partialViewImage"><xsl:attribute name="src">
          <xsl:value-of select="$jpgURL"/>
        </xsl:attribute></img>
        <table><xsl:attribute name="id">
          <xsl:value-of select="concat('Species_',substring($itemId,5))"/>
        </xsl:attribute>
          <tr>
            <td>Animal ID</td>
            <td><xsl:value-of select ="substring($itemId,5)"/></td>
          </tr>
          <tr>
            <td>Species</td>
            <td><xsl:value-of select ="substring($itemId,1,3)"/></td>
          </tr>
          <tr>
            <td>Breed</td>
            <td><xsl:value-of select="specs/breed"/></td>
          </tr>
          <tr>
            <td>Age</td>
            <td><xsl:value-of select="@age"/></td>
          </tr>
          <tr>
            <td>Gender</td>
            <td><xsl:value-of select="specs/gender"/></td>
          </tr>
          <tr>
            <td>Size</td>
            <td><xsl:value-of select="specs/size"/></td>
          </tr>
          <tr>
            <td>Color</td>
            <td><xsl:value-of select="specs/color"/></td>
          </tr>
          <tr>
            <td>Spayed</td>
            <td><xsl:choose>
              <xsl:when test="specs/spayed='true'">
                Yes
              </xsl:when>
              <xsl:otherwise>No</xsl:otherwise>
            </xsl:choose></td>
          </tr>
          <tr>
            <td>Declawed</td>
            <td><xsl:choose>
              <xsl:when test="specs/declawed='true'">
                Yes
              </xsl:when>
              <xsl:otherwise>No</xsl:otherwise>
            </xsl:choose></td>
          </tr>
          <tr>
            <td>adoptionPrice</td>
            <td><xsl:value-of select="adoptionPrice"/></td>
          </tr>
          <tr>
            <td>location</td>
            <td><xsl:value-of select="location"/></td>
          </tr>
          <tr>
            <td>Site</td>
            <td><xsl:value-of select="site"/></td>
          </tr>
        </table>
        <xsl:apply-templates select="description"></xsl:apply-templates>       
        <p>source: 
          <a href="{../../sourceDefs/sourceDef/url}"><xsl:value-of select="../../sourceDefs/sourceDef[name=$sourceId]/name"/></a>
        </p>
      </div>
      <div class="relatedContent">
        <xsl:call-template name="associationView">
          <xsl:with-param name="navType" select="$navType" />
        </xsl:call-template>
      </div>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="partialViews">
    <xsl:for-each select="//cat">
      <xsl:variable name="jpgURL">images/<xsl:value-of select="images/image/@fileName"/></xsl:variable>
      <div class="partialViewArea">    
        <table>
          <tr>
            <a href="{@id}_index.html">
            <img width="200" height="250"><xsl:attribute name="src">
              <xsl:value-of select="$jpgURL"/>
            </xsl:attribute></img>
            </a>
          </tr>
          <tr>
            <td>Name</td>
            <td>
            <a href="{@id}_index.html">
              <xsl:value-of select="name"/>
            </a>
            </td>
          </tr>
          <tr>
            <td>Breed</td>
            <td><a href="{@id}_hierarchy.html"><xsl:value-of select="specs/breed"/></a></td>
          </tr>
          <tr>
            <td>Age</td>
            <td><a href="{@id}_sequence.html"><xsl:value-of select="@age"/></a></td>
          </tr>
        </table>    
        
      </div>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="localNavSwitch">
    <xsl:param name="navType"></xsl:param>
    <xsl:choose>
      <xsl:when test="$navType='hierarchy'"> 
        <xsl:call-template name="hierachyView"></xsl:call-template>
      </xsl:when>
      <xsl:when test="$navType ='index'">
        <xsl:call-template name="indexView"></xsl:call-template>
      </xsl:when>
      <xsl:when test="$navType='sequence'">
        <xsl:call-template name="sequenceView"></xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <p>You passed an unknown type: <xsl:value-of select="$navType"/></p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="hierachyView">
    <h1>Hierarcy</h1>
    <xsl:for-each select="//breeds/breed">
      <xsl:call-template name="doOneLine">
        <xsl:with-param name="indent" select="'10'"/>
      </xsl:call-template>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="doOneLine">
    <xsl:param name="indent"/>
    <p style="margin-left: {$indent}px;margin-top:0px;margin-bottom:0px;">
      <xsl:value-of select="name"/>
    </p>
    <xsl:for-each select="catRefId">
      <xsl:variable name="currItemId" select="."/>
      <p style="margin-left: {number($indent)+10}px;margin-top:0px;margin-bottom:0px;">
        <a href="{$currItemId}_hierarchy.html">
          <xsl:value-of select="//cat[@id=$currItemId]/name"/>
        </a>
      </p>
    </xsl:for-each>
    <xsl:for-each select="breed">
      <xsl:call-template name="doOneLine">
        <xsl:with-param name="indent" select="number($indent)+10"/>
      </xsl:call-template>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="indexView">
    <h1>Alphabetical Index</h1>
    <xsl:for-each select="//alphabeticalIndex/letter">
      <xsl:sort select="name"/>
      <p><xsl:value-of select="name"/></p> 
      <xsl:for-each select="catRefId">
        <xsl:variable name="catRefId" select="."/>
        <a href="{//cat[@id= $catRefId]/@id}_index.html">
          <xsl:value-of select="//cat[@id=$catRefId]/name"/>
        </a>
        <br/>
      </xsl:for-each>
    </xsl:for-each>    </xsl:template>
  <xsl:template name="associationView">
    <xsl:param name="navType"></xsl:param>
    <p>You might like</p>
    <ul>
      <xsl:for-each select="relatedCats/catRefId">
        <xsl:variable name="relatedCatId" select="."/>
        <li><a href="{$relatedCatId}_{$navType}.html"><xsl:value-of select="//cat[@id=$relatedCatId]/name"/></a></li>
      </xsl:for-each>
    </ul>
  </xsl:template>
  <xsl:template name="sequenceView">
    <h1>Sequences</h1>
    <xsl:for-each select="//sequence">
      <hr/>
      <h2>
        <xsl:value-of select="@age"/>
      </h2>
      <ul>
        <xsl:for-each select="catRefId">
          <xsl:variable name="catRefId" select="."/>
          <li>
            <a href="{//cat[@id= $catRefId]/@id}_sequence.html">
              <xsl:value-of select="//cat[@id= $catRefId]/@age"/>
            </a>
          </li>
        </xsl:for-each>
      </ul>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
