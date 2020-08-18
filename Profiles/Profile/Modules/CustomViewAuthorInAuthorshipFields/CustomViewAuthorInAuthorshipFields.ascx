<%@ Control Language="C#" EnableViewState="true" AutoEventWireup="True" CodeBehind="CustomViewAuthorInAuthorshipFields.ascx.cs" Inherits="Profiles.Profile.Modules.CustomViewAuthorInAuthorshipFields.CustomViewAuthorInAuthorshipFields" %>


<div class='publicationList'>

    <div id="divFieldSummaryAlt" style='display: none; margin-top: 6px;' class="listTable">
		<div id="publicationJournalHeadingsAlt">
        </div>
        <div class="details-text" style="margin-bottom: 10px;">
            This graph shows the number and percent of publications by field.
            Fields are based on how the National Library of Medicine (NLM) classifies the publications' journals and might not represent the specific topics of the publications.
            Note that an individual publication can be assigned to more than one field. As a result, the publication counts in this graph might add up to more than the number of publications the person has written.
            To see the data as text, <a onclick="showFieldSummary()">click here</a>.
        </div>
    </div>
    <div id="divFieldSummary" style='margin-top: 6px;'>
        <div id="publicationJournalHeadings">
            <div id="piechart"></div>
        </div>
        <div class="details-text" style="margin-bottom: 10px;">
            This graph shows the number and percent of publications by field.
            Fields are based on how the National Library of Medicine (NLM) classifies the publications' journals and might not represent the specific topics of the publications.
            Note that an individual publication can be assigned to more than one field. As a result, the publication counts in this graph might add up to more than the number of publications the person has written.
            To see the data as text, <a onclick="showFieldSummaryAlt()">click here</a>.
        </div>
    </div>
</div>

<script type="text/javascript">
 

    function showFieldSummaryAlt()
    {
        $("#divFieldSummaryAlt").show();
        $("#divFieldSummary").hide();
    }

    function showFieldSummary() {
        $("#divFieldSummaryAlt").hide();
        $("#divFieldSummary").show();
    }

     setTimeout(function () {

        drawChart();
    }, 800);


</script>
<!--<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>-->
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script type="text/javascript">

    // Load the Visualization API and the piechart package.
    google.charts.load('current', { 'packages': ['corechart'] });

    // Set a callback to run when the Google Visualization API is loaded.
    //google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
        var jsonData = $.ajax({
            url: "<%= svcURL %><%= nodeID %>",
            dataType: "json",
            async: false
        }).responseText;

        // Create our data table out of JSON data loaded from server.
        var data = new google.visualization.DataTable(jsonData);

        var colors = jsonData.substring(jsonData.lastIndexOf('\"colors\": \"[#') + 12, jsonData.indexOf("]", jsonData.lastIndexOf('\"colors\": \"[#') + 12));     
        var colorArray = colors.split(",");
        //colorArray = ['#4E79A7', '#F28E2B', '#E15759', '#76B7B2', '#59A14F', '#EDC948', '#B07AA1', '#FF9DA7', '#9C755F', '#BAB0AC'];
        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.PieChart(document.getElementById('piechart'));
        chart.draw(data, { width: 680, height: 300, fontSize: 12, colors: colorArray, legend: {alignment: 'center'}, chartArea: {left:20,top:20,width:'90%',height:'90%'}, tooltip: { text: 'percentage' } });

        var altTableText = jsonData.substring(jsonData.lastIndexOf('\"altTxtTable\": \"') + 16, jsonData.indexOf("</table>", jsonData.lastIndexOf('\"altTxtTable\": \"') + 16) + 5);
        document.getElementById("publicationJournalHeadingsAlt").innerHTML = altTableText;

    }

</script>

