<%@ Page Title="Books" Language="C#" AutoEventWireup="true" CodeBehind="AddBook.aspx.cs" Inherits="VignanDhara.Web.Books.AddBook" %>
<%--<%@ Page Title="Books" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AllBooks.aspx.cs" Inherits="VignanDhara.Web.Books.AllBooks" %>--%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Book</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .form-container {
            margin: 20px auto;
            max-width: 800px;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

            .form-container h2 {
                text-align: center;
                margin-bottom: 20px;
            }

        .btn-dark {
            width: 100%;
            padding: 10px;
            background-color: #343a40;
            color: white;
        }

            .btn-dark:hover {
                background-color: #23272b;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container form-container">
            <h2>Add Book</h2>
            <div class="row">
                <!-- Book Name and Author Side by Side -->
                <div class="col-md-6 form-group">
                    <label for="txtBookName">Book Name</label>
                    <asp:TextBox ID="txtBookName" runat="server" CssClass="form-control" placeholder="Enter book name" required="true"></asp:TextBox>
                </div>
                <div class="col-md-6 form-group">
                    <label for="txtAuthor">Author</label>
                    <asp:TextBox ID="txtAuthor" runat="server" CssClass="form-control" placeholder="Enter author's name" required="true"></asp:TextBox>
                </div>
            </div>

            <!-- Book Description -->
            <div class="form-group">
                <label for="txtDescription">Book Description</label>
                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Enter book description" MaxLength="500" required="true"></asp:TextBox>
            </div>

            <div class="row">
                <!-- ISBN and Published Date Side by Side -->
                <div class="col-md-6 form-group">
                    <label for="txtIBSN">ISBN</label>
                    <asp:TextBox ID="txtIBSN" runat="server" CssClass="form-control" placeholder="Enter ISBN" required="true" pattern="\d+"></asp:TextBox>
                    <small class="form-text text-muted">Only numbers are allowed.</small>
                </div>
                <div class="col-md-6 form-group">
                    <label for="txtPublishedDate">Published Date</label>
                    <asp:TextBox ID="txtPublishedDate" runat="server" CssClass="form-control" TextMode="Date" required="true"></asp:TextBox>
                </div>
            </div>

            <div class="row">
                <!-- Publisher and Genre Side by Side -->
                <div class="col-md-6 form-group">
                    <label for="txtPublisher">Publisher</label>
                    <asp:TextBox ID="txtPublisher" runat="server" CssClass="form-control" placeholder="Enter publisher's name" required="true"></asp:TextBox>
                </div>
                <div class="col-md-6 form-group">
                    <label for="txtGenre">Genre</label>
                    <asp:TextBox ID="txtGenre" runat="server" CssClass="form-control" placeholder="Enter genre" required="true"></asp:TextBox>
                </div>
            </div>

            <div class="row">
                <!-- Total Books and Available Books Side by Side -->
                <div class="col-md-6 form-group">
                    <label for="txtTotalBooks">Total Books</label>
                    <asp:TextBox ID="txtTotalBooks" runat="server" CssClass="form-control" placeholder="Enter total books" required="true" pattern="\d+"></asp:TextBox>
                    <small class="form-text text-muted">Only numbers are allowed.</small>
                </div>
                <div class="col-md-6 form-group">
                    <label for="txtAvailableBooks">Available Books</label>
                    <asp:TextBox ID="txtAvailableBooks" runat="server" CssClass="form-control" placeholder="Enter available books" required="true" pattern="\d+"></asp:TextBox>
                    <small class="form-text text-muted">Only numbers are allowed.</small>
                </div>
            </div>

            <!-- Rating -->
            <div class="form-group">
                <label for="txtRating">Rating</label>
                <asp:TextBox ID="txtRating" runat="server" CssClass="form-control" placeholder="Enter book rating" required="true" pattern="\d+(\.\d{1,2})?" MaxLength="4"></asp:TextBox>
                <small class="form-text text-muted">Please enter a rating between 1 and 5.</small>
            </div>

            <!-- Submit Button -->
            <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-dark" OnClick="btnSubmit_Click" Text="Add Book" />
        </div>
    </form>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
