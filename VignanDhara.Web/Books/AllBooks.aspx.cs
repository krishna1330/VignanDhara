﻿using System;
using System.Configuration;
using System.Web.UI.WebControls;
using VignanDhara.Data;

namespace VignanDhara.Web.Books
{
    public partial class AllBooks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["lblResponse"] != null)
                {
                    lblResponse.Text = Session["lblResponse"].ToString();
                    lblResponse.ForeColor = System.Drawing.Color.Green;

                    string script = @"<script type='text/javascript'>
                                setTimeout(function() {
                                    document.getElementById('" + lblResponse.ClientID + @"').style.display = 'none';
                                }, 2000);
                              </script>";
                    ClientScript.RegisterStartupScript(this.GetType(), "HideLabelScript", script);

                    Session["lblResponse"] = null;
                }

                if (Session["UserType"] != null && Session["UserType"].ToString() == "1")
                {
                    btnAddBook.Visible = true;
                    gvBooks.Columns[GetColumnIndexByHeaderText("Actions")].Visible = true;
                    gvBooks.Columns[GetColumnIndexByHeaderText("Request Book")].Visible = false;
                }
                else
                {
                    btnAddBook.Visible = false;
                    gvBooks.Columns[GetColumnIndexByHeaderText("Actions")].Visible = false;
                    gvBooks.Columns[GetColumnIndexByHeaderText("Request Book")].Visible = true;
                }

                LoadBooks();
            }
        }

        private int GetColumnIndexByHeaderText(string headerText)
        {
            foreach (DataControlField column in gvBooks.Columns)
            {
                if (column.HeaderText == headerText)
                {
                    return gvBooks.Columns.IndexOf(column);
                }
            }
            return -1;
        }

        private void LoadBooks()
        {
            string conStr = ConfigurationManager.ConnectionStrings["SQLConnection"].ConnectionString;

            BooksDAC booksDAC = new BooksDAC();
            var books = booksDAC.GetAllBooks(conStr);

            gvBooks.DataSource = books;
            gvBooks.DataBind();
        }

        protected void btnAddBook_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] != null && Session["UserType"].ToString() == "1")
            {
                Response.Redirect("AddBook.aspx");
            }
        }


        protected void gvBooks_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                int bookId = int.Parse(e.CommandArgument.ToString());

                if (Session["UserId"] != null && Session["UserType"].ToString() == "1")
                {
                    int deletedBy = int.Parse(Session["UserId"].ToString());

                    string conStr = ConfigurationManager.ConnectionStrings["SQLConnection"].ConnectionString;

                    BooksDAC booksDAC = new BooksDAC();
                    var isDeleted = booksDAC.DeleteBookByBookId(conStr, bookId, deletedBy);

                    if (isDeleted == 1)
                    {
                        Session["lblResponse"] = "Book deleted successfully.";
                    }
                    else
                    {
                        Session["lblResponse"] = "Unable to delete the book.";
                    }
                }

                Response.Redirect("AllBooks.aspx");
            }

            else if (e.CommandName == "Request Book")
            {
                int bookId = int.Parse(e.CommandArgument.ToString());

                if (Session["UserId"] != null && Session["UserType"].ToString() != "1")
                {
                    int requestedBy = int.Parse(Session["UserId"].ToString());

                    string conStr = ConfigurationManager.ConnectionStrings["SQLConnection"].ConnectionString;

                    BooksDAC booksDAC = new BooksDAC();
                    var res = booksDAC.RequestBook(conStr, requestedBy, bookId);

                    Session["lblResponse"] = res;

                    Response.Redirect("AllBooks.aspx");
                }
            }
        }

        protected void gvBooks_RowEditing(object sender, GridViewEditEventArgs e)
        {
            // Set the row in edit mode
            gvBooks.EditIndex = e.NewEditIndex;

            // Refresh the GridView to show the edit mode
            LoadBooks();
        }

        protected void gvBooks_SelectedIndexChanged1(object sender, EventArgs e)
        {

        }
    }
}