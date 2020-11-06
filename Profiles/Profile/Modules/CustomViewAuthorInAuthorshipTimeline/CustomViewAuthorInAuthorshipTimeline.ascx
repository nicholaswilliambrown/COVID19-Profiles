<%@ Control Language="C#" EnableViewState="true" AutoEventWireup="True" CodeBehind="CustomViewAuthorInAuthorshipTimeline.ascx.cs" Inherits="Profiles.Profile.Modules.CustomViewAuthorInAuthorshipTimeline.CustomViewAuthorInAuthorshipTimeline" %>


<div id="bar-histo-publication-list" class='publicationList'>

    <div id="divTimeline" style='margin-top: 6px;'>
        
		<div id="publicationTimelineGraph">
            <div class="timeline-heading" style="margin-bottom: 3px;">
                COVID-19 publications
            </div>
            <img id='covidTimelineBar' runat='server' border='0' />
            <div class="timeline-heading" style="margin-bottom: 3px; margin-top:10px;">
                All Publications
            </div>
            <img id='timelineBar' runat='server' border='0' />
            <div class="details-text" style="margin-bottom: 10px;">
                These graphs show COVID-19 publications by month since August 2019 and all publications written by authors of COVID-19 publications over the past 30 years.<br /><br /> To see the data from both graphs as text, <a id="divShowTimelineTable" tabindex="0">click here</a>.
            </div>
        </div>

        <div id="divTimelineTable" class="listTable" style="display: none; margin-top: 12px; margin-bottom: 8px;">
            <asp:Literal runat="server" ID="litTimelineTable"></asp:Literal>
            <div class="details-text" style="margin-bottom: 10px;">
                These graphs show COVID-19 publications by month since August 2019 and all publications written by authors of COVID-19 publications over the past 30 years.<br /> To return to the graphs, <a id="dirReturnToTimeline" tabindex="0">click here</a>.
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


