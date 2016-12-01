﻿<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="CourseListing.aspx.vb" Inherits="CourseListing" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
        &nbsp;</p>
    <p>
        Please select a topic, enter in a city name, or choose a date from the calendar, and click search to see any available courses.</p>
    <p>
        <br />
    </p>
      <div><div style="float:left;width:209px">
          Course Topic: 
       <asp:DropDownList ID="topicslist" runat="server" DataSourceID="sqltopics" 
              DataTextField="Topic" DataValueField="Topic" AutoPostBack="True">
       </asp:DropDownList>
          </div>
          <div style="float:left;width:221px"> City: <asp:TextBox ID="cityBox" runat="server" 
                  style="margin-top: 0" AutoPostBack="True"></asp:TextBox>
        </div>
          <div style="float:left;width:289px; height: 22px;">Course Date: 
              <asp:TextBox id="courseDate" runat="server" AutoPostBack="True"></asp:TextBox><button type="button" class="btn btn-info bth-lg" data-toggle="modal" data-target="#myModal">...</button>
          </div>
          <div style="float:left;width:243px"><asp:Button CssClass="btn btn-primary" ID="searchButton" runat="server" Text="Search" />
        </div>
          <br />
      </div>
    <p>
        <asp:SqlDataSource ID="sqltopics" runat="server" ConnectionString="<%$ ConnectionStrings:M418_group3ConnectionString %>" SelectCommand="SELECT topicCode AS Topic FROM platformTopic"></asp:SqlDataSource>
    </p>
    <p>
        </p>
    <p>
        <asp:GridView ID="Courses" CssClass="table table-striped table-bordered table-hover" runat="server" Width="811px" AutoGenerateColumns="False" DataSourceID="sqlCourses" AllowSorting="True" Height="82px" DataKeyNames="Workshop Number">
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
                    <asp:BoundField DataField="Location" HeaderText="Location" SortExpression="Location" />
                    <asp:BoundField DataField="Date &amp; Time" HeaderText="Date &amp; Time" SortExpression="Date &amp; Time" />
                    <asp:BoundField DataField="Topic" HeaderText="Topic" SortExpression="Topic" />
                    <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
                    <asp:BoundField DataField="Hosting Firm" HeaderText="Hosting Firm" SortExpression="Hosting Firm" />
                    <asp:BoundField DataField="Workshop Number" HeaderText="Workshop Number" InsertVisible="False" ReadOnly="True" SortExpression="Workshop Number" />
                </Columns>
        </asp:GridView>
            </p>

        <asp:SqlDataSource ID="sqlCourses" runat="server" 
        ConnectionString="<%$ ConnectionStrings:M418_group3ConnectionString %>" 
        SelectCommand="SELECT platformWorkshop.city AS City, platformWorkshop.location AS Location, platformWorkshop.dateTime AS [Date &amp; Time], platformTopic.topicCode AS Topic, platformWorkshop.price AS Price, platformFirm.firmName AS [Hosting Firm], platformWorkshop.workshopID AS [Workshop Number] FROM platformWorkshop INNER JOIN platformTopic ON platformWorkshop.topicID = platformTopic.topicID INNER JOIN platformFirm ON platformWorkshop.firmID = platformFirm.firmID WHERE (platformTopic.topicCode = @topic) AND (@city is null or platformWorkshop.city LIKE @city) AND (@date is null or platformWorkshop.dateTime &gt;= @date)" 
        CancelSelectOnNullParameter="False">
                <SelectParameters>
                    <asp:ControlParameter ControlID="topicslist" Name="topic" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="cityBox" Name="city" PropertyName="Text" />
                    <asp:ControlParameter ControlID="courseDate" Name="date" PropertyName="Text" />
                </SelectParameters>
        </asp:SqlDataSource>

<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
      
    <!-- Modal content-->
    <div class="modal-content">
        
      <div class="modal-body">
        <p>
            <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" Width="350px">
            <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
            <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
            <OtherMonthDayStyle ForeColor="#999999" />
            <SelectedDayStyle BackColor="#333399" ForeColor="White" />
            <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
            <TodayDayStyle BackColor="#CCCCCC" /></asp:Calendar>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal" id="test">Close</button>
      </div>
    </div>

  </div>
</div>
</asp:Content>