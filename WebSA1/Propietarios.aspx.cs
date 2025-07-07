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
    public partial class Propietarios : System.Web.UI.Page
    {
        string cadenaConexion = "";
        NpgsqlConnection conexion;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.cadenaConexion = ConfigurationManager.ConnectionStrings["conexionBddMejia"].ConnectionString;
            this.conexion = new NpgsqlConnection(cadenaConexion);

            if (!IsPostBack)
            {
                this.CargarDropDowns();
                ConsultarPropietariosPredio(); // sin paginación manual
                btnGuardar.Visible = true;
                btnActualizar.Visible = false;
            }

        }



        private void CargarDropDowns()
        {
            CargarPropietarios();
            CargarPredios();
        }

        private void CargarPropietarios()
        {
            string query = @"
        SELECT 
            p.pro_id, 
            p.pro_nombre || ' ' || p.pro_apellido AS NombreCompleto
        FROM 
            gestion.ges_propietario p
        ORDER BY 
            NombreCompleto ASC";

            try
            {
                using (var conexion = new NpgsqlConnection(cadenaConexion))
                {
                    conexion.Open();
                    using (var cmd = new NpgsqlCommand(query, conexion))
                    {
                        using (var da = new NpgsqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);

                            ddlPropietario.DataSource = dt;
                            ddlPropietario.DataTextField = "NombreCompleto";
                            ddlPropietario.DataValueField = "pro_id";
                            ddlPropietario.DataBind();

                            ddlConyuge.DataSource = dt.Copy();
                            ddlConyuge.DataTextField = "NombreCompleto";
                            ddlConyuge.DataValueField = "pro_id";
                            ddlConyuge.DataBind();

                            ddlRepresentanteLegal.DataSource = dt.Copy();
                            ddlRepresentanteLegal.DataTextField = "NombreCompleto";
                            ddlRepresentanteLegal.DataValueField = "pro_id";
                            ddlRepresentanteLegal.DataBind();

                            ddlPropietario.Items.Insert(0, new ListItem("-- Seleccione Propietario --", "0"));
                            ddlConyuge.Items.Insert(0, new ListItem("-- Seleccione Cónyuge --", "0"));
                            ddlRepresentanteLegal.Items.Insert(0, new ListItem("-- Seleccione Representante Legal --", "0"));
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Error", $"alert('Error al cargar propietarios: {ex.Message}');", true);
            }
        }

        private void CargarPredios()
        {
            string query = "SELECT pre_id, pre_nombre_predio FROM catastro.cat_predio";

            try
            {
                using (var conexion = new NpgsqlConnection(cadenaConexion))
                {
                    conexion.Open();
                    using (var cmd = new NpgsqlCommand(query, conexion))
                    {
                        using (var da = new NpgsqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);

                            ddlPredio.DataSource = dt;
                            ddlPredio.DataTextField = "pre_nombre_predio";
                            ddlPredio.DataValueField = "pre_id";
                            ddlPredio.DataBind();
                            ddlPredio.Items.Insert(0, new ListItem("-- Seleccione Predio --", "0"));
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Error", $"alert('Error al cargar predios: {ex.Message}');", true);
            }
        }



        public bool InsertarPropietarioPredio(
            int proId, int? proIdConyuge, int? proIdRepLegal, long preId,
            decimal prpAlicuota, int prpAniosPosesion, string prpObservacion,
            short prpTieneEscritura, short prpRepresentante, int? opcAdquisicion,
            int? opcSituacionActual, string prpCelebradoAnte, string prpCanton,
            string prpNotaria, DateTime? prpFechaInscripcion, string prpLugarInscripcion,
            short? prpPerfeccionamiento, string prpLugarRegistro, string prpRegistroPropiedad,
            DateTime? prpFechaRegistro, string prpLibro, string prpFoja,
            string prpSituacionLegal, short? prpFinanciado, string prpNombrePueblo,
            int? prpAniosPerfeccionamiento, decimal? prpAreaEscritura, int? opcParentesco)
        {
            NpgsqlCommand comandoInsercion = new NpgsqlCommand("catastro.sp_insertar_propietario_predio", conexion);
            comandoInsercion.CommandType = CommandType.StoredProcedure;

            // Parámetros requeridos
            comandoInsercion.Parameters.AddWithValue("p_pro_id", proId);
            comandoInsercion.Parameters.AddWithValue("p_pre_id", preId);

            // Parámetros opcionales con manejo de nulos
            AddNullableParameter(comandoInsercion, "p_pro_id_conyuge", proIdConyuge);
            AddNullableParameter(comandoInsercion, "p_pro_id_rep_legal", proIdRepLegal);
            AddNullableParameter(comandoInsercion, "p_prp_alicuota", prpAlicuota);
            AddNullableParameter(comandoInsercion, "p_prp_anios_posesion", prpAniosPosesion);
            AddNullableParameter(comandoInsercion, "p_prp_observacion", prpObservacion);
            AddNullableParameter(comandoInsercion, "p_prp_tiene_escritura", prpTieneEscritura);
            AddNullableParameter(comandoInsercion, "p_prp_representante", prpRepresentante);
            AddNullableParameter(comandoInsercion, "p_opc_adquisicion", opcAdquisicion);
            AddNullableParameter(comandoInsercion, "p_opc_situacion_actual", opcSituacionActual);
            AddNullableParameter(comandoInsercion, "p_prp_celebrado_ante", prpCelebradoAnte);
            AddNullableParameter(comandoInsercion, "p_prp_canton", prpCanton);
            AddNullableParameter(comandoInsercion, "p_prp_notaria", prpNotaria);
            AddNullableParameter(comandoInsercion, "p_prp_fecha_inscripcion", prpFechaInscripcion);
            AddNullableParameter(comandoInsercion, "p_prp_lugar_inscripcion", prpLugarInscripcion);
            AddNullableParameter(comandoInsercion, "p_prp_perfeccionamiento", prpPerfeccionamiento);
            AddNullableParameter(comandoInsercion, "p_prp_lugar_registro", prpLugarRegistro);
            AddNullableParameter(comandoInsercion, "p_prp_registro_propiedad", prpRegistroPropiedad);
            AddNullableParameter(comandoInsercion, "p_prp_fecha_registro", prpFechaRegistro);
            AddNullableParameter(comandoInsercion, "p_prp_libro", prpLibro);
            AddNullableParameter(comandoInsercion, "p_prp_foja", prpFoja);
            AddNullableParameter(comandoInsercion, "p_prp_situacion_legal", prpSituacionLegal);
            AddNullableParameter(comandoInsercion, "p_prp_financiado", prpFinanciado);
            AddNullableParameter(comandoInsercion, "p_prp_nombre_pueblo", prpNombrePueblo);
            AddNullableParameter(comandoInsercion, "p_prp_anios_perfeccionamiento", prpAniosPerfeccionamiento);
            AddNullableParameter(comandoInsercion, "p_prp_area_escritura", prpAreaEscritura);
            AddNullableParameter(comandoInsercion, "p_opc_parentesco", opcParentesco);

            try
            {
                conexion.Open();
                comandoInsercion.ExecuteNonQuery();
                conexion.Close();
                return true;
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Error", $"alert('Error al insertar relación propietario-predio: {ex.Message}');", true);
                return false;
            }
        }

        private void AddNullableParameter(NpgsqlCommand command, string parameterName, object value)
        {
            if (value != null)
            {
                command.Parameters.AddWithValue(parameterName, value);
            }
            else
            {
                command.Parameters.AddWithValue(parameterName, DBNull.Value);
            }
        }

        public bool ActualizarPropietarioPredio(
            int prpId, int proId, int? proIdConyuge, int? proIdRepLegal, long preId,
            decimal prpAlicuota, int prpAniosPosesion, string prpObservacion,
            short prpTieneEscritura, short prpRepresentante, int? opcAdquisicion,
            int? opcSituacionActual, string prpCelebradoAnte, string prpCanton,
            string prpNotaria, DateTime? prpFechaInscripcion, string prpLugarInscripcion,
            short? prpPerfeccionamiento, string prpLugarRegistro, string prpRegistroPropiedad,
            DateTime? prpFechaRegistro, string prpLibro, string prpFoja,
            string prpSituacionLegal, short? prpFinanciado, string prpNombrePueblo,
            int? prpAniosPerfeccionamiento, decimal? prpAreaEscritura, int? opcParentesco)
        {
            NpgsqlCommand comandoActualizacion = new NpgsqlCommand("catastro.sp_actualizar_propietario_predio", conexion);
            comandoActualizacion.CommandType = CommandType.StoredProcedure;

            comandoActualizacion.Parameters.AddWithValue("p_prp_id", prpId);
            comandoActualizacion.Parameters.AddWithValue("p_pro_id", proId);
            comandoActualizacion.Parameters.AddWithValue("p_pre_id", preId);

            // Parámetros opcionales con manejo de nulos
            AddNullableParameter(comandoActualizacion, "p_pro_id_conyuge", proIdConyuge);
            AddNullableParameter(comandoActualizacion, "p_pro_id_rep_legal", proIdRepLegal);
            AddNullableParameter(comandoActualizacion, "p_prp_alicuota", prpAlicuota);
            AddNullableParameter(comandoActualizacion, "p_prp_anios_posesion", prpAniosPosesion);
            AddNullableParameter(comandoActualizacion, "p_prp_observacion", prpObservacion);
            AddNullableParameter(comandoActualizacion, "p_prp_tiene_escritura", prpTieneEscritura);
            AddNullableParameter(comandoActualizacion, "p_prp_representante", prpRepresentante);
            AddNullableParameter(comandoActualizacion, "p_opc_adquisicion", opcAdquisicion);
            AddNullableParameter(comandoActualizacion, "p_opc_situacion_actual", opcSituacionActual);
            AddNullableParameter(comandoActualizacion, "p_prp_celebrado_ante", prpCelebradoAnte);
            AddNullableParameter(comandoActualizacion, "p_prp_canton", prpCanton);
            AddNullableParameter(comandoActualizacion, "p_prp_notaria", prpNotaria);
            AddNullableParameter(comandoActualizacion, "p_prp_fecha_inscripcion", prpFechaInscripcion);
            AddNullableParameter(comandoActualizacion, "p_prp_lugar_inscripcion", prpLugarInscripcion);
            AddNullableParameter(comandoActualizacion, "p_prp_perfeccionamiento", prpPerfeccionamiento);
            AddNullableParameter(comandoActualizacion, "p_prp_lugar_registro", prpLugarRegistro);
            AddNullableParameter(comandoActualizacion, "p_prp_registro_propiedad", prpRegistroPropiedad);
            AddNullableParameter(comandoActualizacion, "p_prp_fecha_registro", prpFechaRegistro);
            AddNullableParameter(comandoActualizacion, "p_prp_libro", prpLibro);
            AddNullableParameter(comandoActualizacion, "p_prp_foja", prpFoja);
            AddNullableParameter(comandoActualizacion, "p_prp_situacion_legal", prpSituacionLegal);
            AddNullableParameter(comandoActualizacion, "p_prp_financiado", prpFinanciado);
            AddNullableParameter(comandoActualizacion, "p_prp_nombre_pueblo", prpNombrePueblo);
            AddNullableParameter(comandoActualizacion, "p_prp_anios_perfeccionamiento", prpAniosPerfeccionamiento);
            AddNullableParameter(comandoActualizacion, "p_prp_area_escritura", prpAreaEscritura);
            AddNullableParameter(comandoActualizacion, "p_opc_parentesco", opcParentesco);

            try
            {
                conexion.Open();
                comandoActualizacion.ExecuteNonQuery();
                conexion.Close();
                return true;
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Error", $"alert('Error al actualizar relación propietario-predio: {ex.Message}');", true);
                return false;
            }
        }


        private void LimpiarFormulario()
        {
            hfPrpId.Value = "";
            ddlPropietario.SelectedIndex = 0;
            ddlConyuge.SelectedIndex = 0;
            ddlRepresentanteLegal.SelectedIndex = 0;
            ddlPredio.SelectedIndex = 0;
            txtAlicuota.Text = "";
            txtAniosPosesion.Text = "";
            txtObservacion.Text = "";
            ddlTieneEscritura.SelectedIndex = 0;
            ddlRepresentante.SelectedIndex = 0;
            txtOpcAdquisicion.Text = "";
            txtOpcSituacionActual.Text = "";
            txtCelebradoAnte.Text = "";
            txtCanton.Text = "";
            txtNotaria.Text = "";
            txtFechaInscripcion.Text = "";
            txtLugarInscripcion.Text = "";
            ddlPerfeccionamiento.SelectedIndex = 0;
            txtLugarRegistro.Text = "";
            txtRegistroPropiedad.Text = "";
            txtFechaRegistro.Text = "";
            txtLibro.Text = "";
            txtFoja.Text = "";
            txtSituacionLegal.Text = "";
            ddlFinanciado.SelectedIndex = 0;
            txtNombrePueblo.Text = "";
            txtAniosPerfeccionamiento.Text = "";
            txtAreaEscritura.Text = "";
            txtOpcParentesco.Text = "";
        }

        public void ConsultarPropietariosPredio()
        {
            string query = "SELECT * FROM catastro.fn_consultar_propietarios_predio() ORDER BY prp_id";

            try
            {
                using (var cmd = new NpgsqlCommand(query, conexion))
                {
                    NpgsqlDataAdapter adaptador = new NpgsqlDataAdapter(cmd);
                    DataTable tabla = new DataTable();
                    adaptador.Fill(tabla);

                    lstPropietarios.DataSource = tabla;
                    lstPropietarios.DataBind();
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Error", $"alert('Error al consultar: {ex.Message}');", true);
            }
        }




        public bool EliminarPropietarioPredio(int prpId)
        {
            bool eliminadoOk = false;

            NpgsqlCommand comandoEliminar = new NpgsqlCommand("CALL catastro.sp_eliminar_propietario_predio(@p_prp_id)", this.conexion);
            comandoEliminar.CommandType = CommandType.Text;
            comandoEliminar.Parameters.AddWithValue("@p_prp_id", prpId);

            try
            {
                conexion.Open();
                comandoEliminar.ExecuteNonQuery();
                eliminadoOk = true;
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Error", $"alert('Error al eliminar: {ex.Message}');", true);
            }
            finally
            {
                conexion.Close();
                ConsultarPropietariosPredio(); // Recarga la tabla
            }

            return eliminadoOk;
        }



        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            // Validaciones básicas
            if (ddlPropietario.SelectedValue == "0" || ddlPredio.SelectedValue == "0")
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Error", "alert('Debe seleccionar un propietario y un predio');", true);
                return;
            }

            // Obtener valores de los controles
            int proId = Convert.ToInt32(ddlPropietario.SelectedValue);
            int? proIdConyuge = ddlConyuge.SelectedValue == "0" ? (int?)null : Convert.ToInt32(ddlConyuge.SelectedValue);
            int? proIdRepLegal = ddlRepresentanteLegal.SelectedValue == "0" ? (int?)null : Convert.ToInt32(ddlRepresentanteLegal.SelectedValue);
            long preId = Convert.ToInt64(ddlPredio.SelectedValue);

            decimal prpAlicuota;
            decimal.TryParse(txtAlicuota.Text, out prpAlicuota);

            int prpAniosPosesion;
            int.TryParse(txtAniosPosesion.Text, out prpAniosPosesion);

            string prpObservacion = txtObservacion.Text;
            short prpTieneEscritura = Convert.ToInt16(ddlTieneEscritura.SelectedValue);
            short prpRepresentante = Convert.ToInt16(ddlRepresentante.SelectedValue);

            int? opcAdquisicion = string.IsNullOrEmpty(txtOpcAdquisicion.Text) ? (int?)null : Convert.ToInt32(txtOpcAdquisicion.Text);
            int? opcSituacionActual = string.IsNullOrEmpty(txtOpcSituacionActual.Text) ? (int?)null : Convert.ToInt32(txtOpcSituacionActual.Text);
            string prpCelebradoAnte = txtCelebradoAnte.Text;
            string prpCanton = txtCanton.Text;
            string prpNotaria = txtNotaria.Text;

            DateTime? prpFechaInscripcion = string.IsNullOrEmpty(txtFechaInscripcion.Text) ? (DateTime?)null : DateTime.Parse(txtFechaInscripcion.Text);
            string prpLugarInscripcion = txtLugarInscripcion.Text;
            short? prpPerfeccionamiento = string.IsNullOrEmpty(ddlPerfeccionamiento.SelectedValue) ? (short?)null : Convert.ToInt16(ddlPerfeccionamiento.SelectedValue);
            string prpLugarRegistro = txtLugarRegistro.Text;
            string prpRegistroPropiedad = txtRegistroPropiedad.Text;

            DateTime? prpFechaRegistro = string.IsNullOrEmpty(txtFechaRegistro.Text) ? (DateTime?)null : DateTime.Parse(txtFechaRegistro.Text);
            string prpLibro = txtLibro.Text;
            string prpFoja = txtFoja.Text;
            string prpSituacionLegal = txtSituacionLegal.Text;
            short? prpFinanciado = string.IsNullOrEmpty(ddlFinanciado.SelectedValue) ? (short?)null : Convert.ToInt16(ddlFinanciado.SelectedValue);
            string prpNombrePueblo = txtNombrePueblo.Text;

            int? prpAniosPerfeccionamiento = string.IsNullOrEmpty(txtAniosPerfeccionamiento.Text) ? (int?)null : Convert.ToInt32(txtAniosPerfeccionamiento.Text);
            decimal? prpAreaEscritura = string.IsNullOrEmpty(txtAreaEscritura.Text) ? (decimal?)null : decimal.Parse(txtAreaEscritura.Text);
            int? opcParentesco = string.IsNullOrEmpty(txtOpcParentesco.Text) ? (int?)null : Convert.ToInt32(txtOpcParentesco.Text);

            bool exito = this.InsertarPropietarioPredio(
                proId, proIdConyuge, proIdRepLegal, preId,
                prpAlicuota, prpAniosPosesion, prpObservacion, prpTieneEscritura,
                prpRepresentante, opcAdquisicion, opcSituacionActual, prpCelebradoAnte,
                prpCanton, prpNotaria, prpFechaInscripcion, prpLugarInscripcion,
                prpPerfeccionamiento, prpLugarRegistro, prpRegistroPropiedad,
                prpFechaRegistro, prpLibro, prpFoja, prpSituacionLegal,
                prpFinanciado, prpNombrePueblo, prpAniosPerfeccionamiento,
                prpAreaEscritura, opcParentesco
            );

            if (exito)
            {
                LimpiarFormulario();
                ClientScript.RegisterStartupScript(this.GetType(), "Success", @"
                    Swal.fire({
                        title: '¡Guardado!',
                        text: 'Relación propietario-predio guardada exitosamente',
                        icon: 'success',
                        confirmButtonText: 'Aceptar',
                        allowOutsideClick: false
                    });
                ", true);
                ConsultarPropietariosPredio();
            }
        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            if (ViewState["prpId"] == null) return;

            int prpId = Convert.ToInt32(ViewState["prpId"]);

            // Obtener valores de los controles (similar a btnGuardar_Click)
            int proId = Convert.ToInt32(ddlPropietario.SelectedValue);
            int? proIdConyuge = ddlConyuge.SelectedValue == "0" ? (int?)null : Convert.ToInt32(ddlConyuge.SelectedValue);
            int? proIdRepLegal = ddlRepresentanteLegal.SelectedValue == "0" ? (int?)null : Convert.ToInt32(ddlRepresentanteLegal.SelectedValue);
            long preId = Convert.ToInt64(ddlPredio.SelectedValue);

            decimal prpAlicuota;
            decimal.TryParse(txtAlicuota.Text, out prpAlicuota);

            int prpAniosPosesion;
            int.TryParse(txtAniosPosesion.Text, out prpAniosPosesion);

            string prpObservacion = txtObservacion.Text;
            short prpTieneEscritura = Convert.ToInt16(ddlTieneEscritura.SelectedValue);
            short prpRepresentante = Convert.ToInt16(ddlRepresentante.SelectedValue);

            int? opcAdquisicion = string.IsNullOrEmpty(txtOpcAdquisicion.Text) ? (int?)null : Convert.ToInt32(txtOpcAdquisicion.Text);
            int? opcSituacionActual = string.IsNullOrEmpty(txtOpcSituacionActual.Text) ? (int?)null : Convert.ToInt32(txtOpcSituacionActual.Text);
            string prpCelebradoAnte = txtCelebradoAnte.Text;
            string prpCanton = txtCanton.Text;
            string prpNotaria = txtNotaria.Text;

            DateTime? prpFechaInscripcion = string.IsNullOrEmpty(txtFechaInscripcion.Text) ? (DateTime?)null : DateTime.Parse(txtFechaInscripcion.Text);
            string prpLugarInscripcion = txtLugarInscripcion.Text;
            short? prpPerfeccionamiento = string.IsNullOrEmpty(ddlPerfeccionamiento.SelectedValue) ? (short?)null : Convert.ToInt16(ddlPerfeccionamiento.SelectedValue);
            string prpLugarRegistro = txtLugarRegistro.Text;
            string prpRegistroPropiedad = txtRegistroPropiedad.Text;

            DateTime? prpFechaRegistro = string.IsNullOrEmpty(txtFechaRegistro.Text) ? (DateTime?)null : DateTime.Parse(txtFechaRegistro.Text);
            string prpLibro = txtLibro.Text;
            string prpFoja = txtFoja.Text;
            string prpSituacionLegal = txtSituacionLegal.Text;
            short? prpFinanciado = string.IsNullOrEmpty(ddlFinanciado.SelectedValue) ? (short?)null : Convert.ToInt16(ddlFinanciado.SelectedValue);
            string prpNombrePueblo = txtNombrePueblo.Text;

            int? prpAniosPerfeccionamiento = string.IsNullOrEmpty(txtAniosPerfeccionamiento.Text) ? (int?)null : Convert.ToInt32(txtAniosPerfeccionamiento.Text);
            decimal? prpAreaEscritura = string.IsNullOrEmpty(txtAreaEscritura.Text) ? (decimal?)null : decimal.Parse(txtAreaEscritura.Text);
            int? opcParentesco = string.IsNullOrEmpty(txtOpcParentesco.Text) ? (int?)null : Convert.ToInt32(txtOpcParentesco.Text);

            bool exito = this.ActualizarPropietarioPredio(
                prpId, proId, proIdConyuge, proIdRepLegal, preId,
                prpAlicuota, prpAniosPosesion, prpObservacion, prpTieneEscritura,
                prpRepresentante, opcAdquisicion, opcSituacionActual, prpCelebradoAnte,
                prpCanton, prpNotaria, prpFechaInscripcion, prpLugarInscripcion,
                prpPerfeccionamiento, prpLugarRegistro, prpRegistroPropiedad,
                prpFechaRegistro, prpLibro, prpFoja, prpSituacionLegal,
                prpFinanciado, prpNombrePueblo, prpAniosPerfeccionamiento,
                prpAreaEscritura, opcParentesco
            );

            if (exito)
            {
                LimpiarFormulario();
                btnGuardar.Visible = true;
                btnActualizar.Visible = false;
                ClientScript.RegisterStartupScript(this.GetType(), "Success", @"
                    Swal.fire({
                        title: '¡Actualizado!',
                        text: 'Relación propietario-predio actualizada exitosamente',
                        icon: 'success',
                        confirmButtonText: 'Aceptar',
                        allowOutsideClick: false
                    });
                ", true);
                ConsultarPropietariosPredio();
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            LimpiarFormulario();
            btnGuardar.Visible = true;
            btnActualizar.Visible = false;
        }

        protected void lstPropietarios_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int prpId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Eliminar")
            {
                bool eliminado = EliminarPropietarioPredio(prpId);

                if (eliminado)
                {
                    string script = @"
                Swal.fire({
                    title: '¡Eliminado correctamente!',
                    text: 'El registro fue eliminado con éxito.',
                    icon: 'success',
                    confirmButtonText: 'Aceptar'
                });
            ";

                    ScriptManager.RegisterStartupScript(this, GetType(), "SwalExito", script, true);
                }
            }

            if (e.CommandName == "Modificar")
            {
                NpgsqlCommand comandoConsulta = new NpgsqlCommand("SELECT * FROM catastro.cat_propietario_predio WHERE prp_id = @prpId", this.conexion);
                comandoConsulta.Parameters.AddWithValue("@prpId", prpId);

                try
                {
                    conexion.Open();
                    NpgsqlDataReader reader = comandoConsulta.ExecuteReader();
                    if (reader.Read())
                    {
                        ViewState["prpId"] = prpId;
                        hfPrpId.Value = prpId.ToString();

                        // Cargar datos en los controles
                        ddlPropietario.SelectedValue = reader["pro_id"].ToString();

                        if (reader["pro_id_conyuge"] != DBNull.Value)
                            ddlConyuge.SelectedValue = reader["pro_id_conyuge"].ToString();

                        if (reader["pro_id_rep_legal"] != DBNull.Value)
                            ddlRepresentanteLegal.SelectedValue = reader["pro_id_rep_legal"].ToString();

                        ddlPredio.SelectedValue = reader["pre_id"].ToString();

                        if (reader["prp_alicuota"] != DBNull.Value)
                            txtAlicuota.Text = reader["prp_alicuota"].ToString();

                        if (reader["prp_anios_posesion"] != DBNull.Value)
                            txtAniosPosesion.Text = reader["prp_anios_posesion"].ToString();

                        txtObservacion.Text = reader["prp_observacion"].ToString();

                        if (reader["prp_tiene_escritura"] != DBNull.Value)
                            ddlTieneEscritura.SelectedValue = reader["prp_tiene_escritura"].ToString();

                        if (reader["prp_representante"] != DBNull.Value)
                            ddlRepresentante.SelectedValue = reader["prp_representante"].ToString();

                        if (reader["opc_adquisicion"] != DBNull.Value)
                            txtOpcAdquisicion.Text = reader["opc_adquisicion"].ToString();

                        if (reader["opc_situacion_actual"] != DBNull.Value)
                            txtOpcSituacionActual.Text = reader["opc_situacion_actual"].ToString();

                        txtCelebradoAnte.Text = reader["prp_celebrado_ante"].ToString();
                        txtCanton.Text = reader["prp_canton"].ToString();
                        txtNotaria.Text = reader["prp_notaria"].ToString();

                        if (reader["prp_fecha_inscripcion"] != DBNull.Value)
                            txtFechaInscripcion.Text = Convert.ToDateTime(reader["prp_fecha_inscripcion"]).ToString("yyyy-MM-dd");

                        txtLugarInscripcion.Text = reader["prp_lugar_inscripcion"].ToString();

                        if (reader["prp_perfeccionamiento"] != DBNull.Value)
                            ddlPerfeccionamiento.SelectedValue = reader["prp_perfeccionamiento"].ToString();

                        txtLugarRegistro.Text = reader["prp_lugar_registro"].ToString();
                        txtRegistroPropiedad.Text = reader["prp_registro_propiedad"].ToString();

                        if (reader["prp_fecha_registro"] != DBNull.Value)
                            txtFechaRegistro.Text = Convert.ToDateTime(reader["prp_fecha_registro"]).ToString("yyyy-MM-dd");

                        txtLibro.Text = reader["prp_libro"].ToString();
                        txtFoja.Text = reader["prp_foja"].ToString();
                        txtSituacionLegal.Text = reader["prp_situacion_legal"].ToString();

                        if (reader["prp_financiado"] != DBNull.Value)
                            ddlFinanciado.SelectedValue = reader["prp_financiado"].ToString();

                        txtNombrePueblo.Text = reader["prp_nombre_pueblo"].ToString();

                        if (reader["prp_anios_perfeccionamiento"] != DBNull.Value)
                            txtAniosPerfeccionamiento.Text = reader["prp_anios_perfeccionamiento"].ToString();

                        if (reader["prp_area_escritura"] != DBNull.Value)
                            txtAreaEscritura.Text = reader["prp_area_escritura"].ToString();

                        if (reader["opc_parentesco"] != DBNull.Value)
                            txtOpcParentesco.Text = reader["opc_parentesco"].ToString();

                        btnGuardar.Visible = false;
                        btnActualizar.Visible = true;
                    }
                    conexion.Close();
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "Error", $"alert('Error al cargar datos de la relación propietario-predio: {ex.Message}');", true);
                }
            }
        }

        protected void lstPropietarios_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            lstPropietarios.PageIndex = e.NewPageIndex;
            ConsultarPropietariosPredio();
        }


    }
}