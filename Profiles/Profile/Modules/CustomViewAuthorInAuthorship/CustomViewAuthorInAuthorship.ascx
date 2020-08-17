<%@ Control Language="C#" EnableViewState="true" AutoEventWireup="True" CodeBehind="CustomViewAuthorInAuthorship.ascx.cs" Inherits="Profiles.Profile.Modules.CustomViewAuthorInAuthorship.CustomViewAuthorInAuthorship" %>


<div class='publicationList'>


    <div style="font-weight: bold; color: #888; padding: 5px 0px;" id="divPubHeaderText" visible="true" runat="server">
        Publications listed below are automatically derived from MEDLINE/PubMed and other sources, which might result in incorrect or missing publications. 		
    </div>
    <table><tr><td>
    <div class="anchor-tab" id="divPublicationType">
        <b>Show:</b>&nbsp;&nbsp;&nbsp;&nbsp;
        <a tabindex="0" id="aAllPubs" href="?Publications=All" runat="server">All coronarirus related publications</a>
        &nbsp; | &nbsp; 
        <a tabindex="0" id="aCoronaPubs" href="?Publications=Coronavirus" runat="server">Covid-19 specific publications</a>
        &nbsp; | &nbsp; 
        <a tabindex="0" id="aCovidPubs" href="?Publications=Covid-19" runat="server">All publications</a>

    </div>
    </td></tr><tr><td>
    <div class="anchor-tab" id="divDisplayType">
        <b>Sort By:</b>&nbsp;&nbsp;&nbsp;&nbsp;
        <a class='selected' tabindex="0" id="aNewest">Newest</a>
        &nbsp; | &nbsp; 
        <a tabindex="0" id="aOldest">Oldest</a>
        &nbsp; | &nbsp; 
        <a tabindex="0" id="aMostCited">Most Cited</a>
        &nbsp; | &nbsp; 
              <a tabindex="0" id="aMostDiscussed">Most Discussed</a>
    </div>
    </td></tr></table>
    <div id="divPubListDetails" class="details-text">
        <span class="details-text-highlight">PMC Citations</span> indicate the number of times the publication was cited by articles in PubMed Central, and the <span class="details-text-highlight">Altmetric</span> score represents citations in news articles and social media.
        (Note that publications are often cited in additional ways that are not shown here.)
        <span class="details-text-highlight">Fields</span> are based on how the National Library of Medicine (NLM) classifies the publication's journal and might not represent the specific topic of the publication.
        <span class="details-text-highlight">Translation</span> tags are based on the publication type and the MeSH terms NLM assigns to the publication.
        Some publications (especially newer ones and publications not in PubMed) might not yet be assigned Field or Translation tags.)
        Click a Field or Translation tag to filter the publications.
    </div>
    <div id="divPubList">
        <asp:Repeater ID="rpPublication" runat="server" OnItemDataBound="rpPublication_OnDataBound">
            <HeaderTemplate>
                <div id="publicationListAll" class="publications">
                    <ol>
            </HeaderTemplate>
            <ItemTemplate>
                <li runat="server" id="liPublication">
                    <div>
                        <asp:Label runat="server" ID="lblPublicationAuthors"></asp:Label>
                        <asp:Label runat="server" ID="lblPublication"></asp:Label>
                        <asp:Label runat="server" ID="lblPublicationIDs"></asp:Label>
                    </div>
                    <div runat="server" id="divArticleMetrics" class="article-metrics">
                        <asp:Literal runat="server" ID="litViewIn"></asp:Literal>
                    </div>
                </li>
            </ItemTemplate>
            <FooterTemplate>
                </ol>	
			    </div>				
            </FooterTemplate>
        </asp:Repeater>

    </div>
    <div id="divFiltered" style='display: none; margin-top: 6px;' class="publications">
        <ol id="ulFiltered">
        </ol>
    </div>





    <div class="publications-plain-text-options" style="display:none">
       <label class="publications-plain-text-options">Start with:</label>
        <input class="form-check-input" type="radio" checked style="margin-left:5px;margin-right:2px;" id="rdoNewest" name="pubradios" onclick="generatePlainText()"/>newest
        <input class="form-check-input" type="radio" style="margin-left:5px;margin-right:2px;" id="rdoOldest" name="pubradios" onclick="generatePlainText()"/>oldest
        <label style="margin-left:30px;">Include:</label>
        <input class="form-check-input" type="checkbox" style="margin-left:5px;margin-right:2px;" id="chkLineNumbers" onclick="generatePlainText()" checked />line numbers
        <input class="form-check-input" type="checkbox" style="margin-left:5px;margin-right:2px;" id="chkDoubleSpacing" onclick="generatePlainText()" checked />double spacing
        <input class="form-check-input" type="checkbox" style="margin-left:5px;margin-right:2px;" id="chkAllAuthors" onclick="generatePlainText()" checked />all authors
        <input class="form-check-input" type="checkbox" style="margin-left:5px;margin-right:2px;" id="chkPubIDs" onclick="generatePlainText()" checked />publication IDs
        <textarea id="txtPublications-text-options" style="margin-top:10px;" rows="24" cols="100" readonly></textarea>
    </div>
    <div id="divPlainText"></div>
