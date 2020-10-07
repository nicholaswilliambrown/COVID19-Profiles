<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomViewConceptMeshInfo.ascx.cs" Inherits="Profiles.Profile.Modules.CustomViewConceptMeshInfo" %>

<div class="concept-profile-descriptor">
    "<%= this.ConceptName %>" is a descriptor in the National Library of Medicine's controlled vocabulary thesaurus, 
	<a href="http://www.nlm.nih.gov/mesh/" target="_blank">MeSH (Medical Subject Headings)</a>. Descriptors are arranged in a hierarchical structure, 
	which enables searching at various levels of specificity.
</div>

<div class="PropertyGroupItem">
    <div class="PropertyItemHeader">
        MeSH information
    </div>
    <div class="PropertyGroupData">
        <div id="meshInfo">
            <div style="display: -webkit-inline-box" id="divDisplayType">
                <div class="anchor-tab">
                    <div><a id='definitionLink' runat='server' class='selected' rel="#meshDefinition" href='javascript:void(0)'>Definition</a></div>
                    <div><a id='detailsLink' runat='server' rel="#meshDetails" href='javascript:void(0)'>Details</a></div>
                    <div><a id='generalConceptLink' runat='server' rel="#meshGeneralConcepts" href='javascript:void(0)'>More General Concepts</a></div>
                    <div><a id='relatedConceptLink' runat='server' rel="#meshRelatedConcepts" href='javascript:void(0)'>Related Concepts</a></div>
                </div>
                <div class="anchor-tab-last"><a id='specificConceptLink' class="link-visualization" runat='server' rel="#meshSpecificConcepts" href='javascript:void(0)'>More Specific Concepts</a></div>
            </div>
            <div id="meshDefinition" class='toggle-vis'>
                <asp:Literal ID="litDefinition" runat="server"></asp:Literal>
            </div>
            <div id="meshDetails" class='toggle-vis' style='display: none;'>
                <table>
                    <tbody>
                        <tr>
                            <td class='label'>Descriptor ID</td>
                            <td>
                                <asp:Literal ID="litDescriptorId" runat="server"></asp:Literal>
                            </td>
                        </tr>
                        <tr>
                            <td class='label'>MeSH Number(s)</td>
                            <td>
                                <asp:Literal ID="litMeshNumbers" runat="server"></asp:Literal>
                            </td>
                        </tr>
                        <tr>
                            <td class='label'>Concept/Terms</td>
                            <td>
                                <asp:Literal ID="litConceptTerms" runat="server"></asp:Literal>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div id="meshGeneralConcepts" class='toggle-vis' style='display: none;'>
                <p>Below are MeSH descriptors whose meaning is more general than "<%= this.ConceptName %>".</p>
                <div>
                    <ul>
                        <asp:Literal ID="litGeneralConcepts" runat="server"></asp:Literal>
                    </ul>
                </div>
            </div>

            <div id="meshRelatedConcepts" class='toggle-vis' style='display: none;'>
                <p>Below are MeSH descriptors whose meaning is related to "<%= this.ConceptName %>".</p>
                <div>
                    <ul>
                        <asp:Literal ID="litRelatedConcepts" runat="server"></asp:Literal>
                    </ul>
                </div>
            </div>

            <div id="meshSpecificConcepts" class='toggle-vis' style='display: none;'>
                <p>Below are MeSH descriptors whose meaning is more specific than "<%= this.ConceptName %>".</p>
                <div>
                    <ul>
                        <asp:Literal ID="litSpecificConcepts" runat="server"></asp:Literal>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<br />
<br />
<script type="text/javascript">


   
    if (screen.width < 600) {
        $(".anchor-tab-last").appendTo(".anchor-tab")
        $("#divDisplayType").css("display", "block");
    }
    else {
        $("#divDisplayType").css("display", "-webkit-inline-box");
    }


    $(function () {

        $("#divDisplayType a").on("click", function () {
            var $this = $(this);

            if ($this.get(0).className != "selected" && $this.get(0).className != "disabled") {
                $(".anchor-tab").children().find("a").removeClass("selected")
                $("#divDisplayType").children().find("a").removeClass("selected")
                // Show target element hiding currently visible
                $this.addClass("selected");



                $("#meshDefinition").hide();
                $("#meshDetails").hide();
                $("#meshGeneralConcepts").hide();
                $("#meshRelatedConcepts").hide();
                $("#meshSpecificConcepts").hide();


                switch ($this.get(0).rel) {
                    case "#meshDefinition":
                        $("#meshDefinition").show();
                        break;
                    case "#meshDetails":
                        $("#meshDetails").show();
                        break;
                    case "#meshGeneralConcepts":
                        $("#meshGeneralConcepts").show();                        
                        break;
                    case "#meshRelatedConcepts":
                        $("#meshRelatedConcepts").show();                        
                        break;
                    case "#meshSpecificConcepts":
                        $("#meshSpecificConcepts").show();                        
                        break;

                }
            }
        });

        $('#meshDetails a').bind('click', function () {
            var $this = $(this);
            $this.next('ul').toggle();
        });
    });
</script>
