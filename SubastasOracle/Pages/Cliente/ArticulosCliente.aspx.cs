using Oracle.ManagedDataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SubastasOracle.Pages.Cliente
{
    public partial class ArticulosCliente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblDisplay.Text = "Artículos de: " + Logica.DBSession.instance.username;
            lblLead.Text = "Agregar artículos: ";

            DataTable dt = getItemsDeUsuario();
            gridArtic.DataSource = dt;
            gridArtic.DataBind();
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("HomeCliente.aspx");
        }

        protected void btnAddArtic_Click(object sender, EventArgs e)
        {

        }

        protected DataTable getItemsDeUsuario()
        {
            //Crear el comando para la base de datos.
            OracleCommand cmd = new OracleCommand("system.sp_ver_items_de_usuario", Logica.DBSession.instance.connection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("in_username",OracleDbType.Varchar2).Value = Logica.DBSession.instance.username;
            cmd.Parameters.Add("cursor_",OracleDbType.RefCursor,ParameterDirection.InputOutput);

            //Crear el data adapter.
            DataTable dt = new DataTable();
            OracleDataAdapter da = new OracleDataAdapter(cmd);
            da.Fill(dt);
            return dt;
        }
    }
}