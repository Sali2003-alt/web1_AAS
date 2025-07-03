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




        public bool ActualizarPredio(
            long preId,
            string codigoCatastral,
            DateTime fechaIngreso,
            string codigoAnterior,
            string numero,
            string nombrePredio,
            decimal areaTotalTer,
            decimal areaTotalConst,
            decimal fondoRelativo,
            decimal frenteFondo,
            string observaciones,
            string dimTomadoPlanos,
            string otraFuenteInfo,
            string numNuevoBloque,
            short? numAmpliBloque,
            short? tipo,
            string propiedadHorizontal,
            short? estado,
            int? dominio,
            int? numHabitantes,
            string propietarioAnterior,
            string cartaTopografica,
            string fotoAerea,
            short? manId,
            short? numFamilias,
            decimal porcentajeDominio,
            string detalleDominio,
            short? tipoMixto,
            decimal valorTipoMixto,
            short? linderosDefinidos,
            decimal areaTotalTerrenoAnterior,
            string localizacionOtros,
            short? bienMostrenco,
            short? enConflicto,
            decimal areaTotalTerGrafico,
            short? propietarioDesconocido,
            decimal areaTotalTerAlfanumerico,
            short? dominioDetalle,
            string direccionPrincipal,
            decimal areaTotalConstAlfanumerico,
            string tipoVivienda,
            int? clasificacionVivienda,
            DateTime? fechaModificacion,
            short? numCelulares,
            short? modalidadPH,
            decimal alicuotaTotal,
            short? tipoPH,
            string observacionPH,
            short? hipotecaGAD,
            short? regimenPH,
            short? prorrateoTitulo
        )

        {
            const string storedProcedure = "catastro.sp_actualizar_cat_predio"; 

            // Validaciones básicas
            if (preId <= 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Error", "alert('ID de predio inválido');", true);
                return false;
            }

            using (var conexion = new NpgsqlConnection(this.cadenaConexion))
            using (var comandoActualizacion = new NpgsqlCommand(storedProcedure, conexion))
            {
                comandoActualizacion.CommandType = CommandType.StoredProcedure;

                // Configuración de parámetros
                comandoActualizacion.Parameters.AddWithValue("p_pre_id", preId);
                comandoActualizacion.Parameters.AddWithValue("p_pre_codigo_catastral", GetDbValue(codigoCatastral));
                comandoActualizacion.Parameters.AddWithValue("p_pre_fecha_ingreso", fechaIngreso);
                comandoActualizacion.Parameters.AddWithValue("p_pre_codigo_anterior", GetDbValue(codigoAnterior));
                comandoActualizacion.Parameters.AddWithValue("p_pre_numero", GetDbValue(numero));
                comandoActualizacion.Parameters.AddWithValue("p_pre_nombre_predio", GetDbValue(nombrePredio));
                comandoActualizacion.Parameters.AddWithValue("p_pre_area_total_ter", areaTotalTer);
                comandoActualizacion.Parameters.AddWithValue("p_pre_area_total_const", areaTotalConst);
                comandoActualizacion.Parameters.AddWithValue("p_pre_fondo_relativo", fondoRelativo);
                comandoActualizacion.Parameters.AddWithValue("p_pre_frente_fondo", frenteFondo);
                comandoActualizacion.Parameters.AddWithValue("p_pre_observaciones", GetDbValue(observaciones));
                comandoActualizacion.Parameters.AddWithValue("p_pre_dim_tomado_planos", dimTomadoPlanos ?? (object)DBNull.Value);
                comandoActualizacion.Parameters.AddWithValue("p_pre_otra_fuente_info", otraFuenteInfo ?? (object)DBNull.Value);
                comandoActualizacion.Parameters.AddWithValue("p_pre_num_nuevo_bloque", numNuevoBloque ?? (object)DBNull.Value);
                comandoActualizacion.Parameters.AddWithValue("p_pre_num_ampli_bloque", numAmpliBloque ?? (object)DBNull.Value);
                comandoActualizacion.Parameters.AddWithValue("p_pre_propiedad_horizontal", propiedadHorizontal ?? (object)DBNull.Value);
                comandoActualizacion.Parameters.AddWithValue("p_pre_propietario_anterior", propietarioAnterior ?? (object)DBNull.Value);
                comandoActualizacion.Parameters.AddWithValue("p_pre_foto_aerea", fotoAerea ?? (object)DBNull.Value);
                comandoActualizacion.Parameters.AddWithValue("p_pre_propietario_desconocido", propietarioDesconocido ?? (object)DBNull.Value);
                comandoActualizacion.Parameters.AddWithValue("p_pre_area_total_ter_alfanumerico", areaTotalTerAlfanumerico);
                comandoActualizacion.Parameters.AddWithValue("p_pre_direccion_principal", direccionPrincipal ?? (object)DBNull.Value);
                comandoActualizacion.Parameters.AddWithValue("p_pre_area_total_const_alfanumerico", areaTotalConstAlfanumerico);
                comandoActualizacion.Parameters.AddWithValue("p_opc_clasificacion_vivienda", clasificacionVivienda ?? (object)DBNull.Value);
                comandoActualizacion.Parameters.AddWithValue("p_pre_modalidad_propiedad_horizontal", modalidadPH ?? (object)DBNull.Value);
                comandoActualizacion.Parameters.AddWithValue("p_pre_alicuota_total_declaratoria", alicuotaTotal);
                comandoActualizacion.Parameters.AddWithValue("p_pre_tipo_propiedad_horizontal", tipoPH ?? (object)DBNull.Value);
                comandoActualizacion.Parameters.AddWithValue("p_pre_regimen_propiedad_horizontal", regimenPH ?? (object)DBNull.Value);
                comandoActualizacion.Parameters.AddWithValue("p_pre_prorrateo_titulo", prorrateoTitulo ?? (object)DBNull.Value);
                comandoActualizacion.Parameters.AddWithValue("p_pre_estado", estado ?? (object)DBNull.Value);
                comandoActualizacion.Parameters.AddWithValue("p_pre_dominio", dominio ?? (object)DBNull.Value);
                comandoActualizacion.Parameters.AddWithValue("p_pre_num_habitantes", numHabitantes ?? (object)DBNull.Value);
                comandoActualizacion.Parameters.AddWithValue("p_pre_carta_topografica", cartaTopografica ?? (object)DBNull.Value);
                comandoActualizacion.Parameters.AddWithValue("p_pre_man_id", manId ?? (object)DBNull.Value);
                comandoActualizacion.Parameters.AddWithValue("p_pre_num_familias", numFamilias ?? (object)DBNull.Value);
                comandoActualizacion.Parameters.AddWithValue("p_pre_porcentaje_dominio", porcentajeDominio);
                comandoActualizacion.Parameters.AddWithValue("p_pre_detalle_dominio", detalleDominio ?? (object)DBNull.Value);
                comandoActualizacion.Parameters.AddWithValue("p_pre_tipo_mixto", tipoMixto ?? (object)DBNull.Value);
                comandoActualizacion.Parameters.AddWithValue("p_pre_valor_tipo_mixto", valorTipoMixto);
                comandoActualizacion.Parameters.AddWithValue("p_pre_linderos_definidos", linderosDefinidos ?? (object)DBNull.Value);
                comandoActualizacion.Parameters.AddWithValue("p_pre_area_terreno_anterior", areaTotalTerrenoAnterior);
                comandoActualizacion.Parameters.AddWithValue("p_pre_localizacion_otros", localizacionOtros ?? (object)DBNull.Value);
                comandoActualizacion.Parameters.AddWithValue("p_pre_bien_mostrenco", bienMostrenco ?? (object)DBNull.Value);
                comandoActualizacion.Parameters.AddWithValue("p_pre_en_conflicto", enConflicto ?? (object)DBNull.Value);
                comandoActualizacion.Parameters.AddWithValue("p_pre_area_ter_grafico", areaTotalTerGrafico);
                comandoActualizacion.Parameters.AddWithValue("p_pre_fecha_modificacion", fechaModificacion ?? (object)DBNull.Value);
                comandoActualizacion.Parameters.AddWithValue("p_pre_num_celulares", numCelulares ?? (object)DBNull.Value);
                comandoActualizacion.Parameters.AddWithValue("p_pre_tipo_vivienda", tipoVivienda ?? (object)DBNull.Value);
                comandoActualizacion.Parameters.AddWithValue("p_pre_observacion_ph", observacionPH ?? (object)DBNull.Value);
                comandoActualizacion.Parameters.AddWithValue("p_pre_hipoteca_gad", hipotecaGAD ?? (object)DBNull.Value);
                comandoActualizacion.Parameters.AddWithValue("p_pre_dominio_detalle", dominioDetalle ?? (object)DBNull.Value);

                try
                {
                    conexion.Open();
                    int affectedRows = comandoActualizacion.ExecuteNonQuery();

                    if (affectedRows > 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "Exito", "alert('Predio actualizado correctamente');", true);
                        return true;
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "Advertencia", "alert('No se encontró el predio para actualizar');", true);
                        return false;
                    }
                }
                catch (NpgsqlException ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "Error", $"alert('Error al actualizar predio: {ex.Message.Replace("'", "\\'")}');", true);
                    return false;
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "Error", $"alert('Error inesperado: {ex.Message.Replace("'", "\\'")}');", true);
                    return false;
                }
            }
        }

        // Método auxiliar para manejar valores nulos
        private object GetDbValue(object value)
        {
            return value ?? DBNull.Value;
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
                        txtNumHabitantes.Text = reader["pre_num_habitantes"].ToString();
                        txtPropietarioAnterior.Text = reader["pre_propietario_anterior"].ToString();
                        txtClasificacionVivienda.Text = reader["opc_clasificacion_vivienda"].ToString();

                        txtCartaTopografica.Text = reader["pre_carta_topografica"].ToString();
                        txtFotoAerea.Text = reader["pre_foto_aerea"].ToString();
                        txtManId.Text = reader["man_id"].ToString();
                        txtNumFamilias.Text = reader["pre_num_familias"].ToString();
                        txtPorcentajeDominio.Text = reader["pre_porcentaje_dominio"].ToString();
                        txtDetalleDominio.Text = reader["pre_detalle_dominio"].ToString();
                        txtTipoMixto.Text = reader["pre_tipo_mixto"].ToString();
                        txtValorTipoMixto.Text = reader["pre_valor_tipo_mixto"].ToString();
                        txtLinderosDefinidos.Text = reader["pre_linderos_definidos"].ToString();
                        txtAreaTerrenoAnterior.Text = reader["pre_area_total_terreno_anterior"].ToString();
                        txtLocalizacionOtros.Text = reader["pre_localizacion_otros"].ToString();
                        txtBienMostrenco.Text = reader["pre_bien_mostrenco"].ToString();
                        txtEnConflicto.Text = reader["pre_en_conflicto"].ToString();
                        txtAreaTerGrafico.Text = reader["pre_area_total_ter_grafico"].ToString();
                        txtPropietarioDesconocido.Text = reader["pre_propietario_desconocido"].ToString();
                        txtAreaTerAlfa.Text = reader["pre_area_total_ter_alfanumerico"].ToString();
                        txtDominioDetalle.Text = reader["pre_dominio_detalle"].ToString();
                        txtDireccionPrincipal.Text = reader["pre_direccion_principal"].ToString();
                        txtAreaConstAlfa.Text = reader["pre_area_total_const_alfanumerico"].ToString();
                        txtTipoVivienda.Text = reader["pre_tipo_vivienda"].ToString();
                        txtNumCelulares.Text = reader["pre_num_celulares"].ToString();
                        txtModalidadPH.Text = reader["pre_modalidad_propiedad_horizontal"].ToString();
                        txtAlicuotaTotal.Text = reader["pre_alicuota_total_declaratoria"].ToString();
                        txtTipoPH.Text = reader["pre_tipo_propiedad_horizontal"].ToString();
                        txtObservacionPH.Text = reader["pre_observacion_ph"].ToString();
                        txtHipotecaGAD.Text = reader["pre_hipoteca_gad"].ToString();
                        txtRegimenPH.Text = reader["pre_regimen_propiedad_horizontal"].ToString();
                        txtProrrateoTitulo.Text = reader["pre_prorrateo_titulo"].ToString();

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

            // Validar que el ViewState contenga el ID del predio
            if (ViewState["preId"] == null)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Error", "alert('No se ha seleccionado un predio para actualizar');", true);
                return;
            }

            // Obtener el ID del predio
            int preId = Convert.ToInt32(ViewState["preId"]);

            try
            {
                // Convertir valores con manejo seguro de errores
                // Convertir valores con manejo seguro de errores
                bool exito = this.ActualizarPredio(
                    preId,
                    txtCodigoCatastral.Text,
                    SafeConvert.ToDateTime(txtFechaIngreso.Text),
                    txtCodigoAnterior.Text,
                    txtNumero.Text,
                    txtNombrePredio.Text,
                    SafeConvert.ToDecimal(txtAreaTotalTer.Text),
                    SafeConvert.ToDecimal(txtAreaTotalConst.Text),
                    SafeConvert.ToDecimal(txtFondoRelativo.Text),
                    SafeConvert.ToDecimal(txtFrenteFondo.Text),
                    txtObservaciones.Text,
                    txtDimTomadoPlanos.Text,
                    txtOtraFuenteInfo.Text,
                    txtNumNuevoBloque.Text,
                    SafeConvert.ToShort(txtNumAmpliBloque.Text),
                    SafeConvert.ToShort(txtTipo.Text),
                    txtPropiedadHorizontal.Text,
                    SafeConvert.ToShort(txtEstado.Text),
                    SafeConvert.ToInt(txtDominio.Text),
                    SafeConvert.ToInt(txtNumHabitantes.Text),
                    txtPropietarioAnterior.Text,
                    txtCartaTopografica.Text,
                    txtFotoAerea.Text,
                    SafeConvert.ToShort(txtManId.Text),
                    SafeConvert.ToShort(txtNumFamilias.Text),
                    SafeConvert.ToDecimal(txtPorcentajeDominio.Text),
                    txtDetalleDominio.Text,
                    SafeConvert.ToShort(txtTipoMixto.Text),
                    SafeConvert.ToDecimal(txtValorTipoMixto.Text),
                    SafeConvert.ToShort(txtLinderosDefinidos.Text),
                    SafeConvert.ToDecimal(txtAreaTerrenoAnterior.Text),
                    txtLocalizacionOtros.Text,
                    SafeConvert.ToShort(txtBienMostrenco.Text),
                    SafeConvert.ToShort(txtEnConflicto.Text),
                    SafeConvert.ToDecimal(txtAreaTerGrafico.Text),
                    SafeConvert.ToShort(txtPropietarioDesconocido.Text),
                    SafeConvert.ToDecimal(txtAreaTerAlfa.Text),
                    SafeConvert.ToShort(txtDominioDetalle.Text),
                    txtDireccionPrincipal.Text,
                    SafeConvert.ToDecimal(txtAreaConstAlfa.Text),
                    txtTipoVivienda.Text,
                    SafeConvert.ToInt(txtClasificacionVivienda.Text),
                    SafeConvert.ToDateTime(txtFechaModificacion.Text),
                    SafeConvert.ToShort(txtNumCelulares.Text),
                    SafeConvert.ToShort(txtModalidadPH.Text),
                    SafeConvert.ToDecimal(txtAlicuotaTotal.Text),
                    SafeConvert.ToShort(txtTipoPH.Text),
                    txtObservacionPH.Text,
                    SafeConvert.ToShort(txtHipotecaGAD.Text),
                    SafeConvert.ToShort(txtRegimenPH.Text),
                    SafeConvert.ToShort(txtProrrateoTitulo.Text)
                );


                if (exito)
                {
                    LimpiarFormulario();
                    btnGuardar.Visible = true;
                    btnActualizar.Visible = false;
                    ClientScript.RegisterStartupScript(this.GetType(), "Success", "alert('Predio actualizado exitosamente');", true);
                    consultarPredios();
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "Error", "alert('No se pudo actualizar el predio');", true);
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Error", $"alert('Error al actualizar predio: {ex.Message.Replace("'", "\\'")}');", true);
            }

        }



        public static class SafeConvert
        {
            public static DateTime ToDateTime(string value)
            {
                if (DateTime.TryParse(value, out DateTime result))
                    return result;
                return DateTime.MinValue; // o algún valor por defecto apropiado
            }

            public static decimal ToDecimal(string value)
            {
                if (decimal.TryParse(value, out decimal result))
                    return result;
                return 0m;
            }

            public static short ToShort(string value)
            {
                if (short.TryParse(value, out short result))
                    return result;
                return 0;
            }

            public static int ToInt(string value)
            {
                if (int.TryParse(value, out int result))
                    return result;
                return 0;
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




