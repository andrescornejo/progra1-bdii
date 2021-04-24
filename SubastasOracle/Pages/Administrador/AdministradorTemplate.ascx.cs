using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SubastasOracle.Pages.Administrador
{
    public partial class AdministradorTemplate : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.lblUsername.Text = "Usuario: " + Logica.DBSession.instance.username;
        }

        protected void logoutBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("../loginPage.aspx");
            Logica.DBSession.instance.LogoutDB();
        }
    }
}