<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookRequests.aspx.cs" Inherits="VignanDhara.Web.Books.BookRequests" MasterPageFile="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        <h2>Book Requests</h2>
        <asp:GridView ID="gvBookRequests" runat="server" CssClass="table" AutoGenerateColumns="false" 
                      OnRowCommand="gvBookRequests_RowCommand">
            <Columns>
                <asp:BoundField DataField="UserId" HeaderText="User Id" />
                <asp:BoundField DataField="UserName" HeaderText="User Name" />
                <asp:BoundField DataField="BookName" HeaderText="Book Name" />
                <asp:BoundField DataField="RequestedDate" HeaderText="Requested Date" DataFormatString="{0:dd-MM-yyyy}" />

                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:Button ID="btnApprove" runat="server" Text="Approve" CommandName="Approve" 
                                    CommandArgument='<%# Eval("BookRequestId") %>' CssClass="btn btn-success" />
                        <asp:Button ID="btnReject" runat="server" Text="Reject" CommandName="Reject" 
                                    CommandArgument='<%# Eval("BookRequestId") %>' CssClass="btn btn-danger" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
