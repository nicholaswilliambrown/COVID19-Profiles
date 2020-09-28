<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NetworkDetails.ascx.cs" Inherits="Profiles.Profile.Modules.NetworkDetails.NetworkDetails" %>
<%--
    Copyright (c) 2008-2010 by the President and Fellows of Harvard College. All rights reserved.  
    Profiles Research Networking Software was developed under the supervision of Griffin M Weber, MD, PhD.,
    and Harvard Catalyst: The Harvard Clinical and Translational Science Center, with support from the 
    National Center for Research Resources and Harvard University.


    Code licensed under a BSD License. 
    For details, see: LICENSE.txt 
 --%>
<div>
    <div class="tabInfoText">
      Concepts are listed by decreasing relevance which is based on many factors, including how many publications the person wrote about that topic, how long ago those publications were written, and how many publications other people have written on that same topic.
    </div>
    <div class="listTable" style="margin-top: 12px, margin-bottom:8px ">
      <table id="thetable1">
        <tbody>
          <tr>
            <th class="alignLeft" style="width:250px;">Name</th>
            <th style="width: 110px;">
              Number of Publications
            </th>
            <th style="width: 115px;">
              Most Recent Publication
            </th>
            <th style="width: 80px;">
              Publications by All Authors
            </th>
            <th style="text-align: center;">
              Concept Score
            </th>
            <th style="width: 38px;">
              Why?
            </th>
          </tr>

              <asp:Literal runat='server' ID='litDetailsTableData' Visible="true"></asp:Literal>
          </tbody>
      </table>
    </div>
</div>
