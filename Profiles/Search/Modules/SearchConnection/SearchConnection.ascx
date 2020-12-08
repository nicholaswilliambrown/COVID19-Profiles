<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SearchConnection.ascx.cs"
    Inherits="Profiles.Search.Modules.SearchConnection" %>
<script> jQuery(document).ready(function (e) { jQuery('.body-page').show(); }) </script>
<div id="search-results">
<asp:Panel runat="server" ID="pnlDirectConnection" Visible="false">
    <div style="padding-top: 12px; padding-bottom: 12px;">
        One or more keywords in your search matched the following properties of
        <asp:Literal runat="server" ID="litPersonURI"></asp:Literal>
    </div>
    <div>
        <asp:GridView  ID="gvConnectionDetails" AutoGenerateColumns="false" GridLines="Both"
            CellSpacing="-1" runat="server" OnRowDataBound="gvConnectionDetails_OnRowDataBound" CssClass="listTable">
            <HeaderStyle CssClass="topRow" BorderStyle="None" />
            <RowStyle CssClass="oddRow"/>
            <AlternatingRowStyle CssClass="evenRow" />
            <Columns>
                <asp:TemplateField HeaderText="Property"
                    HeaderStyle-Width="200px">
                    <ItemTemplate>
                        <asp:Literal runat="server" ID="litProperty"></asp:Literal>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Value">
                    <ItemTemplate>
                        <asp:Literal runat="server" ID="litValue"></asp:Literal>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Panel>
<asp:Panel runat="server" ID="pnlIndirectConnection" Visible="false">
    <div style="padding-top: 12px; padding-bottom: 12px;">
        One or more keywords in your search matched the following properties of
        <asp:Literal runat="server" ID="litSubjectName"></asp:Literal>
    </div>
    <div>
        <asp:GridView  ID="gvIndirectConnectionDetails" AutoGenerateColumns="false"
            GridLines="Both" CellSpacing="-1" runat="server" OnRowDataBound="gvIndirectConnectionDetails_OnRowDataBound" CssClass="listTable">
            <HeaderStyle CssClass="topRow" BorderStyle="None" />
            <RowStyle CssClass="oddRow" />
            <AlternatingRowStyle CssClass="evenRow"/>
            <Columns>
                <asp:TemplateField HeaderText="Item Type"
                    HeaderStyle-Width="200px">
                    <ItemTemplate>
                        <asp:Literal runat="server" ID="litProperty"></asp:Literal>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Name">
                    <ItemTemplate>
                        <asp:Literal runat="server" ID="litValue"></asp:Literal>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Panel>
    </div>
<script type="text/javascript">
    var url = jQuery('.masterpage-backlink').attr('href');
    url = url.replace("[[[discovertab]]]", GetParameterValues('tab'));    


    function GetParameterValues(param) {
        var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
        for (var i = 0; i < url.length; i++) {
            var urlparam = url[i].split('=');
            if (urlparam[0] == param) {
                return urlparam[1];
            }
        }
    }
</script>




