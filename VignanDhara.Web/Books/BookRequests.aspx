<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookRequests.aspx.cs" Inherits="VignanDhara.Web.Books.BookRequests" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        <h2>Book Requests</h2>
        <asp:GridView ID="gvBookRequests" runat="server" CssClass="table table-striped" AutoGenerateColumns="false">
            <Columns>
                <asp:BoundField DataField="BookName" HeaderText="Book Name" />
                <asp:BoundField DataField="RequestedDate" HeaderText="Requested Date" DataFormatString="{0:dd-MM-yyyy}" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
