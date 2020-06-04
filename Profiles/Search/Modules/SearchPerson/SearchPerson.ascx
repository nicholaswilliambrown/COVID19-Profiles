<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SearchPerson.ascx.cs"
    Inherits="Profiles.Search.Modules.SearchPerson.SearchPerson" EnableViewState="true" %>

<script type="text/javascript">


    function runScript(e) {
        if (e.keyCode == 13) {
            search();
        }
        return false;
    }

    function search() {

        document.getElementById("<%=hdnSearch.ClientID%>").value = "true"
        document.forms[0].submit();
    }

</script>

<asp:HiddenField ID="hdnSearch" runat="server" Value="hdnSearch"></asp:HiddenField>
<div class="content_container">
    <div class="tabContainer">
        <div class="searchForm">

            <%-- New class to replace inline heading styles --%>
            <div class="headings">
                Find researchers
            </div>

            <div class="searchSection" id="divSearchSection">
                <table class='searchForm'>
                    <tr>
                        <th>Keywords: 
                                        </th>
                        <td colspan="2" class="fieldOptions">
                            <asp:TextBox runat="server" ID="txtSearchFor" CssClass="search-text-box" title="Keywords"></asp:TextBox>
                        </td>
                        <td colspan="1">
                            <div class="search-button-container">
                                <%--Inline styles on this is no longer needed as the button is now all CSS--%>
                                <a href="JavaScript:search();" class="search-button">
                                    <%--    No longer need a search button as an image--%>
                                    <%--<img src="<%=GetURLDomain()%>/Search/Images/search.jpg" style="border: 0;" alt="Search" />--%>
                                                        Search
                                                    </a>
                            </div>
                        </td>
                    </tr>
                    <tr runat="server" id="trInstitution">
                        <th>Country: 
                                        </th>
                        <td colspan="2">
                            <asp:Literal runat="server" ID="litInstitution"></asp:Literal>
                        </td>
                    </tr>
                </table>
            </div>

        </div>
    </div>
</div>
<script>$(document).ready(function () {
        $("[id*=ddlChkList]").css("width", "249px");
        $("select").css("height", "25px");

    });</script>
