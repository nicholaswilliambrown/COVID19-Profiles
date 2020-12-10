<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomViewPersonGeneralInfo.ascx.cs"
    Inherits="Profiles.Profile.Modules.CustomViewPersonGeneralInfo.CustomViewPersonGeneralInfo" %>
<table style="width: 100%;margin-bottom:10px;">
    <tr>
        <td class="personal-info">
            <asp:Literal runat="server" ID="litPersonalInfo"></asp:Literal>
        </td>
        <td class="personal-photo">
            <div id="regions_div" style="width: 200px;"></div>
        </td>
    </tr>
</table>
<div id="toc">
    <ul></ul>
    <div style="clear: both;"></div>
</div>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
    //import { Script } from "vm";

    google.charts.load('current', {
        'packages': ['geochart'],
        // Note: you will need to get a mapsApiKey for your project.
        // See: https://developers.google.com/chart/interactive/docs/basic_load_libs#load-settings
        'mapsApiKey': ''
    });
    google.charts.setOnLoadCallback(drawRegionsMap);

    function drawRegionsMap() {
        var data = google.visualization.arrayToDataTable([['Country', ''], ['<%= mapCountry %>', 82]]);


        var options = {
              <%= mapRegion %>
            legend: 'none',
            tooltip: { trigger: 'none' },
            colorAxis: { colors: ['#B23F45', '#B23F45'] }
        };

        var chart = new google.visualization.GeoChart(document.getElementById('regions_div'));

        chart.draw(data, options);
    }
</script>
