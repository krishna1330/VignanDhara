using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VignanDhara.Data;

namespace VignanDhara.Web.Books
{
    public partial class BookRequests : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["SQLConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindBookRequests();
            }
        }

        private void BindBookRequests()
        {

            BooksDAC booksDAC = new BooksDAC();
            var requests = booksDAC.GetBookRequests(conStr);

            gvBookRequests.DataSource = requests;
            gvBookRequests.DataBind();
        }
    }
}