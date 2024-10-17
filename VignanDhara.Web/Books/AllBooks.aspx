<%@ Page Title="Books" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AllBooks.aspx.cs" Inherits="VignanDhara.Web.Books.AllBooks" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="d-flex justify-content-between mb-3">
            <h2>Books</h2>
            <asp:Button ID="btnAddBook" runat="server" CssClass="btn btn-primary" Text="Add Book" OnClick="btnAddBook_Click" />
            <asp:Label ID="lblResponse" runat="server" style="margin-left: 150px;"></asp:Label>
        </div>
        <br />
        <asp:GridView ID="gvBooks" runat="server" CssClass="table table-bordered" AutoGenerateColumns="False" OnRowCommand="gvBooks_RowCommand" OnRowEditing="gvBooks_RowEditing" OnSelectedIndexChanged="gvBooks_SelectedIndexChanged1">
            <Columns>
                <asp:BoundField DataField="BookName" HeaderText="Book Name" />
                <asp:BoundField DataField="Author" HeaderText="Author" />
                <asp:BoundField DataField="Publisher" HeaderText="Publisher" />
                <asp:BoundField DataField="TotalBooks" HeaderText="Total Books" />
                <asp:BoundField DataField="AvailableBooks" HeaderText="Available Books" />

                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="Edit" CssClass="btn btn-info btn-sm" />
                        <%--                        <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="Delete" CommandArgument="<%# Container.DataItemIndex %>" CssClass="btn btn-danger btn-sm" OnClientClick="return confirm('Are you sure you want to delete this book?');" />--%>
                        <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="Delete"
                            CommandArgument='<%# Eval("BookId") %>'
                            CssClass="btn btn-danger btn-sm"
                            OnClientClick="return confirm('Are you sure you want to delete this book?');" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="BookId" HeaderText="Book Id" Visible="False" />
            </Columns>
        </asp:GridView>

    </div>
</asp:Content>
