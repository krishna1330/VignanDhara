using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VignanDhara.Web
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();

            if (Request.Cookies[".ASPXAUTH"] != null)
            {
                HttpCookie authCookie = new HttpCookie(".ASPXAUTH");
                authCookie.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(authCookie);
            }

            Response.Redirect("~/Login.aspx");
        }
    }
}