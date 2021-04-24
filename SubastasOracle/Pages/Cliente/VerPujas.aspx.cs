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
	public partial class VerPujas : System.Web.UI.Page
	{
        string nombreSubasta;
		protected void Page_Load(object sender, EventArgs e)
		{
            if (!Page.IsPostBack)
            {
                if (Request.QueryString["NombreSubasta"] != null)
                    nombreSubasta = Request.QueryString["NombreSubasta"];

                lblDisplay.Text = "Ver historial de pujas.";
                lblLead.Text = "Historial de pujas de: "+nombreSubasta;

                DataTable dt = getPujas();
                populatePujas(dt);                
            }

		}

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("SubastasActivas.aspx");
        }

        protected void btnHacerPujaClick(object sender, EventArgs e)
        {

        }

        protected DataTable getPujas()
        {
            //Crear el comando para la base de datos.
            OracleCommand cmd = new OracleCommand("system.sp_ver_pujas_de_subasta", Logica.DBSession.instance.connection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("in_subasta_nombre", OracleDbType.Varchar2).Value = nombreSubasta;
            cmd.Parameters.Add("cursor_",OracleDbType.RefCursor,ParameterDirection.InputOutput);

            //Crear el data adapter.
            DataTable dt = new DataTable();
            OracleDataAdapter da = new OracleDataAdapter(cmd);
            da.Fill(dt);
            return dt;
        }

        protected void populatePujas(DataTable dt)
        {
            gridPujas.DataSource = dt;
            gridPujas.DataBind();
        }
    }
}