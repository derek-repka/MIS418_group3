﻿<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Cart.aspx.vb" Inherits="Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="container" style="margin-top: 20px">
      <div class="col-md-10 col-md-offset-1">
                
            <!-- start of cart Workshop Data Source -->
            <asp:SqlDataSource ID="cartWorkshopDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:M418_group3ConnectionString %>" SelectCommand="SELECT platformWorkshop.city, platformWorkshop.location, platformWorkshop.dateTime, platformWorkshop.price AS workshopPrice, platformOrderLine.quantity, platformTopic.topicCode, platformOrderLine.orderLineID FROM platformUser INNER JOIN platformOrder ON platformUser.userID = platformOrder.userID INNER JOIN platformOrderLine ON platformOrder.orderID = platformOrderLine.orderID INNER JOIN platformWorkshop ON platformOrderLine.workshopID = platformWorkshop.workshopID LEFT OUTER JOIN platformTopic ON platformWorkshop.topicID = platformTopic.topicID WHERE (platformUser.userID = @userID) AND (platformOrder.orderStatusID = 1)" DeleteCommand="DELETE FROM platformOrderLine WHERE (orderLineID = @orderLineID)">                                  
                <DeleteParameters>
                    <asp:Parameter Name="orderLineID" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="-1" Name="userID" SessionField="id" />
                </SelectParameters>
            </asp:SqlDataSource>

            <!-- start of cart eCourse Data Source -->
            <asp:SqlDataSource ID="carteCourseDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:M418_group3ConnectionString %>" SelectCommand="SELECT platformOrderLine.quantity, platformProduct.productName, platformProduct.price AS productPrice, platformStyle.styleDescription, platformOrderLine.orderLineID FROM platformUser INNER JOIN platformOrder ON platformUser.userID = platformOrder.userID INNER JOIN platformOrderLine ON platformOrder.orderID = platformOrderLine.orderID INNER JOIN platformProduct ON platformOrderLine.productID = platformProduct.productID LEFT OUTER JOIN platformStyle ON platformProduct.styleID = platformStyle.styleID WHERE (platformOrder.orderStatusID = 1) AND (platformUser.userID = @userID) AND (platformProduct.styleID = 2)" DeleteCommand="DELETE FROM platformOrderLine WHERE (orderLineID = @orderLineID)">
                <DeleteParameters>
                    <asp:Parameter Name="orderLineID" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="-1" Name="userID" SessionField="id" />
                </SelectParameters>
            </asp:SqlDataSource>
            
            <!-- start of cart Product Data Source -->
            <asp:SqlDataSource ID="cartProductDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:M418_group3ConnectionString %>" SelectCommand="SELECT platformOrderLine.quantity, platformProduct.productName, platformProduct.price AS productPrice, platformStyle.styleDescription, platformOrderLine.orderLineID FROM platformUser INNER JOIN platformOrder ON platformUser.userID = platformOrder.userID INNER JOIN platformOrderLine ON platformOrder.orderID = platformOrderLine.orderID INNER JOIN platformProduct ON platformOrderLine.productID = platformProduct.productID LEFT OUTER JOIN platformStyle ON platformProduct.styleID = platformStyle.styleID WHERE (platformOrder.orderStatusID = 1) AND (platformUser.userID = @userID) AND (platformProduct.styleID <> 2)" DeleteCommand="DELETE FROM [platformOrderLine] WHERE [orderLineID] = @orderLineID" UpdateCommand="UPDATE platformOrderLine SET quantity = @quantity WHERE (orderLineID = @orderLineID)">
                <DeleteParameters>
                    <asp:Parameter Name="orderLineID" Type="Int32" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="-1" Name="userID" SessionField="id" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="quantity" Type="Int32" />
                    <asp:Parameter Name="orderLineID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
                
            <div class="container">
                <div class="col-md-9">
                    <div class="panel panel-default">
                        <div class="panel-heading">Workshops</div>
                        <!-- gridview for cartWorkshopGridview -->
                        <asp:GridView ID="CartWorkshopGridView" CssClass="table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataKeyNames="orderLineID" DataSourceID="cartWorkshopDataSource" EmptyDataText="No Workshop in Your Cart" ShowFooter="True">
                            <Columns>
                                <asp:BoundField DataField="city" HeaderText="City" SortExpression="city" FooterText="Subtotal" HeaderStyle-Width="15%"/>
                                <asp:BoundField DataField="location" HeaderText="Location" SortExpression="location" HeaderStyle-Width="25%"/>
                                <asp:BoundField DataField="topicCode" HeaderText="Topic Code" SortExpression="topicCode" HeaderStyle-Width="15%"/>
                                <asp:BoundField DataField="dateTime" HeaderText="Date Time" SortExpression="dateTime" HeaderStyle-Width="25%"/>
                                <asp:BoundField DataField="workshopPrice" HeaderText="Price" SortExpression="workshopPrice" HeaderStyle-Width="10%"/>
                                <asp:CommandField ShowDeleteButton="True" ControlStyle-CssClass="btn btn-danger"  ButtonType="Button" HeaderStyle-Width="10%">
                                </asp:CommandField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
          
            <div class="container">
                <div class="col-md-9">
                    <div class="panel panel-default">
                        <div class="panel-heading">eCourses</div>
                        <!-- gridview for cartProductGridView -->
                        <asp:GridView ID="CarteCourseGridView"  CssClass="table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataKeyNames="orderLineID" DataSourceID="carteCourseDataSource" EmptyDataText="No eCourse in Your Cart" ShowFooter="True">
                                <Columns>
                                    <asp:BoundField DataField="productName" HeaderText="Product Name" SortExpression="productName"  FooterText="Subtotal" HeaderStyle-Width="50%"/>
                                    <asp:BoundField DataField="styleDescription" HeaderText="Description" SortExpression="styleDescription" HeaderStyle-Width="30%"/>
                                    <asp:BoundField DataField="productPrice" HeaderText="Price" SortExpression="productPrice" HeaderStyle-Width="10%"/>
                                    <asp:CommandField ShowDeleteButton="True" ControlStyle-CssClass="btn btn-danger"  ButtonType="Button" HeaderStyle-Width="10%">
                                    </asp:CommandField>
                                </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>

            <div class="container">
                <div class="col-md-9">
                    <div class="panel panel-default">
                        <div class="panel-heading">Products</div>
                        <!-- gridview for cartProductGridView -->
                        <asp:GridView ID="CartProductGridView"  CssClass="table table-striped table-bordered table-hover" OnRowCommand="CartProductGridView_RowCommand" runat="server" AutoGenerateColumns="False" DataKeyNames="orderLineID" DataSourceID="cartProductDataSource" EmptyDataText="No Product in Your Cart" ShowFooter="True">
                                <Columns>
                                    <asp:BoundField DataField="productName" HeaderText="Product Name" SortExpression="productName"  FooterText="Subtotal" HeaderStyle-Width="35%"/>
                                    <asp:BoundField DataField="styleDescription" HeaderText="Description" SortExpression="styleDescription" HeaderStyle-Width="25%"/>
                                    <asp:BoundField DataField="productPrice" HeaderText="Price" SortExpression="productPrice" HeaderStyle-Width="12%"/>
                                    
                                    <asp:ButtonField CommandName="increaseQuantity" ControlStyle-CssClass="btn btn-info" ButtonType="Button" Text="+" HeaderStyle-Width="5%"/>
                                    <asp:BoundField DataField="quantity" HeaderText="Quantity" SortExpression="quantity" HeaderStyle-Width="8%"/>
                                    <asp:ButtonField CommandName="decreaseQuantity" ControlStyle-CssClass="btn btn-info" ButtonType="Button" Text="-" HeaderStyle-Width="5%"/>
                                    
                                    <asp:CommandField ShowDeleteButton="True" ControlStyle-CssClass="btn btn-danger"  ButtonType="Button" HeaderStyle-Width="10%">
                                    </asp:CommandField>
                                </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
            
            <!-- this part used to get total price -->
            <div class="container">
                    <div class="col-md-9">
                    <div class="text-right">
                        <h4>Total Price: $<asp:Label ID="TotalPrice" runat="server" Text="0.00"></asp:Label>
                        </h4>
                        <asp:SqlDataSource ID="totalPriceDataSource" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:M418_group3ConnectionString %>" 
                            SelectCommand="SELECT COALESCE (SUM(total), 0) AS total FROM (SELECT SUM(platformOrderLine.quantity * platformProduct.price) AS total FROM platformUser INNER JOIN platformOrder ON platformUser.userID = platformOrder.userID INNER JOIN platformOrderLine ON platformOrder.orderID = platformOrderLine.orderID INNER JOIN platformProduct ON platformOrderLine.productID = platformProduct.productID WHERE (platformUser.userID = @userID) AND (platformOrder.orderStatusID = 1) UNION ALL SELECT SUM(platformOrderLine_1.quantity * platformWorkshop.price) AS total FROM platformUser AS platformUser_1 INNER JOIN platformOrder AS platformOrder_1 ON platformUser_1.userID = platformOrder_1.userID INNER JOIN platformOrderLine AS platformOrderLine_1 ON platformOrder_1.orderID = platformOrderLine_1.orderID INNER JOIN platformWorkshop ON platformOrderLine_1.workshopID = platformWorkshop.workshopID WHERE (platformUser_1.userID = @userID) AND (platformOrder_1.orderStatusID = 1)) AS derivedtbl_1">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="-1" Name="userID" SessionField="id" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <a href="#" class="btn btn-primary" runat="server" ID="btnCheckout" onserverclick="Checkout">Checkout</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

