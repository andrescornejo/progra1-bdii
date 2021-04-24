using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SubastasOracle.Pages.Cliente
{
    public partial class HomeCliente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnVerSubastasActivasClick(object sender, EventArgs e)
        {
            Response.Redirect("SubastasActivas.aspx");
        }

        protected void btnVerItemsClick(object sender, EventArgs e)
        {
            Response.Redirect("ArticulosCliente.aspx");
        }
    }
}