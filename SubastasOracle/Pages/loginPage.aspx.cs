using Oracle.ManagedDataAccess.Client;
using SubastasOracle.Logica;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SubastasOracle.Pages
{
    public partial class loginPage : System.Web.UI.Page
    {
        string username_input, passwd_input;

        protected void Page_Load(object sender, EventArgs e)
        {
            username_input = this.usernameTb.Text;
            passwd_input = this.passwordTb.Text;
            
            //if (usernameGot.Length == 0 || passwordGot.Length ==0){
            //    MessageBox.Show("Username or password can't be empty.");
            //}
            ////Invoke SP to check if user is admin or not.
            //
            //switch (Globals.login(usernameGot, passwordGot))
            //{
            //    case 0:
            //        Globals.setUser(usernameGot, false);
            //        Response.Redirect("Client/ClientPanel.aspx");
            //        break;
            //        //throw new NotImplementedException("No se ha implementado el cliente");
            //    case 1:
            //        Globals.setUser(usernameGot, true);
            //        Response.Redirect("Admin/AdminPanel.aspx");
            //        break;
            //    default:
            //        MessageBox.Show("Failed to log in.");
            //        break;
            //}
        }

        protected void loginBtn_Click(object sender, EventArgs e)
        {
            if (username_input.Length == 0 || passwd_input.Length ==0){
                MessageBox.Show("Usuario o contraseña vacios, por favor intente de nuevo.");
            }
            else if(DBSession.instance.LoginDB(username_input, passwd_input))
                if (getAdminStatus())
                    Response.Redirect("Administrador/HomeAdmin.aspx");
                else
                    Response.Redirect("Cliente/HomeCliente.aspx");
            else
                MessageBox.Show("Usuario y/o contraseña incorrectos, por favor intente de nuevo.");

        }

        protected bool getAdminStatus()
        {
            //Crear el comando para la base de datos.
            OracleCommand cmd = new OracleCommand("system.sp_get_admin_status", Logica.DBSession.instance.connection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("in_username", OracleDbType.Varchar2).Value = username_input;
            cmd.Parameters.Add("out_status", OracleDbType.Int32);
            cmd.Parameters["out_status"].Direction = ParameterDirection.Output;

            cmd.ExecuteNonQuery();


            if (cmd.Parameters["out_status"].Value.ToString() == "1")
                return true;
            else
                return false;
        }
    }
}