</div>

<div class="SupportText">
    <asp:Literal runat='server' ID='supportText'></asp:Literal>
</div>

<script type="text/javascript">
    var flipped = false;





    
    

    $("#divDisplayType a").on("click", function () {
        
        var $this = $(this);
        if ($this.get(0).className != "selected") {
            $this.addClass("selected");
            $this.siblings("a").removeClass("selected");

            $("#divPlainText").hide();
            $(".publications-plain-text-options").hide();
            //$("#divTimeline").hide();
            //$("#divFieldSummary").hide();
            $("#divPubList").hide();
            $("#divFiltered").hide();
            $("#divPubListDetails").hide();
            //$("#divFieldSummaryAlt").hide();

            switch ($this.get(0).id) {
                case "aNewest":
                    sortby = "newest";
                    applyFilters();
                    break;
                case "aOldest":
                    sortby = "oldest";
                    applyFilters();
                    break;
                case "aMostCited":
                    sortby = "citations";
                    applyFilters();
                    break;
                case "aMostDiscussed":
                    sortby = "altmetric";
                    applyFilters();
                    break;
                case "aTimeline":
                    $("#divTimeline").show();                    
                    break;
                case "aFieldSummary":
                    $("#divFieldSummary").show();
                    drawChart();
                    break;
                case "aPlainText":
                    generatePlainText();
                    $("#divPlainText").show();
                    $(".publications-plain-text-options").show();                    
                    break;
            }


        }
    });


    $(".xxxpublicationList .anchor-tab a").bind("keypress", function (e) {
        if (e.keyCode == 13) {
            var $this = $(this);
            if ($this.get(0).className != "selected") {
                // Toggle link classes
                $this.toggleClass("selected").siblings("a").toggleClass("selected");
                // Show hide;
                $("div.publicationList .toggle-vis:visible").hide().siblings().fadeIn("fast");
            }
        }
    });


    setTimeout(function () {
   
        $.getScript('//d1bxh8uas1mnw7.cloudfront.net/assets/embed.js');
    }, 1000);


    setTimeout(function () {
        $(function () {
            $('span.altmetric-embed').on('altmetric:hide', function () {
                var y = document.getElementsByClassName('altmetric-hidden');
                for (var i = 0; i < y.length; i++) {
                    var pmid = y[i].attributes["data-pmid"].value;

                    var spn = document.getElementById("spnHideOnNoAltmetric" + pmid);
                    var parent = spn.parentNode;
                    if (parent.children.length == 1) parent.parentNode.removeChild(parent);
                    //else parent.removeChild(spn);
                    //y.classList.remove('altmetric-embed');
                    spn.innerHTML = '';
                }
            });           
            
        });

    }, 900);
    

    function toggleFilter(filterValue) {
        var addFilter = true;
        for (var i = 0; i < filterArray.length; i++) {
            if (filterArray[i] == filterValue) {
                filterArray.splice(i, 1);
                addFilter = false;
            }
        }
        if (addFilter) filterArray.push(filterValue);
        applyFilters();
    }

    var sortby = "newest";
    var filterArray = [];

    function applyFilters() {
        var lis = document.getElementById("publicationListAll").getElementsByTagName("li");
        var ulSorted = document.getElementById("ulFiltered");
        //if (ulSortByAltmetric.getElementsByTagName("li").length > 0) return;
        while (ulSorted.lastChild) {
            ulSorted.removeChild(ulSorted.lastChild);
        }
        var array = [];
        for (var i = 0; i < lis.length; i++) {
            var item = lis[i];
            var dateRank = 10000;
            var altmetricScore = 0;
            var pmcCitations = 0;
            try {

                var url = item.getElementsByTagName("img")[0].attributes["src"].value;
                var spl = url.split("/")
                var val = spl[spl.length - 1];
                altmetricScore = val.replace(".png", "");
            }
            catch (err) {
            }
            var item = lis[i].cloneNode(true);
            try {
                pmcCitations = item.attributes["data-citations"].value;
            }
            catch (err) {}
            if (filterArray.length > 0) {
                for (var j = 0; j < filterArray.length; j++) {
                    try {
                        var tmp = item.attributes[filterArray[j]].value;
                        if (tmp != 1) break;
                        var links = item.getElementsByTagName("a")
                        for (var k = 0; k < links.length; k++)
                        {
                            try {
                                if (links[k].getAttribute("onclick").indexOf(filterArray[j]) !== -1)
                                {
                                    var colour = links[k].attributes["data-color"].value;
                                    links[k].setAttribute("style", "border-color:" + colour + ";background-color:" + colour + ";color:#FFF");
                                }
                            } catch (err) { }
                        }
                        if (j == filterArray.length - 1) array.push({ altmetricScore: altmetricScore, pmcCitations: pmcCitations, dateRank: i, element: item });
                    }
                    catch (err) { break; }
                }
            }
            else {
                array.push({ altmetricScore: altmetricScore, pmcCitations: pmcCitations, dateRank: i, element: item });
            }
        }
        if (sortby == "newest") array.sort(function (a, b) { return a.dateRank - b.dateRank; })
        else if (sortby == "oldest") array.sort(function (a, b) { return b.dateRank - a.dateRank; })
        else if (sortby == "citations") array.sort(function (a, b) { if (b.pmcCitations == a.pmcCitations) return a.dateRank - b.dateRank; else return b.pmcCitations - a.pmcCitations; })
        else if (sortby == "altmetric") array.sort(function (a, b) { if (b.altmetricScore == a.altmetricScore) return a.dateRank - b.dateRank; else return b.altmetricScore - a.altmetricScore; })
        for (var i = 0; i < array.length; i++) {
            var el = array[i].element.cloneNode(true);
            if (i == 0) el.classList.add("first");
            else el.classList.remove("first");
            ulSorted.appendChild(el);
        }
        $("#divPubList").hide();
        $("#divFiltered").show();
        $("#divPubListDetails").show();
        $.getScript('//d1bxh8uas1mnw7.cloudfront.net/assets/embed.js');
        
    }


    function generatePlainText() {
        var newestFirst = document.getElementById("rdoNewest").checked;
        var lineNumbers = document.getElementById("chkLineNumbers").checked;
        var doubleSpacing = document.getElementById("chkDoubleSpacing").checked;
        var allAuthors = document.getElementById("chkAllAuthors").checked;
        var ids = document.getElementById("chkPubIDs").checked;

        var lis = document.getElementById("publicationListAll").getElementsByTagName("li");
        var text = "";
        for (var i = 0; i < lis.length; i++) {
            //text = text + i +  " aaa<br>";
            var item;
            if (newestFirst) item = lis[i];
            else item = lis[lis.length - i - 1];

            var dateRank = 10000;
            var altmetricScore = 0;
            var pmcCitations = 0;
            try {
                //jsonData.substring(jsonData.lastIndexOf('\"colors\": \"[#') + 12, jsonData.length - 4);
                var pubReference = item.getElementsByTagName("span")[1].textContent;
                var authors = pubReference.substring(0, pubReference.indexOf('.'));
                if (!allAuthors) {
                    var comma = authors.indexOf(",")
                    if (comma > 0) comma = authors.indexOf(",", comma + 1)
                    if (comma > 0) comma = authors.indexOf(",", comma + 1)
                    if (comma > 0/* && comma != authors.lastIndexOf(',')*/) authors = authors.substring(0, comma) + ", et al";
                    
                }
                var title = pubReference.substring(pubReference.indexOf('.') + 2, pubReference.length);

                if (lineNumbers) text = text + (i + 1) + ". ";
                text = text + authors + '. ';
                text = text + title;
                if (ids) text = text + item.getElementsByTagName("span")[2].textContent;
                text = text + "\r\n";
                if (doubleSpacing) text = text + "\r\n";

            }
            catch (err) {
            }
            var item = lis[i].cloneNode(true);
        }
        document.getElementById("txtPublications-text-options").textContent = text;
        
    }

</script>
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

