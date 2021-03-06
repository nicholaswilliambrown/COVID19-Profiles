<?xml version="1.0" encoding="UTF-8"?>
<?altova_samplexml SearchResults.xml?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:prns="http://profiles.catalyst.harvard.edu/ontology/prns#"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
                xmlns:vivo="http://vivoweb.org/ontology/core#"
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
                exclude-result-prefixes="fo xs fn prns rdf rdfs vivo foaf">
  <xsl:output method="html"/>
  <xsl:param name="searchfor"/>
  <xsl:param name="exactphrase"/>
  <xsl:param name="root"/>
  <xsl:param name="perpage">15</xsl:param>
  <xsl:param name="page">1</xsl:param>
  <xsl:param name="totalpages">1</xsl:param>  
  <xsl:param name="offset"/>
  <xsl:param name="why"  />  
  <xsl:param name="country"></xsl:param>

  <xsl:variable name="totalPages">

    <xsl:variable name="totalConnections">
      <xsl:choose>
        <xsl:when test="number(rdf:RDF/rdf:Description/prns:numberOfConnections)">
          <xsl:value-of select="number(rdf:RDF/rdf:Description/prns:numberOfConnections)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="number(1)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$totalConnections mod $perpage = 0">
        <xsl:value-of select="($totalConnections div $perpage)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="floor($totalConnections div $perpage) + 1"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:template match="/">

    <input type="hidden" id="txtSearchFor" value="{$searchfor}"/>
    <input type="hidden" id="txtExactPhrase" value="{$exactphrase}"/>    
    <input type="hidden" id="txtRoot" value="{$root}"/>
    <input type="hidden" id="txtPerPage" value="{$perpage}"/>
    <input type="hidden" id="txtOffset" value="{$offset}"/>
    <input type="hidden" id="txtTotalPages" value="{$totalpages}"/>    
    <input type="hidden" id="txtCountry" value="{$country}"/>

    <xsl:choose>
      <xsl:when test="number(rdf:RDF/rdf:Description/prns:numberOfConnections)">
        <xsl:variable name="document" select="rdf:RDF"></xsl:variable>        
        <xsl:choose>
          <xsl:when test="$why">
            <div style="float:right;margin-bottom:5px;margin-top:15px;">
              Click "Why?" to see why a person matched the search.
            </div>
          </xsl:when>
        </xsl:choose>        
        <div style="margin-bottom:5px;margin-top:15px;">
          Country&#160;
          <select id="selColSelect" style="width: 149px">
            <xsl:choose>
              <xsl:when test="$country='(All)'">
                <option selected="true" value="(All)">(All)</option>
              </xsl:when>
              <xsl:otherwise>
                <option value="(All)">(All)</option>
              </xsl:otherwise >
            </xsl:choose>
            <xsl:for-each select="/rdf:RDF/rdf:Description/Countries/Country">
              <xsl:choose>
                <xsl:when test="$country=@Name">
                  <option selected='true' value='{@Name}'>
                    <xsl:value-of select="@Name"/> (<xsl:value-of select="@Count"/>)
                  </option>
                </xsl:when>
                <xsl:otherwise>
                  <option value='{@Name}'>
                    <xsl:value-of select="@Name"/> (<xsl:value-of select="@Count"/>)
                  </option>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
          </select>
        </div>
        <table>
          <tr>
            <td colspan="3">
              <div class="listTable" style="margin-top:0px;">
                <table id="tblSearchResults" class="SearchResults">
                  <tbody>
                    <tr>
                      <th class="name-col">                  
                          Name                  
                      </th>                    
                      <th class="country-col">
                        Country
                      </th>
                      <th class="institution-col">
                        Institution
                      </th>
                      <xsl:choose>
                        <xsl:when test="$why">
                          <th>Why</th>
                        </xsl:when>
                      </xsl:choose>
                    </tr>
                    <xsl:for-each select="/rdf:RDF/rdf:Description/prns:hasConnection">
                      <xsl:variable name="nodeID" select="@rdf:nodeID"/>
                      <xsl:variable name="weight" select="/rdf:RDF/rdf:Description[@rdf:nodeID=$nodeID]/prns:connectionWeight"/>
                      <xsl:variable name="position" select="position()"/>
                      <xsl:for-each select="/rdf:RDF/rdf:Description[@rdf:nodeID=$nodeID]">
                        <xsl:variable name="nodeURI" select="rdf:object/@rdf:resource"/>
                        <tr>
                          <xsl:for-each select="/rdf:RDF/rdf:Description[@rdf:about=$nodeURI]">
                            <xsl:choose>
                              <xsl:when test="($position mod 2 = 1)">
                                <xsl:attribute name="class">oddRow</xsl:attribute>
                                <xsl:attribute name="onmouseout">HideDetails(this,1)</xsl:attribute>
                                <xsl:attribute name="onblur">HideDetails(this,1)</xsl:attribute>
                                <xsl:attribute name="onmouseover">
                                  ShowDetails('<xsl:value-of select="$nodeURI"/>',this)
                                </xsl:attribute>
                                <xsl:attribute name="onfocus">
                                  ShowDetails('<xsl:value-of select="$nodeURI"/>',this)
                                </xsl:attribute>
                                <xsl:attribute name="tabindex">0</xsl:attribute>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:attribute name="class">evenRow</xsl:attribute>
                                <xsl:attribute name="onmouseout">HideDetails(this,0)</xsl:attribute>
                                <xsl:attribute name="onblur">HideDetails(this,0)</xsl:attribute>
                                <xsl:attribute name="onmouseover">
                                  ShowDetails('<xsl:value-of select="$nodeURI"/>',this)
                                </xsl:attribute>
                                <xsl:attribute name="onFocus">
                                  ShowDetails('<xsl:value-of select="$nodeURI"/>',this)
                                </xsl:attribute>
                                <xsl:attribute name="tabindex">0</xsl:attribute>
                              </xsl:otherwise>
                            </xsl:choose>
                            <xsl:choose>
                              <xsl:when test="$why">
                                <xsl:call-template name="whyColumn">
                                  <xsl:with-param name="doc" select="$document"></xsl:with-param>
                                  <xsl:with-param name="nodeURI" select="$nodeURI"></xsl:with-param>
                                  <xsl:with-param name="weight" select ="$weight"></xsl:with-param>
                                  <xsl:with-param name="searchfor" select ="$searchfor"></xsl:with-param>
                                  <xsl:with-param name="exactphrase" select ="$exactphrase"></xsl:with-param>
                                  <xsl:with-param name="perpage" select ="$perpage"></xsl:with-param>
                                  <xsl:with-param name="offset" select ="$offset"></xsl:with-param>
                                  <xsl:with-param name="page" select ="$page"></xsl:with-param>
                                  <xsl:with-param name="totalpages" select ="$totalpages"></xsl:with-param>                                                                    
                                  <xsl:with-param name="country" select ="$currentcountry"></xsl:with-param>
                                  <xsl:with-param name="root" select ="$root"></xsl:with-param>

                                </xsl:call-template>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:call-template name="threeColumn">
                                  <xsl:with-param name="doc" select="$document"></xsl:with-param>
                                  <xsl:with-param name="nodeURI" select ="$nodeURI"></xsl:with-param>
                                  <xsl:with-param name="weight" select ="$weight"></xsl:with-param>
                                </xsl:call-template>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:for-each>
                        </tr>
                      </xsl:for-each>
                    </xsl:for-each>
                  </tbody>
                </table>
              </div>
            </td>
          </tr>
        </table>

        <div class="listTablePagination" style="float: left">
          <table>
            <tbody>
              <tr>
                <td>
                  Per Page&#160;<select id="ddlPerPage" title="Results per page" onchange="javascript:ChangePerPage()">
                    <xsl:choose>
                      <xsl:when test="$perpage='15'">
                        <option value="15" selected="true">15</option>
                      </xsl:when>
                      <xsl:otherwise>
                        <option value="15">15</option>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                      <xsl:when test="$perpage='25'">
                        <option value="25" selected="true">25</option>
                      </xsl:when>
                      <xsl:otherwise>
                        <option value="25">25</option>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                      <xsl:when test="$perpage='50'">
                        <option value="50" selected="true">50</option>
                      </xsl:when>
                      <xsl:otherwise>
                        <option value="50">50</option>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                      <xsl:when test="$perpage='100'">
                        <option value="100" selected="true">100</option>
                      </xsl:when>
                      <xsl:otherwise>
                        <option value="100">100</option>
                      </xsl:otherwise>
                    </xsl:choose>
                  </select>
                </td>
                <td>
                  &#160;&#160;Page&#160;<input size="1" type="textbox" value="{$page}" id="txtPageNumber" onchange="ChangePage()" onkeypress="JavaScript:changePage(event);" title="select page"/>&#160;of&#160;<xsl:value-of select="$totalpages"/>
                </td>
                <td>
                  <xsl:choose>
                    <xsl:when test="$page&lt;$totalpages">
                      <a href="JavaScript:GotoLastPage();" class="listTablePaginationFL listTablePaginationA">
                        <img src="{$root}/framework/images/arrow_last.gif" border="0" alt="last"/>
                      </a>
                      <a href="javascript:GotoNextPage();" class="listTablePaginationPN listTablePaginationN listTablePaginationA">
                        Next<img src="{$root}/framework/images/arrow_next.gif" border="0" alt="next"/>
                      </a>
                    </xsl:when>
                    <xsl:otherwise>
                      <div class="listTablePaginationFL">
                        <img src="{$root}/framework/images/arrow_last_d.gif" border="0" alt=""/>
                      </div>
                      <div class="listTablePaginationPN listTablePaginationN">
                        Next<img src="{$root}/framework/images/arrow_next_d.gif" border="0" alt=""/>
                      </div>
                    </xsl:otherwise>
                  </xsl:choose>
                  <xsl:choose>
                    <xsl:when test="$page&gt;1">
                      <a href="JavaScript:GotoPreviousPage();" class="listTablePaginationPN listTablePaginationP listTablePaginationA">
                        <img src="{$root}/framework/images/arrow_prev.gif" border="0" alt="previous"/>Prev
                      </a>
                      <a href="JavaScript:GotoFirstPage();" class="listTablePaginationFL listTablePaginationA">
                        <img src="{$root}/framework/images/arrow_first.gif" border="0" alt="first"/>
                      </a>
                    </xsl:when>
                    <xsl:otherwise>
                      <div class="listTablePaginationPN listTablePaginationP">
                        <img src="{$root}/framework/images/arrow_prev_d.gif" border="0" alt=""/>Prev
                      </div>
                      <div class="listTablePaginationFL">
                        <img src="{$root}/framework/images/arrow_first_d.gif" border="0" alt=""/>
                      </div>
                    </xsl:otherwise>
                  </xsl:choose>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </xsl:when>
      <xsl:otherwise>
        <div style="margin-top:100px;margin-bottom:200px;text-align:center">No people match your search.</div>
      </xsl:otherwise>
    </xsl:choose>

    <script language="JavaScript">


      var perpage = 0;
      var root = "";
      var searchfor =  "";
      var exactphrase = "";
      var classgroupuri = "";
      var classgroup = "";
      var page = 0;
      var totalpages = 0;      
      

      var country ="";

      var facrank = "";
      var offset = "";
      


      function changePage(e) {
      if (e.keyCode == 13) {
      ChangePage();
      }
      return false;
      }







      function GetPageData(){


          perpage = document.getElementById("ddlPerPage").value;
          root = document.getElementById("txtRoot").value;
          searchfor = document.getElementById("txtSearchFor").value;
          exactphrase = document.getElementById("txtExactPhrase").value;
          page = document.getElementById("txtPageNumber").value;
          totalpages = document.getElementById("txtTotalPages").value;      
          country =  document.getElementById("txtCountry").value;     
          offset = document.getElementById("txtOffset").value;

          if(page==0){
            page = 1;
          }


      }      

      function NavToPage(){


      window.location = root + '/search/default.aspx?searchtype=people<xsl:text disable-output-escaping="yes"><![CDATA[&]]></xsl:text>searchfor=' + searchfor + '<xsl:text disable-output-escaping="yes"><![CDATA[&]]></xsl:text>exactphrase=' + exactphrase + '<xsl:text disable-output-escaping="yes"><![CDATA[&]]></xsl:text>perpage=' + perpage + '<xsl:text disable-output-escaping="yes"><![CDATA[&]]></xsl:text>offset=' + offset + '<xsl:text disable-output-escaping="yes"><![CDATA[&]]></xsl:text>page=' + page + '<xsl:text disable-output-escaping="yes"><![CDATA[&]]></xsl:text>totalpages=' + totalpages + '<xsl:text disable-output-escaping="yes"><![CDATA[&]]></xsl:text>country=' + country;
      }

      function ChangePerPage(){
      GetPageData();      
      page = 1;
      NavToPage();

      }
      function ChangePage(){
      GetPageData();
      //its set from the dropdown list
      NavToPage();
      }
      function GotoNextPage(){

      GetPageData();
      page++;
      NavToPage();
      }
      function GotoPreviousPage(){
      GetPageData();
      page--;
      NavToPage();
      }
      function GotoFirstPage(){
      GetPageData();
      page = 1;
      NavToPage();
      }
      function GotoLastPage(){
      GetPageData();
      page = totalpages;
      NavToPage();
      }

      function ShowDetails(nodeURI,obj){

      doListTableRowOver(obj);

      }

      function HideDetails(obj,ord){
      doListTableRowOut(obj,ord);

      }



      <!--// create global code object if not already created-->
      if (undefined==ProfilesRNS) var ProfilesRNS = {};


      <!--// <START::SHOW/HIDE OTHER OPTIONS DROPDOWN LIST>-->
      $(document).ready(function() {

      // hide/show event occurs on click of dropdown
      $("#selColSelect").change(function() {
      debugger;
      $("#txtCountry").val($("#selColSelect option:selected").val());



      $("#ddlPerPage").val("");
      
      $("#txtPageNumber").val("1");
      $("#txtTotalPages").val("");
      
      


      GetPageData();
      NavToPage();

      });
      });


    </script>

  </xsl:template>


  <xsl:template name="threeColumn">
    <xsl:param name="doc"></xsl:param>
    <xsl:param name="nodeURI"></xsl:param>
    <xsl:param name="weight"></xsl:param>
    <xsl:variable name="positon" select="prns:personInPrimaryPosition/@rdf:resource"></xsl:variable>
    <xsl:variable name="institutionlabel" select="$doc/rdf:Description[@rdf:about=$positon]/vivo:positionInOrganization/@rdf:resource"></xsl:variable>
    <xsl:variable name="titlelink">
      <xsl:choose>
        <xsl:when test="vivo:preferredTitle!=''">
          &lt;br/&gt;&lt;br/&gt;&lt;u&gt;Title&lt;/u&gt; &lt;br/&gt;<xsl:value-of select="vivo:preferredTitle"/>
        </xsl:when>
        <xsl:otherwise>

        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="departmentlink">
      <xsl:choose>
        <xsl:when test="$doc/rdf:Description[@rdf:about=$doc/rdf:Description[@rdf:about=$positon]/prns:positionInDepartment/@rdf:resource]/rdfs:label!=''">
          &lt;br/&gt;&lt;br/&gt;&lt;u&gt;Department&lt;/u&gt;&lt;br/&gt;<xsl:value-of select="$doc/rdf:Description[@rdf:about=$doc/rdf:Description[@rdf:about=$positon]/prns:positionInDepartment/@rdf:resource]/rdfs:label"/>
        </xsl:when>
        <xsl:otherwise>

        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="institutionlink">
      <xsl:choose>
        <xsl:when test="$doc/rdf:Description[@rdf:about=$institutionlabel]!=''">
          &lt;br/&gt;&lt;u&gt;Institution&lt;/u&gt;&lt;br/&gt;<xsl:value-of select="$doc/rdf:Description[@rdf:about=$institutionlabel]"/>
        </xsl:when>
        <xsl:otherwise>

        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>




    <xsl:variable name="countrylink">
      <xsl:choose>
        <xsl:when test="$doc/rdf:Description[@rdf:about=$doc/rdf:Description[@rdf:about=$nodeURI]/vivo:mailingAddress/@rdf:resource]/rdfs:label">
          &lt;br/&gt;&lt;br/&gt;&lt;u&gt;Country&lt;/u&gt;&lt;br/&gt;<xsl:value-of select="$doc/rdf:Description[@rdf:about=$doc/rdf:Description[@rdf:about=$nodeURI]/vivo:mailingAddress/@rdf:resource]/rdfs:label"/>
        </xsl:when>
        <xsl:otherwise>

        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>


    <input type="hidden" id="{$nodeURI}" value="&lt;div style='font-size:13px;font-weight:bold'&gt;{foaf:firstName} {foaf:lastName}&lt;/div&gt;{$institutionlink}{$departmentlink}{$countrylink}"></input>

    <td class="name-col">
      <a class="listTableLink" href="{$nodeURI}">
        <xsl:value-of select="prns:fullName"/>
      </a>
    </td>
    <td class="country-col">
      <xsl:value-of select ="$doc/rdf:Description[@rdf:about=$doc/rdf:Description[@rdf:about=$nodeURI]/vivo:mailingAddress/@rdf:resource]/rdfs:label"/>
    </td>
    <td class="institution-col" >
      <xsl:value-of select ="$doc/rdf:Description[@rdf:about=$institutionlabel]"/>
    </td>
  </xsl:template>

  <xsl:template name="whyColumn">
    <xsl:param name="doc"></xsl:param>
    <xsl:param name="nodeURI"></xsl:param>
    <xsl:param name="weight"></xsl:param>
    <xsl:param name="searchfor"></xsl:param>
    <xsl:param name="exactphrase"></xsl:param>
    <xsl:param name="perpage"></xsl:param>
    <xsl:param name="offset"></xsl:param>
    <xsl:param name="page"></xsl:param>
    <xsl:param name="totalpages"></xsl:param>        
    <xsl:param name="root"></xsl:param>


    <xsl:variable name="positon" select="prns:personInPrimaryPosition/@rdf:resource"></xsl:variable>
    <xsl:variable name="bpositon" select="$doc/rdf:Description[@rdf:about=$positon]/vivo:positionInOrganization/@rdf:resource"></xsl:variable>

    <xsl:variable name="institutionlabel" select="$doc/rdf:Description[@rdf:about=$positon]/vivo:positionInOrganization/@rdf:resource"></xsl:variable>
    <td class="name-col">
      <a class="listTableLink" href="{$nodeURI}">
        <xsl:value-of select="prns:fullName"/>
      </a>
    </td>
    <td class="country-col">
      <xsl:value-of select ="$doc/rdf:Description[@rdf:about=$doc/rdf:Description[@rdf:about=$nodeURI]/vivo:mailingAddress/@rdf:resource]/rdfs:label"/>
    </td>
    <td class="institution-col">
      <xsl:value-of select ="$doc/rdf:Description[@rdf:about=$institutionlabel]"/>
    </td>    
    <td style="width:100px;text-align:center" >
      <a class="listTableLink"  href="{$root}/search/default.aspx?searchtype=whypeople&amp;nodeuri={$nodeURI}&amp;searchfor={$searchfor}&amp;exactphrase={$exactphrase}&amp;perpage={$perpage}&amp;offset={$offset}&amp;page={$page}&amp;totalpages={$totalpages}&amp;country={$country}">
        Why?
      </a>
      <xsl:variable name="titlelink">
        <xsl:choose>
          <xsl:when test="vivo:preferredTitle!=''">
            &lt;br/&gt;&lt;br/&gt;&lt;u&gt;Title:&lt;/u&gt; &lt;br/&gt;<xsl:value-of select="vivo:preferredTitle"/>
          </xsl:when>
          <xsl:otherwise>

          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <xsl:variable name="institutionlink">
        <xsl:choose>
          <xsl:when test="$doc/rdf:Description[@rdf:about=$institutionlabel]!=''">
            &lt;br/&gt;&lt;u&gt;Institution&lt;/u&gt;&lt;br/&gt;<xsl:value-of select="$doc/rdf:Description[@rdf:about=$institutionlabel]"/>
          </xsl:when>
          <xsl:otherwise>

          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <xsl:variable name="departmentlink">
        <xsl:choose>
          <xsl:when test="$doc/rdf:Description[@rdf:about=$doc/rdf:Description[@rdf:about=$positon]/prns:positionInDepartment/@rdf:resource]/rdfs:label!=''">
            &lt;br/&gt;&lt;br/&gt;&lt;u&gt;Department&lt;/u&gt;&lt;br/&gt;<xsl:value-of select="$doc/rdf:Description[@rdf:about=$doc/rdf:Description[@rdf:about=$positon]/prns:positionInDepartment/@rdf:resource]/rdfs:label"/>
          </xsl:when>
          <xsl:otherwise>

          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <xsl:variable name="countrylink">
        <xsl:choose>
          <xsl:when test="$doc/rdf:Description[@rdf:about=$doc/rdf:Description[@rdf:about=$nodeURI]/vivo:mailingAddress/@rdf:resource]/rdfs:label">
            &lt;br/&gt;&lt;br/&gt;&lt;u&gt;Country&lt;/u&gt;&lt;br/&gt;<xsl:value-of select="$doc/rdf:Description[@rdf:about=$doc/rdf:Description[@rdf:about=$nodeURI]/vivo:mailingAddress/@rdf:resource]/rdfs:label"/>
          </xsl:when>
          <xsl:otherwise>

          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>


      <input type="hidden" id="{$nodeURI}" value="&lt;div style='font-size:13px;font-weight:bold'&gt;{foaf:firstName} {foaf:lastName}&lt;/div&gt;{$institutionlink}{$departmentlink}{$countrylink}"></input>



    </td>
  </xsl:template>

</xsl:stylesheet>
