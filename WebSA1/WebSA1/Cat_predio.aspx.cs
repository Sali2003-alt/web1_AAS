using Npgsql;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSA1
{
    public partial class Cat_predio : System.Web.UI.Page
    {

       
        string cadenaConexion = "";
        NpgsqlConnection conexion;
        protected void Page_Load(object sender, EventArgs e)
        {

            
            this.cadenaConexion = ConfigurationManager.ConnectionStrings["conexionBddMejia"].ConnectionString;
            this.conexion = new NpgsqlConnection(cadenaConexion);

            if (!IsPostBack)
            {
                this.consultarPredios(); 
                btnGuardar.Visible = true;
                btnActualizar.Visible = false;
                this.CargarPredios();
            }

        }



        public bool InsertarPredio(string codigoCatastral, DateTime fechaIngreso, string nombrePredio, decimal areaTotalTer, decimal areaTotalConst)
        {

            NpgsqlCommand comandoInsercion = new NpgsqlCommand("sp_insertar_cat_predio", conexion);
            comandoInsercion.CommandType = CommandType.StoredProcedure;

            comandoInsercion.Parameters.AddWithValue("p_pre_codigo_catastral", codigoCatastral);
            comandoInsercion.Parameters.AddWithValue("p_pre_fecha_ingreso", fechaIngreso);
            comandoInsercion.Parameters.AddWithValue("p_pre_nombre_predio", nombrePredio);
            comandoInsercion.Parameters.AddWithValue("p_pre_area_total_ter", areaTotalTer);
            comandoInsercion.Parameters.AddWithValue("p_pre_area_total_const", areaTotalConst);

            try
            {
                conexion.Open();
                int filasAfectadas = comandoInsercion.ExecuteNonQuery();
                conexion.Close();

                return filasAfectadas > 0; 
            }
            catch (NpgsqlException ex)
            {
               
                Console.WriteLine("Error de PostgreSQL al insertar predio: " + ex.Message);
                return false;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error general al insertar predio: " + ex.Message);
                return false;
            }
            finally
            {
                if (conexion.State == ConnectionState.Open)
                {
                    conexion.Close();
                }
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {

        }




    }
}




