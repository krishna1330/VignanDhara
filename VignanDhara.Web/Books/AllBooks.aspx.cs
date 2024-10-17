using System;
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
                if (Session["UserId"] != null && Session["UserId"].ToString() == "1")
                {
                    btnAddBook.Visible = true;
                    gvBooks.Columns[GetColumnIndexByHeaderText("Actions")].Visible = true;
                }
                else
                {
                    btnAddBook.Visible = false;
                    gvBooks.Columns[GetColumnIndexByHeaderText("Actions")].Visible = false;
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

        protected void gvBooks_SelectedIndexChanged(object sender, EventArgs e)
        {

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
                        Response.Redirect("AllBooks.aspx");
                    }
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

    }
}