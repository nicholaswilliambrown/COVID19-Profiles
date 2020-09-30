<%@ Control Language="C#" EnableViewState="true" AutoEventWireup="True" CodeBehind="CustomViewAuthorInAuthorshipTimeline.ascx.cs" Inherits="Profiles.Profile.Modules.CustomViewAuthorInAuthorshipTimeline.CustomViewAuthorInAuthorshipTimeline" %>


<div id="bar-histo-publication-list" class='publicationList'>

    <div id="divTimeline" style='margin-top: 6px;'>
        
		<div id="publicationTimelineGraph">
            <img id='covidTimelineBar' runat='server' border='0' />
            <div id="divYearTable" style='margin-top: -6px; margin-bottom:-12px;'>
                <table><tr><td width="20"></td><td width="148"><span style="color:grey; font-size:smaller">2019</span></td><td><span style="color:grey; font-size:smaller">2020</span></td></tr></table>
            </div>
            <img id='timelineBar' runat='server' border='0' />
            <div class="details-text" style="margin-bottom: 10px;">
                This graph shows the total number of publications by year. To see the data as text, <a id="divShowTimelineTable" tabindex="0">click here</a>.
            </div>
        </div>

        <div id="divTimelineTable" class="listTable" style="display: none; margin-top: 12px; margin-bottom: 8px;">
            <asp:Literal runat="server" ID="litTimelineTable"></asp:Literal>
            <div class="details-text" style="margin-bottom: 10px;">
                This graph shows the total number of publications by year. To return to the graph, <a id="dirReturnToTimeline" tabindex="0">click here</a>.
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $("#divShowTimelineTable").on("click", function () {
        $("#divTimelineTable").show();
        $("#publicationTimelineGraph").hide();
    });

    jQuery("#divShowTimelineTable").on("keypress", function (e) {
        if (e.keyCode == 13) {
            $("#divTimelineTable").show();
            $("#publicationTimelineGraph").hide();
        }
    });



    $("#dirReturnToTimeline").bind("click", function () {

        $("#divTimelineTable").hide();
        $("#publicationTimelineGraph").show();
    });

    jQuery("#dirReturnToTimeline").bind("keypress", function (e) {
        if (e.keyCode == 13) {
            $("#divTimelineTable").hide();
            $("#publicationTimelineGraph").show();
        }
    });

</script>
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>


