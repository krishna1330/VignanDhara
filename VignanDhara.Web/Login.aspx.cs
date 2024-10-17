using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using VignanDhara.Data;
using VignanDhara.Entities;

namespace VignanDhara.Web
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string conStr = ConfigurationManager.ConnectionStrings["SQLConnection"].ConnectionString;

            UserDAC userDAC = new UserDAC();
            bool isAuthenticatedUser = userDAC.AuthenticateUser(conStr, txtEmail.Text, txtPassword.Text);

            if (isAuthenticatedUser)
            {
                User user = userDAC.GetUserDetails(conStr, txtEmail.Text);
                string firstName = user.FirstName;
                string lastName = user.LastName;

                string[] nameParts = firstName.Split(' ');
                string initials = " ";
                foreach (string part in nameParts)
                {
                    if (part.Length > 0)
                    {
                        initials += part[0];
                    }
                }
                //initials = initials.Trim();

                Session["Username"] = initials + " " + lastName;
                Session["UserId"] = user.UserId;
                Session["UserType"] = user.UserType;
                
                FormsAuthentication.RedirectFromLoginPage(txtEmail.Text, false);
            } 
            else
            {
                lblError.Text = "Invalid credentials.";
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();

            if (Request.Cookies[".ASPXAUTH"] != null)
            {
                HttpCookie authCookie = new HttpCookie(".ASPXAUTH");
                authCookie.Expires = DateTime.Now.AddDays(-1d);
                Response.Cookies.Add(authCookie);
            }

            Response.Redirect("~/Login.aspx");
        }

    }
}