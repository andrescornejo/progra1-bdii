using Oracle.ManagedDataAccess.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SubastasOracle.Logica
{
    public class DBSession
    {
        public static DBSession instance { get; } = new DBSession();
        public OracleConnection connection;
        public String username { get; set; }
        private String passwd { get; set; }

        private DBSession() { }

        void Connect()
        {
            try
            {
                OracleConnectionStringBuilder ocsb = new OracleConnectionStringBuilder();
                ocsb.UserID = username;
                ocsb.Password = passwd;
                // El nombre de la base de datos es alambrado.
                ocsb.DataSource = "localhost:1521/progra1";


                connection = new OracleConnection();
                connection.ConnectionString = ocsb.ConnectionString;
                connection.Open();
                //MessageBox.Show("Connected to Oracle" + connection.ServerVersion); //Debug
            }
            catch(Oracle.ManagedDataAccess.Client.OracleException e)
            {
                MessageBox.Show("Usuario o contraseña inválidos, vuelva a intentarlo.");
            }
        }

        void Close()
        {
            connection.Close();
            connection.Dispose();
        }

        public void LoginDB(string pUsername, string pPasswd)
        {
            username = pUsername;
            passwd = pPasswd;
            Connect();
        }

        public void LogoutDB()
        {
            username = "";
            passwd = "";
            Close();
        }
    }
}