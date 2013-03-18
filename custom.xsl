<?xml version="1.0"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    version="1.0">

  <xsl:import href="/usr/share/sgml/docbook/xsl-stylesheets/xhtml/chunk.xsl"/>

  <xsl:param name="base.dir">xhtml/</xsl:param>
  <xsl:param name="html.stylesheet">../users_guide.css</xsl:param>
  <xsl:param name="use.id.as.filename">1</xsl:param>
  <xsl:param name="toc.section.depth">3</xsl:param>
  <xsl:param name="section.autolabel">1</xsl:param>
  <xsl:param name="section.label.includes.component.label">1</xsl:param>
  <xsl:param name="css.decoration">0</xsl:param>
  <xsl:param name="ulink.target"></xsl:param>
  <xsl:param name="chunk.fast">1</xsl:param>
  <xsl:param name="tablecolumns.extension">0</xsl:param>
  <xsl:param name="header.rule">0</xsl:param>
  <xsl:param name="footer.rule">0</xsl:param>

  <xsl:template name="header.navigation">
    <xsl:param name="prev" select="/foo"/>
    <xsl:param name="next" select="/foo"/>
    <xsl:param name="nav.context"/>

    <xsl:variable name="home" select="/*[1]"/>
    <xsl:variable name="up" select="parent::*"/>

    <xsl:variable name="row1" select="count($prev) &gt; 0                                     or count($up) &gt; 0                                     or count($next) &gt; 0"/>

    <xsl:variable name="row2" select="($prev and $navig.showtitles != 0)                                     or (generate-id($home) != generate-id(.)                                         or $nav.context = 'toc')                                     or ($chunk.tocs.and.lots != 0                                         and $nav.context != 'toc')                                     or ($next and $navig.showtitles != 0)"/>

    <xsl:if test="$suppress.navigation = '0' and $suppress.header.navigation = '0'">
      <div class="navheader">
        <xsl:if test="$header.rule != 0">
          <hr/>
        </xsl:if>

        <xsl:if test="$row1 or $row2">
          <ul class="navi">
            <xsl:if test="count($next)&gt;0">
              <li class="next">
                <a accesskey="n">
                  <xsl:attribute name="href">
                    <xsl:call-template name="href.target">
                      <xsl:with-param name="object" select="$next"/>
                    </xsl:call-template>
                  </xsl:attribute>
                  <xsl:attribute name="title">
                    <xsl:apply-templates select="$next" mode="object.title.markup.textonly"/>
                  </xsl:attribute>
                  <span>
                    <xsl:call-template name="navig.content">
                      <xsl:with-param name="direction" select="'next'"/>
                    </xsl:call-template>
                  </span>
                </a>
              </li>
            </xsl:if>
            <xsl:if test="count($prev)&gt;0">
              <li class="prev">
                <a accesskey="p">
                  <xsl:attribute name="href">
                    <xsl:call-template name="href.target">
                      <xsl:with-param name="object" select="$prev"/>
                    </xsl:call-template>
                  </xsl:attribute>
                  <xsl:attribute name="title">
                    <xsl:apply-templates select="$prev" mode="object.title.markup.textonly"/>
                  </xsl:attribute>
                  <span>
                    <xsl:call-template name="navig.content">
                      <xsl:with-param name="direction" select="'prev'"/>
                    </xsl:call-template>
                  </span>
                </a>
              </li>
            </xsl:if>
            <xsl:if test="$home != . or $nav.context = 'toc'">
              <li class="up">
                <a accesskey="h" href=".">
                  <span>
                    <xsl:call-template name="navig.content">
                      <xsl:with-param name="direction" select="'home'"/>
                    </xsl:call-template>
                  </span>
                </a>
              </li>
            </xsl:if>
          </ul>
        </xsl:if>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template name="footer.navigation">
    <xsl:param name="prev" select="/foo"/>
    <xsl:param name="next" select="/foo"/>
    <xsl:param name="nav.context"/>

    <xsl:variable name="home" select="/*[1]"/>
    <xsl:variable name="up" select="parent::*"/>

    <xsl:variable name="row1" select="count($prev) &gt; 0                                     or count($up) &gt; 0                                     or count($next) &gt; 0"/>

    <xsl:variable name="row2" select="($prev and $navig.showtitles != 0)                                     or (generate-id($home) != generate-id(.)                                         or $nav.context = 'toc')                                     or ($chunk.tocs.and.lots != 0                                         and $nav.context != 'toc')                                     or ($next and $navig.showtitles != 0)"/>

    <xsl:if test="$suppress.navigation = '0' and $suppress.footer.navigation = '0'">
      <div class="navfooter">
        <xsl:if test="$footer.rule != 0">
          <hr/>
        </xsl:if>

        <xsl:if test="$row1 or $row2">
          <ul class="navi">
            <xsl:if test="count($next)&gt;0">
              <li class="next">
                <a accesskey="n">
                  <xsl:attribute name="href">
                    <xsl:call-template name="href.target">
                      <xsl:with-param name="object" select="$next"/>
                    </xsl:call-template>
                  </xsl:attribute>
                  <xsl:attribute name="title">
                    <xsl:apply-templates select="$next" mode="object.title.markup.textonly"/>
                  </xsl:attribute>
                  <span>
                    <xsl:call-template name="navig.content">
                      <xsl:with-param name="direction" select="'next'"/>
                    </xsl:call-template>
                  </span>
                </a>
              </li>
            </xsl:if>
            <xsl:if test="count($prev)&gt;0">
              <li class="prev">
                <a accesskey="p">
                  <xsl:attribute name="href">
                    <xsl:call-template name="href.target">
                      <xsl:with-param name="object" select="$prev"/>
                    </xsl:call-template>
                  </xsl:attribute>
                  <xsl:attribute name="title">
                    <xsl:apply-templates select="$prev" mode="object.title.markup.textonly"/>
                  </xsl:attribute>
                  <span>
                    <xsl:call-template name="navig.content">
                      <xsl:with-param name="direction" select="'prev'"/>
                    </xsl:call-template>
                  </span>
                </a>
              </li>
            </xsl:if>
            <xsl:if test="$home != . or $nav.context = 'toc'">
              <li class="up">
                <a accesskey="h" href=".">
                  <span>
                    <xsl:call-template name="navig.content">
                      <xsl:with-param name="direction" select="'home'"/>
                    </xsl:call-template>
                  </span>
                </a>
              </li>
            </xsl:if>
            <!--
            <li class="comment">
              <a>
                <xsl:attribute name="href">
                  <xsl:text>http://www.kotha.net/bbs/?prefix=%3E</xsl:text>
                  <xsl:value-of select="$custom.prefix"/>
                  <xsl:call-template name="href.target.uri">
                    <xsl:with-param name="object" select="."/>
                  </xsl:call-template>
                  <xsl:text>%0A</xsl:text>
                </xsl:attribute>
                <xsl:text>このページにコメントする</xsl:text>
              </a>
            </li>
            -->
          </ul>
        </xsl:if>
      </div>
    </xsl:if>
  </xsl:template>

  <!--
  <xsl:template name="user.footer.navigation">
    <ul>
      <li>
        <a>
          <xsl:attribute name="href">
            <xsl:text>http://www.kotha.net/bbs/bbs.cgi?prefix=%3E</xsl:text>
            <xsl:value-of select="$custom.prefix"/>
            <xsl:call-template name="href.target.uri">
              <xsl:with-param name="object" select="."/>
            </xsl:call-template>
            <xsl:text>%0A</xsl:text>
          </xsl:attribute>
          <xsl:text>このページにコメントする</xsl:text>
        </a>
      </li>
    </ul>
  </xsl:template>
  -->


  <xsl:template name="section.heading">
    <xsl:param name="section" select="."/>
    <xsl:param name="level" select="1"/>
    <xsl:param name="allow-anchors" select="1"/>
    <xsl:param name="title"/>
    <xsl:param name="class" select="'title'"/>

    <xsl:variable name="id">
      <xsl:choose>
        <!-- if title is in an *info wrapper, get the grandparent -->
        <xsl:when test="contains(local-name(..), 'info')">
          <xsl:call-template name="object.id">
            <xsl:with-param name="object" select="../.."/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="object.id">
            <xsl:with-param name="object" select=".."/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- HTML H level is one higher than section level -->
    <xsl:variable name="hlevel">
      <xsl:choose>
        <!-- highest valid HTML H level is H6; so anything nested deeper
             than 5 levels down just becomes H6 -->
        <xsl:when test="$level &gt; 5">6</xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$level + 1"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:element name="h{$hlevel}" namespace="http://www.w3.org/1999/xhtml">
      <xsl:attribute name="class"><xsl:value-of select="$class"/></xsl:attribute>
      <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
      <xsl:if test="$css.decoration != '0'">
        <xsl:if test="$hlevel&lt;3">
          <xsl:attribute name="style">clear: both</xsl:attribute>
        </xsl:if>
      </xsl:if>
      <xsl:copy-of select="$title"/>
    </xsl:element>
  </xsl:template>

  <xsl:template name="component.title">
    <xsl:param name="node" select="."/>

    <xsl:variable name="level">
      <xsl:choose>
        <xsl:when test="ancestor::section">
          <xsl:value-of select="count(ancestor::section)+1"/>
        </xsl:when>
        <xsl:when test="ancestor::sect5">6</xsl:when>
        <xsl:when test="ancestor::sect4">5</xsl:when>
        <xsl:when test="ancestor::sect3">4</xsl:when>
        <xsl:when test="ancestor::sect2">3</xsl:when>
        <xsl:when test="ancestor::sect1">2</xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- Let's handle the case where a component (bibliography, for example)
         occurs inside a section; will we need parameters for this? -->

    <xsl:element name="h{$level+1}" namespace="http://www.w3.org/1999/xhtml">
      <xsl:attribute name="class">title</xsl:attribute>
      <span>
        <xsl:attribute name="id">
          <xsl:call-template name="object.id">
            <xsl:with-param name="object" select="$node"/>
          </xsl:call-template>
        </xsl:attribute>
        <xsl:apply-templates select="$node" mode="object.title.markup">
          <xsl:with-param name="allow-anchors" select="1"/>
        </xsl:apply-templates>
      </span>
    </xsl:element>
  </xsl:template>

  <xsl:template match="title" mode="titlepage.mode">
    <xsl:variable name="id">
      <xsl:choose>
        <!-- if title is in an *info wrapper, get the grandparent -->
        <xsl:when test="contains(local-name(..), 'info')">
          <xsl:call-template name="object.id">
            <xsl:with-param name="object" select="../.."/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="object.id">
            <xsl:with-param name="object" select=".."/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <h1 class="{name(.)}" id="{$id}">
      <xsl:choose>
        <xsl:when test="$show.revisionflag != 0 and @revisionflag">
          <span class="{@revisionflag}">
            <xsl:apply-templates mode="titlepage.mode"/>
          </span>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates mode="titlepage.mode"/>
        </xsl:otherwise>
      </xsl:choose>
    </h1>
  </xsl:template>

  <xsl:template match="section/title" mode="titlepage.mode" priority="2">
    <xsl:call-template name="section.title"/>
  </xsl:template>

  <xsl:template match="sect1/title" mode="titlepage.mode" priority="2">
    <xsl:call-template name="section.title"/>
  </xsl:template>

  <xsl:template match="sect2/title" mode="titlepage.mode" priority="2">
    <xsl:call-template name="section.title"/>
  </xsl:template>

  <xsl:template match="sect3/title" mode="titlepage.mode" priority="2">
    <xsl:call-template name="section.title"/>
  </xsl:template>

  <xsl:template match="sect4/title" mode="titlepage.mode" priority="2">
    <xsl:call-template name="section.title"/>
  </xsl:template>

  <xsl:template match="sect5/title" mode="titlepage.mode" priority="2">
    <xsl:call-template name="section.title"/>
  </xsl:template>

  <xsl:template match="simplesect/title" mode="titlepage.mode" priority="2">
    <xsl:call-template name="section.title"/>
  </xsl:template>

  <xsl:template match="dedication/title" mode="titlepage.mode" priority="2">
    <xsl:call-template name="component.title">
      <xsl:with-param name="node" select="ancestor::dedication[1]"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="preface/title" mode="titlepage.mode" priority="2">
    <xsl:call-template name="component.title">
      <xsl:with-param name="node" select="ancestor::preface[1]"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="chapter/title" mode="titlepage.mode" priority="2">
    <xsl:call-template name="component.title">
      <xsl:with-param name="node" select="ancestor::chapter[1]"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="appendix/title" mode="titlepage.mode" priority="2">
    <xsl:call-template name="component.title">
      <xsl:with-param name="node" select="ancestor::appendix[1]"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="article/title" mode="titlepage.mode" priority="2">
    <xsl:call-template name="component.title">
      <xsl:with-param name="node" select="ancestor::article[1]"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="indexterm">
    <!-- this one must have a name, even if it doesn't have an ID -->
    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>

    <span id="{$id}" class="indexterm"></span>
  </xsl:template>

  <xsl:param name="local.l10n.xml" select="document('')"/>
  <l:i18n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0">
    <l:l10n language="ja">
      <l:gentext key="Index" text="索引"/>
      <l:gentext key="index" text="索引"/>

      <l:context name="xref-number-and-title">
        <l:template name="chapter" text="第%n章. %t"/>
        <l:template name="sect1" text="%n. %t"/>
        <l:template name="sect2" text="%n. %t"/>
        <l:template name="sect3" text="%n. %t"/>
        <l:template name="sect4" text="%n. %t"/>
        <l:template name="sect5" text="%n. %t"/>
        <l:template name="section" text="%n. %t"/>
      </l:context>
    </l:l10n>
  </l:i18n>

  <xsl:template name="process.footnotes">
    <xsl:variable name="footnotes" select=".//footnote"/>
    <xsl:variable name="fcount">
      <xsl:call-template name="count.footnotes.in.this.chunk">
        <xsl:with-param name="node" select="."/>
        <xsl:with-param name="footnotes" select="$footnotes"/>
      </xsl:call-template>
    </xsl:variable>

  <!--
    <xsl:message>
      <xsl:value-of select="name(.)"/>
      <xsl:text> fcount: </xsl:text>
      <xsl:value-of select="$fcount"/>
    </xsl:message>
  -->

    <!-- Only bother to do this if there's at least one non-table footnote -->
    <xsl:if test="$fcount &gt; 0">
      <dl class="footnotes">
        <xsl:call-template name="process.footnotes.in.this.chunk">
          <xsl:with-param name="node" select="."/>
          <xsl:with-param name="footnotes" select="$footnotes"/>
        </xsl:call-template>
      </dl>
    </xsl:if>

    <!-- FIXME: When chunking, only the annotations actually used
                in this chunk should be referenced. I don't think it
                does any harm to reference them all, but it adds
                unnecessary bloat to each chunk. -->
    <xsl:if test="$annotation.support != 0 and //annotation">
      <div class="annotation-list">
        <div class="annotation-nocss">
          <p>The following annotations are from this essay. You are seeing
          them here because your browser doesn&#8217;t support the user-interface
          techniques used to make them appear as &#8216;popups&#8217; on modern browsers.</p>
        </div>

        <xsl:apply-templates select="//annotation" mode="annotation-popup"/>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="footnote" name="process.footnote" mode="process.footnote.mode">
    <xsl:choose>
      <xsl:when test="local-name(*[1]) = 'para' or local-name(*[1]) = 'simpara'">
        <xsl:apply-templates/>
      </xsl:when>

      <!--
      <xsl:when test="$html.cleanup != 0 and function-available('exsl:node-set')">
        <div class="{name(.)}">
          <xsl:apply-templates select="*[1]" mode="footnote.body.number"/>
          <xsl:apply-templates select="*[position() &gt; 1]"/>
        </div>
      </xsl:when>
      -->

      <xsl:otherwise>
        <xsl:message>
          <xsl:text>Warning: footnote number may not be generated </xsl:text>
          <xsl:text>correctly; </xsl:text>
          <xsl:value-of select="local-name(*[1])"/>
          <xsl:text> unexpected as first child of footnote.</xsl:text>
        </xsl:message>
        <div class="{name(.)}">
          <xsl:apply-templates/>
        </div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tgroup//footnote" mode="process.footnote.mode">
  </xsl:template>

  <xsl:template match="footnote/para[1]|footnote/simpara[1]" priority="2">
    <!-- this only works if the first thing in a footnote is a para, -->
    <!-- which is ok, because it usually is. -->
    <xsl:variable name="name">
      <xsl:text>ftn.</xsl:text>
      <xsl:call-template name="object.id">
        <xsl:with-param name="object" select="ancestor::footnote"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="href">
      <xsl:text>#</xsl:text>
      <xsl:call-template name="object.id">
        <xsl:with-param name="object" select="ancestor::footnote"/>
      </xsl:call-template>
    </xsl:variable>
    <dt>
      <xsl:text>[</xsl:text>
      <a id="{$name}" href="{$href}">
        <xsl:apply-templates select="ancestor::footnote" mode="footnote.number"/>
      </a>
      <xsl:text>] </xsl:text>
    </dt>
    <dd>
      <p>
        <xsl:apply-templates/>
      </p>
    </dd>
  </xsl:template>

  <xsl:template match="*" mode="footnote.body.number">
    <xsl:variable name="name">
      <xsl:text>ftn.</xsl:text>
      <xsl:call-template name="object.id">
        <xsl:with-param name="object" select="ancestor::footnote"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="href">
      <xsl:text>#</xsl:text>
      <xsl:call-template name="object.id">
        <xsl:with-param name="object" select="ancestor::footnote"/>
      </xsl:call-template>
    </xsl:variable>

    <dt>
      <xsl:text>[</xsl:text>
      <a id="{$name}" href="{$href}">
        <xsl:apply-templates select="ancestor::footnote" mode="footnote.number"/>
      </a>
      <xsl:text>] </xsl:text>
    </dt>
    <dd>
      <xsl:apply-templates select="."/>
    </dd>
  </xsl:template>

  <xsl:template name="chunk.original"> <!-- copied intact from "chunk" template -->
    <xsl:param name="node" select="."/>
    <!-- returns 1 if $node is a chunk -->

    <!-- ==================================================================== -->
    <!-- What's a chunk?

         The root element
         appendix
         article
         bibliography  in article or part or book
         book
         chapter
         colophon
         glossary      in article or part or book
         index         in article or part or book
         part
         preface
         refentry
         reference
         sect{1,2,3,4,5}  if position()>1 && depth < chunk.section.depth
         section          if position()>1 && depth < chunk.section.depth
         set
         setindex
                                                                              -->
    <!-- ==================================================================== -->

  <!--
    <xsl:message>
      <xsl:text>chunk: </xsl:text>
      <xsl:value-of select="name($node)"/>
      <xsl:text>(</xsl:text>
      <xsl:value-of select="$node/@id"/>
      <xsl:text>)</xsl:text>
      <xsl:text> csd: </xsl:text>
      <xsl:value-of select="$chunk.section.depth"/>
      <xsl:text> cfs: </xsl:text>
      <xsl:value-of select="$chunk.first.sections"/>
      <xsl:text> ps: </xsl:text>
      <xsl:value-of select="count($node/parent::section)"/>
      <xsl:text> prs: </xsl:text>
      <xsl:value-of select="count($node/preceding-sibling::section)"/>
    </xsl:message>
  -->

    <xsl:choose>
      <xsl:when test="not($node/parent::*)">1</xsl:when>

      <xsl:when test="local-name($node) = 'sect1'                     and $chunk.section.depth &gt;= 1                     and ($chunk.first.sections != 0                          or count($node/preceding-sibling::sect1) &gt; 0)">
        <xsl:text>1</xsl:text>
      </xsl:when>
      <xsl:when test="local-name($node) = 'sect2'                     and $chunk.section.depth &gt;= 2                     and ($chunk.first.sections != 0                          or count($node/preceding-sibling::sect2) &gt; 0)">
        <xsl:call-template name="chunk">
          <xsl:with-param name="node" select="$node/parent::*"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="local-name($node) = 'sect3'                     and $chunk.section.depth &gt;= 3                     and ($chunk.first.sections != 0                          or count($node/preceding-sibling::sect3) &gt; 0)">
        <xsl:call-template name="chunk">
          <xsl:with-param name="node" select="$node/parent::*"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="local-name($node) = 'sect4'                     and $chunk.section.depth &gt;= 4                     and ($chunk.first.sections != 0                          or count($node/preceding-sibling::sect4) &gt; 0)">
        <xsl:call-template name="chunk">
          <xsl:with-param name="node" select="$node/parent::*"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="local-name($node) = 'sect5'                     and $chunk.section.depth &gt;= 5                     and ($chunk.first.sections != 0                          or count($node/preceding-sibling::sect5) &gt; 0)">
        <xsl:call-template name="chunk">
          <xsl:with-param name="node" select="$node/parent::*"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="local-name($node) = 'section'                     and $chunk.section.depth &gt;= count($node/ancestor::section)+1                     and ($chunk.first.sections != 0                          or count($node/preceding-sibling::section) &gt; 0)">
        <xsl:call-template name="chunk">
          <xsl:with-param name="node" select="$node/parent::*"/>
        </xsl:call-template>
      </xsl:when>

      <xsl:when test="local-name($node)='preface'">1</xsl:when>
      <xsl:when test="local-name($node)='chapter'">1</xsl:when>
      <xsl:when test="local-name($node)='appendix'">1</xsl:when>
      <xsl:when test="local-name($node)='article'">1</xsl:when>
      <xsl:when test="local-name($node)='part'">1</xsl:when>
      <xsl:when test="local-name($node)='reference'">1</xsl:when>
      <xsl:when test="local-name($node)='refentry'">1</xsl:when>
      <xsl:when test="local-name($node)='index' and ($generate.index != 0 or count($node/*) &gt; 0)                     and (local-name($node/parent::*) = 'article'                     or local-name($node/parent::*) = 'book'                     or local-name($node/parent::*) = 'part'                     )">1</xsl:when>
      <xsl:when test="local-name($node)='bibliography'                     and (local-name($node/parent::*) = 'article'                     or local-name($node/parent::*) = 'book'                     or local-name($node/parent::*) = 'part'                     )">1</xsl:when>
      <xsl:when test="local-name($node)='glossary'                     and (local-name($node/parent::*) = 'article'                     or local-name($node/parent::*) = 'book'                     or local-name($node/parent::*) = 'part'                     )">1</xsl:when>
      <xsl:when test="local-name($node)='colophon'">1</xsl:when>
      <xsl:when test="local-name($node)='book'">1</xsl:when>
      <xsl:when test="local-name($node)='set'">1</xsl:when>
      <xsl:when test="local-name($node)='setindex'">1</xsl:when>
      <xsl:when test="local-name($node)='legalnotice'                     and $generate.legalnotice.link != 0">1</xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="chunk">
    <xsl:param name="node" select="."/>

    <xsl:choose>
      <xsl:when test="local-name($node)='colophon'">0</xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="chunk.original">
          <xsl:with-param name="node" select="$node"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="colophon">
    <xsl:call-template name="id.warning"/>

    <div>
      <xsl:apply-templates select="." mode="class.attribute"/>
      <xsl:call-template name="dir">
        <xsl:with-param name="inherit" select="1"/>
      </xsl:call-template>
      <xsl:call-template name="language.attribute"/>
      <xsl:if test="$generate.id.attributes != 0">
        <xsl:attribute name="id">
          <xsl:call-template name="object.id"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
      <xsl:call-template name="process.footnotes"/>
    </div>
  </xsl:template>


</xsl:stylesheet>
