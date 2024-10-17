using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VignanDhara.Data;
using VignanDhara.Entities;

namespace VignanDhara.Web.Books
{
    public partial class AddBook : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Session["UserType"] != null && Session["UserType"].ToString() == "1")
            {
                if (Session["UserId"] != null)
                {
                    VignanDhara.Entities.Books book = new VignanDhara.Entities.Books
                    {
                        BookName = txtBookName.Text,
                        BookDescription = txtDescription.Text,
                        Author = txtAuthor.Text,
                        ISBN = txtIBSN.Text,
                        PublishedDate = DateTime.Parse(txtPublishedDate.Text),
                        Publisher = txtPublisher.Text,
                        Genre = txtGenre.Text,
                        TotalBooks = int.Parse(txtTotalBooks.Text),
                        AvailableBooks = int.Parse(txtAvailableBooks.Text),
                        Rating = decimal.Parse(txtRating.Text),
                        Status = 1,
                        CreatedDate = DateTime.Now,
                        CreatedBy = int.Parse(Session["UserId"].ToString())
                    };

                    string conStr = ConfigurationManager.ConnectionStrings["SQLConnection"].ConnectionString;

                    BooksDAC booksDAC = new BooksDAC();
                    int? bookId = booksDAC.AddBook(conStr, book);

                    if (bookId != null)
                    {
                        Response.Redirect("AllBooks.aspx");
                    }
                }
            }
        }
    }
}