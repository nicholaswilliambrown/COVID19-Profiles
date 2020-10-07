<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SearchMap.ascx.cs" Inherits="Profiles.Search.Modules.SearchMap.SearchMap" %>
<%--
    Copyright (c) 2008-2012 by the President and Fellows of Harvard College. All rights reserved.  
    Profiles Research Networking Software was developed under the supervision of Griffin M Weber, MD, PhD.,
    and Harvard Catalyst: The Harvard Clinical and Translational Science Center, with support from the 
    National Center for Research Resources and Harvard University.


    Code licensed under a BSD License. 
    For details, see: LICENSE.txt 
--%>


<asp:Literal runat="server" ID="litJS"></asp:Literal>

<script>

    window.geoStats = window.geoStats || {};
   
    geoStats.drawGeoChart_World = function drawGeoChart_World() {
        
        var data = countries;

        var data_table = new google.visualization.DataTable();

        data_table.addColumn('string', 'Country');
        data_table.addColumn('number', 'Researchers');

        geoStats.populateDataTable_GeoChart(data_table, data);        

        var options = {
            colorAxis: {
                colors: ["#cbdcf2", "#77a3e0"]
            }
        }; 

        var chart = new google.visualization.GeoChart(document.getElementById("geo-chart-world"));

        function myClickHandler() {
            var selection = chart.getSelection();
            var message = '';
            for (var i = 0; i < selection.length; i++) {
                var item = selection[i];
                if (item.row != null) {
                    message += countries[item.row].Country;
                }
            }
            if (message == '') {
                return false;
            }
            window.location = "country.aspx?country=" + message;
        }

        google.visualization.events.addListener(chart, 'select', myClickHandler);

        chart.draw(data_table, options);
    }


    geoStats.populateDataTable_GeoChart = function populateDataTable_GeoChart(dataTable, dataToAdd) {
        for (idx in dataToAdd) {
            row = dataToAdd[idx];
            dataTable.addRow([row.Country, Number(row.Count)]);
        }
    }

    geoStats.processResearchers = function processResearchers(data) {
        
        $("#geo-top-researchers").html('');
        $(data).each(function (index, item) {
            $("#geo-top-researchers").append("<div style='display:flex;margin-bottom:2px;'><div style='margin-right:5px;width:16px;text-align:center'>" + geoStats.getCountryCode(item.Country) + "</div><div><a href='" + item.URI + "'>" + item.Name + "</a></div></div>");
        });


    }
    geoStats.getCountryCode = function getCountryCode(countryName) {
        var returnValue = "";
        
        //var countrycodes is loaded from the server into a litJS control. 
        var filteredList = countrycodes.filter(function (item) {
            return item.name === countryName;
        });
        if (filteredList[0]) {
            return "<img src='modules/searchmap/flags/" + filteredList[0].code.toLowerCase() + ".gif'>";
        }
        return returnValue;
    }


    $(document).ready(function () {
        

        google.charts.load('current', {
            'callback': geoStats.drawGeoChart_World,
            'packages': ['geochart'],           
            'mapsApiKey': '<%= googleKey %>'
         });
        var researcherdata = researchers;        
        
        geoStats.processResearchers(researcherdata);

        
        

    });


</script>


<div style="width: 100%; margin-bottom: 25px; display: inline-flex">
    <div class="headings-top-authors">
        <div class="headings">Top authors</div>
        <div id="geo-top-researchers" style="margin-right: 15%; width: 200px"></div>
    </div>

    <div class="headings-authors-by-country">
        <div class="headings">Browse authors by country</div>
        <div id="geo-chart-world" class="geo-chart" style="width: 600px;">           
        </div>        
    </div>
</div>
