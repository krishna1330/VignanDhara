using System;
using System.Configuration;
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

        protected void gvBookRequests_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Approve")
            {
                int bookRequestId = int.Parse(e.CommandArgument.ToString());

                if (Session["UserId"] != null && Session["UserType"].ToString() == "1")
                {
                    int approvedBy = int.Parse(Session["UserId"].ToString());

                    BooksDAC booksDAC = new BooksDAC();
                    var isApproved = booksDAC.ApproveBookRequest(conStr, bookRequestId, approvedBy);

                    if (isApproved)
                    {
                        BindBookRequests();
                    }
                }
            }
            else if (e.CommandName == "Reject")
            {

            }
        }
    }
}
