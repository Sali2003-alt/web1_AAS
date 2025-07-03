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
            }

        }



        public bool InsertarPredio(string codigoCatastral, DateTime fechaIngreso, string nombrePredio, decimal areaTotalTer, decimal areaTotalConst)
        {
            NpgsqlCommand comandoInsercion = new NpgsqlCommand("catastro.sp_insertar_cat_predio", conexion);
            comandoInsercion.CommandType = CommandType.StoredProcedure;

            comandoInsercion.Parameters.AddWithValue("p_pre_codigo_catastral", codigoCatastral);
            comandoInsercion.Parameters.AddWithValue("p_pre_fecha_ingreso", fechaIngreso);
            comandoInsercion.Parameters.AddWithValue("p_pre_nombre_predio", nombrePredio);
            comandoInsercion.Parameters.AddWithValue("p_pre_area_total_ter", areaTotalTer);
            comandoInsercion.Parameters.AddWithValue("p_pre_area_total_const", areaTotalConst);

            try
            {
                conexion.Open();
                comandoInsercion.ExecuteNonQuery();
                conexion.Close();
                return true;
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Error", $"alert('Error al insertar predio: {ex.Message}');", true);
                return false;
            }
        }
        public bool ActualizarPredio(int preId, string nombrePredio, decimal areaTotalTer, decimal areaTotalConst)
        {
            NpgsqlCommand comandoActualizacion = new NpgsqlCommand("catastro.sp_actualizar_cat_predio", conexion);
            comandoActualizacion.CommandType = CommandType.StoredProcedure;

            comandoActualizacion.Parameters.AddWithValue("p_pre_id", preId);
            comandoActualizacion.Parameters.AddWithValue("p_pre_nombre_predio", nombrePredio);
            comandoActualizacion.Parameters.AddWithValue("p_pre_area_total_ter", areaTotalTer);
            comandoActualizacion.Parameters.AddWithValue("p_pre_area_total_const", areaTotalConst);

            try
            {
                conexion.Open();
                comandoActualizacion.ExecuteNonQuery();
                conexion.Close();
                return true;
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Error", $"alert('Error al actualizar predio: {ex.Message}');", true);
                return false;
            }
        }

        public void consultarPredios()
        {
            NpgsqlCommand comandoConsulta = new NpgsqlCommand("catastro.fn_consultar_cat_predios", this.conexion);
            comandoConsulta.CommandType = CommandType.StoredProcedure;

            try
            {
                conexion.Open();
                NpgsqlDataAdapter adaptador = new NpgsqlDataAdapter(comandoConsulta);
                DataTable tabla = new DataTable();
                adaptador.Fill(tabla);
                lstPredios.DataSource = tabla;
                lstPredios.DataBind();
                conexion.Close();
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Error", $"alert('Error al consultar predios: {ex.Message}');", true);
            }
        }

        public void EliminarPredio(int preId)
        {
            NpgsqlCommand comandoEliminar = new NpgsqlCommand("catastro.sp_eliminar_cat_predio", this.conexion);
            comandoEliminar.CommandType = CommandType.StoredProcedure;
            comandoEliminar.Parameters.AddWithValue("p_pre_id", preId);

            try
            {
                conexion.Open();
                comandoEliminar.ExecuteNonQuery();
                conexion.Close();
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Error", $"alert('Error al eliminar predio: {ex.Message}');", true);
            }
            finally
            {
                consultarPredios();
            }
        }
        private void BuscarPredioPorCodigo(string codigoCatastral)
        {
            NpgsqlCommand comandoBusqueda = new NpgsqlCommand("catastro.fn_consultar_predio_por_codigo", this.conexion);
            comandoBusqueda.CommandType = CommandType.StoredProcedure;
            comandoBusqueda.Parameters.AddWithValue("p_codigo", codigoCatastral);

            try
            {
                conexion.Open();
                NpgsqlDataAdapter adaptador = new NpgsqlDataAdapter(comandoBusqueda);
                DataTable tabla = new DataTable();
                adaptador.Fill(tabla);
                lstPredios.DataSource = tabla;
                lstPredios.DataBind();
                conexion.Close();
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Error", $"alert('Error al buscar predio: {ex.Message}');", true);
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            DateTime fechaIngreso;
            if (!DateTime.TryParse(txtFechaIngreso.Text, out fechaIngreso))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Error", "alert('Formato de fecha incorrecto. Use yyyy-MM-dd');", true);
                return;
            }

            decimal areaTotalTer = 0;
            decimal areaTotalConst = 0;
            decimal.TryParse(txtAreaTotalTer.Text, out areaTotalTer);
            decimal.TryParse(txtAreaTotalConst.Text, out areaTotalConst);

            bool exito = this.InsertarPredio(
                txtCodigoCatastral.Text,
                fechaIngreso,
                txtNombrePredio.Text,
                areaTotalTer,
                areaTotalConst
            );

            if (exito)
            {
                LimpiarFormulario();
                ClientScript.RegisterStartupScript(this.GetType(), "Success", "alert('Predio guardado exitosamente');", true);
                consultarPredios();
            }

        }

        protected void lstPredios_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int preId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Eliminar")
            {
                this.EliminarPredio(preId);
            }

            if (e.CommandName == "Modificar")
            {
                NpgsqlCommand comandoConsulta = new NpgsqlCommand("SELECT * FROM catastro.cat_predio WHERE pre_id = @preId", this.conexion);
                comandoConsulta.Parameters.AddWithValue("@preId", preId);

                try
                {
                    conexion.Open();
                    NpgsqlDataReader reader = comandoConsulta.ExecuteReader();
                    if (reader.Read())
                    {
                        ViewState["preId"] = preId;

                        hfPreId.Value = preId.ToString();
                        txtCodigoCatastral.Text = reader["pre_codigo_catastral"].ToString();
                        txtCodigoAnterior.Text = reader["pre_codigo_anterior"].ToString();
                        txtNumero.Text = reader["pre_numero"].ToString();
                        txtNombrePredio.Text = reader["pre_nombre_predio"].ToString();
                        txtAreaTotalTer.Text = reader["pre_area_total_ter"].ToString();
                        txtAreaTotalConst.Text = reader["pre_area_total_const"].ToString();
                        txtFondoRelativo.Text = reader["pre_fondo_relativo"].ToString();
                        txtFrenteFondo.Text = reader["pre_frente_fondo"].ToString();
                        txtObservaciones.Text = reader["pre_observaciones"].ToString();
                        txtDimTomadoPlanos.Text = reader["pre_dim_tomado_planos"].ToString();
                        txtOtraFuenteInfo.Text = reader["pre_otra_fuente_info"].ToString();
                        txtNumNuevoBloque.Text = reader["pre_num_nuevo_bloque"].ToString();
                        txtNumAmpliBloque.Text = reader["pre_num_ampli_bloque"].ToString();
                        txtTipo.Text = reader["pre_tipo"].ToString();
                        txtPropiedadHorizontal.Text = reader["pre_propiedad_horizontal"].ToString();
                        txtEstado.Text = reader["pre_estado"].ToString();
                        txtDominio.Text = reader["pre_dominio"].ToString();

                        if (reader["pre_fecha_ingreso"] != DBNull.Value)
                            txtFechaIngreso.Text = Convert.ToDateTime(reader["pre_fecha_ingreso"]).ToString("yyyy-MM-dd");

                        if (reader["pre_fecha_modificacion"] != DBNull.Value)
                            txtFechaModificacion.Text = Convert.ToDateTime(reader["pre_fecha_modificacion"]).ToString("yyyy-MM-dd");

                        btnGuardar.Visible = false;
                        btnActualizar.Visible = true;
                    }
                    conexion.Close();
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "Error", $"alert('Error al cargar datos del predio: {ex.Message}');", true);
                }
            }

        }


        private void LimpiarFormulario()
        {
            hfPreId.Value = "";
            txtCodigoCatastral.Text = "";
            txtCodigoAnterior.Text = "";
            txtNumero.Text = "";
            txtNombrePredio.Text = "";
            txtAreaTotalTer.Text = "";
            txtAreaTotalConst.Text = "";
            txtFondoRelativo.Text = "";
            txtFrenteFondo.Text = "";
            txtObservaciones.Text = "";
            txtDimTomadoPlanos.Text = "";
            txtOtraFuenteInfo.Text = "";
            txtNumNuevoBloque.Text = "";
            txtNumAmpliBloque.Text = "";
            txtTipo.Text = "";
            txtPropiedadHorizontal.Text = "";
            txtEstado.Text = "";
            txtDominio.Text = "";
            txtFechaIngreso.Text = "";
            txtFechaModificacion.Text = "";
        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            if (ViewState["preId"] == null) return;

            int preId = Convert.ToInt32(ViewState["preId"]);

            decimal areaTotalTer = 0;
            decimal areaTotalConst = 0;
            decimal.TryParse(txtAreaTotalTer.Text, out areaTotalTer);
            decimal.TryParse(txtAreaTotalConst.Text, out areaTotalConst);

            bool exito = this.ActualizarPredio(
                preId,
                txtNombrePredio.Text,
                areaTotalTer,
                areaTotalConst
            );

            if (exito)
            {
                LimpiarFormulario();
                btnGuardar.Visible = true;
                btnActualizar.Visible = false;
                ClientScript.RegisterStartupScript(this.GetType(), "Success", "alert('Predio actualizado exitosamente');", true);
                consultarPredios();
            }

        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            LimpiarFormulario();
            btnGuardar.Visible = true;
            btnActualizar.Visible = false;
        }

        protected void lstPredios_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            lstPredios.PageIndex = e.NewPageIndex;
            consultarPredios(); // Vuelve a cargar los datos para la nueva página
        }
    }
}




