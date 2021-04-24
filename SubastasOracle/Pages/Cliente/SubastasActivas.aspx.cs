using Oracle.ManagedDataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SubastasOracle.Pages.Cliente
{
    public partial class SubastasCliente : System.Web.UI.Page
    {
        String currentCat;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                lblDisplay.Text = "Ver subastas activas";
                lblLead.Text = "Para ver subastas activas por favor seleccione una categoría y una subcategoría.";

                DataTable dtCat = getCategorias();
                populateCategorias(dtCat);

                currentCat = dropDownCat.SelectedValue.ToString();
                DataTable dtSubcat = getSubcategorias(currentCat);
                populateSubcategorias(dtSubcat);
            }
            

        }

        protected void btnConsultarClick(object sender, EventArgs e)
        {
            DataTable dt = getSubastas();
            gridSubs.DataSource = dt;
            gridSubs.DataBind();
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("HomeCliente.aspx");
        }

        protected DataTable getCategorias()
        {
            //Crear el comando para la base de datos.
            OracleCommand cmd = new OracleCommand("system.sp_get_nombres_categorias", Logica.DBSession.instance.connection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("cursor_",OracleDbType.RefCursor,ParameterDirection.InputOutput);

            //Crear el data adapter.
            DataTable dt = new DataTable();
            OracleDataAdapter da = new OracleDataAdapter(cmd);
            da.Fill(dt);
            return dt;
        }

        protected void populateCategorias(DataTable dt)
        {
            dropDownCat.DataSource = dt;
            dropDownCat.DataTextField = "cat";
            dropDownCat.DataValueField = "cat";
            dropDownCat.DataBind();
        }

        protected DataTable getSubcategorias(String catName)
        {
            //Crear el comando para la base de datos.
            OracleCommand cmd = new OracleCommand("system.sp_get_nombres_subcategorias", Logica.DBSession.instance.connection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("in_nombre_cat",OracleDbType.Varchar2).Value = catName;
            cmd.Parameters.Add("cursor_",OracleDbType.RefCursor,ParameterDirection.InputOutput);

            //Crear el data adapter.
            DataTable dt = new DataTable();
            OracleDataAdapter da = new OracleDataAdapter(cmd);
            da.Fill(dt);
            return dt;
        }

        protected void populateSubcategorias(DataTable dt)
        {
            dropDownSubcat.DataSource = dt;
            dropDownSubcat.DataTextField = "subcat";
            dropDownSubcat.DataValueField = "subcat";
            dropDownSubcat.DataBind();
        }

        protected void DropDownCat_SelectedIndexChanged(object sender, EventArgs e)
        {
            currentCat = dropDownCat.SelectedValue.ToString();
            DataTable dtSubcat = getSubcategorias(currentCat);
            populateSubcategorias(dtSubcat);

        }

        protected DataTable getSubastas()
        {
            String cat = dropDownCat.SelectedValue.ToString();
            String subcat = dropDownSubcat.SelectedValue.ToString();
            //Crear el comando para la base de datos.
            OracleCommand cmd = new OracleCommand("system.sp_get_subastas_cat_subcat", Logica.DBSession.instance.connection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("in_cat_name", OracleDbType.Varchar2).Value = cat;
            cmd.Parameters.Add("in_subcat_name", OracleDbType.Varchar2).Value = subcat;
            cmd.Parameters.Add("cursor_",OracleDbType.RefCursor,ParameterDirection.InputOutput);

            //Crear el data adapter.
            DataTable dt = new DataTable();
            OracleDataAdapter da = new OracleDataAdapter(cmd);
            da.Fill(dt);
            return dt;
        }
        //protected void gridView_RowCommand(object sender, GridViewCommandEventArgs e)
        //{
        //    if (e.CommandName == "Select")
        //    {
        //        int rowIndex = Convert.ToInt32(e.CommandArgument);

        //        GridViewRow row = gridSubs.Rows[rowIndex];

        //        string name = row.Cells[1].Text;
        //        Logica.MessageBox.Show(name);
        //    }
        //}

        protected void btnVerPujasClick(object sender, EventArgs e)
        {
            GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
            int index = gvRow.RowIndex;

            GridViewRow row = gridSubs.Rows[index];
            // La celda 1 es el nombre de la subasta.
            string nombreSub = row.Cells[1].Text;
            Logica.MessageBox.Show(nombreSub);
            Response.Redirect("verPujas.aspx?NombreSubasta=" + nombreSub);
        }
    }
}