using System;
using System.Configuration;
using System.Data;
using System.Web.UI.WebControls;
using VignanDhara.Data;

namespace VignanDhara.Web.Books
{
    public partial class MyBooks : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["SQLConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int userId = 2; // Example user ID
                LoadMyBooks(userId);
            }
        }

        private void LoadMyBooks(int userId)
        {
            BooksDAC booksDAC = new BooksDAC();
            DataTable myBooks = booksDAC.GetMyBooks(conStr, userId);

            if (myBooks != null && myBooks.Rows.Count > 0)
            {
                gvMyBooks.DataSource = myBooks;
                gvMyBooks.DataBind();
            }
            else
            {
                gvMyBooks.DataSource = null;
                gvMyBooks.DataBind();
            }
        }

        protected void gvMyBooks_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Return")
            {
                int bookRequestId = int.Parse(e.CommandArgument.ToString());

                if (Session["UserId"] != null && Session["UserType"].ToString() != "1")
                {
                    int requestedBy = int.Parse(Session["UserId"].ToString());

                    BooksDAC booksDAC = new BooksDAC();
                    var isRequested = booksDAC.RequestBookReturn(conStr, bookRequestId);

                    if (isRequested)
                    {
                        LoadMyBooks(requestedBy);
                    }
                }
            }
        }
    }
}
