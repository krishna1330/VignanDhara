using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
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
                int userId = 2;
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
    }
}