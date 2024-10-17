<%@ Page Title="My Books" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyBooks.aspx.cs" Inherits="VignanDhara.Web.Books.MyBooks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <h2>My Books</h2>
        <asp:GridView ID="gvMyBooks" runat="server" AutoGenerateColumns="False" CssClass="table">
            <Columns>
                <asp:BoundField DataField="BookName" HeaderText="Book Name" />
                <asp:BoundField DataField="RequestedDate" HeaderText="Requested Date" DataFormatString="{0:dd-MM-yyyy}" HtmlEncode="false" />
                <asp:BoundField DataField="Status" HeaderText="Status" />
                <asp:BoundField DataField="RejectedReason" HeaderText="Rejected Reason" />
                <asp:BoundField DataField="FromDate" HeaderText="From Date" DataFormatString="{0:dd-MM-yyyy}" HtmlEncode="false" />
                <asp:BoundField DataField="ToDate" HeaderText="To Date"  DataFormatString="{0:dd-MM-yyyy}" HtmlEncode="false" />
                <asp:BoundField DataField="ReturnedDate" HeaderText="Returned Date" DataFormatString="{0:dd-MM-yyyy}" HtmlEncode="false" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
