<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Propietarios.aspx.cs" Inherits="WebSA1.Propietarios" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="container d-flex justify-content-center align-items-center mt-5">
    <div class="col-md-8">
        <asp:Panel ID="pnlPropietario" runat="server" CssClass="p-5 border rounded bg-white shadow-lg">
            <h3 class="text-center mb-4">Gestión de Propietarios</h3>

            <asp:HiddenField ID="hfPrpId" runat="server" />

            <!-- Relaciones con Propietarios y Predio -->
            <div class="row mb-3">
                <div class="col">
                    <label><b>Propietario:</b></label>
                    <asp:DropDownList ID="ddlPropietario" runat="server" CssClass="form-control" style="height: 42px;" DataTextField="NombreCompleto" DataValueField="pro_id">
                        <asp:ListItem Text="-- Seleccione Propietario --" Value="0" />
                    </asp:DropDownList>
                </div>
                <div class="col">
                    <label><b>Cónyuge:</b></label>
                    <asp:DropDownList ID="ddlConyuge" runat="server" CssClass="form-control" style="height: 42px;" DataTextField="NombreCompleto" DataValueField="pro_id_conyuge">
                        <asp:ListItem Text="-- Seleccione Cónyuge --" Value="0" />
                    </asp:DropDownList>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col">
                    <label><b>Representante Legal:</b></label>
                    <asp:DropDownList ID="ddlRepresentanteLegal" runat="server" CssClass="form-control" style="height: 42px;" DataTextField="NombreCompleto" DataValueField="pro_id_rep_legal">
                        <asp:ListItem Text="-- Seleccione Representante Legal --" Value="0" />
                    </asp:DropDownList>
                </div>
                <div class="col">
                    <label><b>Predio:</b></label>
                    <asp:DropDownList ID="ddlPredio" runat="server" CssClass="form-control" style="height: 42px;" DataTextField="pre_nombre_predio" DataValueField="pre_id">
                        <asp:ListItem Text="-- Seleccione Predio --" Value="0" />
                    </asp:DropDownList>
                </div>
            </div>

            <!-- Campos Propios del propietario en el predio -->
            <div class="row mb-3">
                <div class="col">
                    <label><b>Alicuota (%):</b></label>
                    <asp:TextBox ID="txtAlicuota" runat="server" CssClass="form-control" TextMode="Number" Step="0.01" />
                </div>
                <div class="col">
                    <label><b>Años de Posesión:</b></label>
                    <asp:TextBox ID="txtAniosPosesion" runat="server" CssClass="form-control" TextMode="Number" />
                </div>
            </div>

            <div class="mb-3">
                <label><b>Observación:</b></label>
                <asp:TextBox ID="txtObservacion" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" />
            </div>

            <div class="row mb-3">
                <div class="col">
                    <label><b>¿Tiene Escritura? (Sí=1, No=0):</b></label>
                    <asp:DropDownList ID="ddlTieneEscritura" runat="server" CssClass="form-control" style="height: 42px;">
                        <asp:ListItem Text="No" Value="0" />
                        <asp:ListItem Text="Sí" Value="1" />
                    </asp:DropDownList>
                </div>
                <div class="col">
                    <label><b>¿Es Representante?:</b></label>
                    <asp:DropDownList ID="ddlRepresentante" runat="server" CssClass="form-control" style="height: 42px;">
                        <asp:ListItem Text="No" Value="0" />
                        <asp:ListItem Text="Sí" Value="1" />
                    </asp:DropDownList>
                </div>
            </div>

            <!-- Más campos -->
            <div class="row mb-3">
                <div class="col">
                    <label><b>Opción de Adquisición:</b></label>
                    <asp:TextBox ID="txtOpcAdquisicion" runat="server" CssClass="form-control" TextMode="Number" />
                </div>
                <div class="col">
                    <label><b>Situación Actual:</b></label>
                    <asp:TextBox ID="txtOpcSituacionActual" runat="server" CssClass="form-control" TextMode="Number" />
                </div>
            </div>

            <div class="row mb-3">
                <div class="col">
                    <label><b>Celebrado Ante:</b></label>
                    <asp:TextBox ID="txtCelebradoAnte" runat="server" CssClass="form-control" />
                </div>
                <div class="col">
                    <label><b>Cantón:</b></label>
                    <asp:TextBox ID="txtCanton" runat="server" CssClass="form-control" />
                </div>
            </div>

            <div class="row mb-3">
                <div class="col">
                    <label><b>Notaría:</b></label>
                    <asp:TextBox ID="txtNotaria" runat="server" CssClass="form-control" />
                </div>
                <div class="col">
                    <label><b>Fecha Inscripción:</b></label>
                    <asp:TextBox ID="txtFechaInscripcion" runat="server" CssClass="form-control" Placeholder="yyyy-MM-dd" />
                </div>
            </div>

            <div class="row mb-3">
                <div class="col">
                    <label><b>Lugar Inscripción:</b></label>
                    <asp:TextBox ID="txtLugarInscripcion" runat="server" CssClass="form-control" />
                </div>
                <div class="col">
                    <label><b>Perfeccionamiento (Sí=1, No=0):</b></label>
                    <asp:DropDownList ID="ddlPerfeccionamiento" runat="server" CssClass="form-control" style="height: 42px;">
                        <asp:ListItem Text="No" Value="0" />
                        <asp:ListItem Text="Sí" Value="1" />
                    </asp:DropDownList>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col">
                    <label><b>Lugar Registro:</b></label>
                    <asp:TextBox ID="txtLugarRegistro" runat="server" CssClass="form-control" />
                </div>
                <div class="col">
                    <label><b>Registro Propiedad:</b></label>
                    <asp:TextBox ID="txtRegistroPropiedad" runat="server" CssClass="form-control" />
                </div>
            </div>

            <div class="row mb-3">
                <div class="col">
                    <label><b>Fecha Registro:</b></label>
                    <asp:TextBox ID="txtFechaRegistro" runat="server" CssClass="form-control" Placeholder="yyyy-MM-dd" />
                </div>
                <div class="col">
                    <label><b>Libro:</b></label>
                    <asp:TextBox ID="txtLibro" runat="server" CssClass="form-control" />
                </div>
            </div>

            <div class="row mb-3">
                <div class="col">
                    <label><b>Foja:</b></label>
                    <asp:TextBox ID="txtFoja" runat="server" CssClass="form-control" />
                </div>
                <div class="col">
                    <label><b>Situación Legal:</b></label>
                    <asp:TextBox ID="txtSituacionLegal" runat="server" CssClass="form-control" />
                </div>
            </div>

            <div class="row mb-3">
                <div class="col">
                    <label><b>¿Está Financiado?:</b></label>
                    <asp:DropDownList ID="ddlFinanciado" runat="server" CssClass="form-control" style="height: 42px;">
                        <asp:ListItem Text="No" Value="0" />
                        <asp:ListItem Text="Sí" Value="1" />
                    </asp:DropDownList>
                </div>
                <div class="col">
                    <label><b>Nombre Pueblo:</b></label>
                    <asp:TextBox ID="txtNombrePueblo" runat="server" CssClass="form-control" />
                </div>
            </div>

            <div class="row mb-3">
                <div class="col">
                    <label><b>Años Perfeccionamiento:</b></label>
                    <asp:TextBox ID="txtAniosPerfeccionamiento" runat="server" CssClass="form-control" TextMode="Number" />
                </div>
                <div class="col">
                    <label><b>Área Escritura:</b></label>
                    <asp:TextBox ID="txtAreaEscritura" runat="server" CssClass="form-control" TextMode="Number" Step="0.01" />
                </div>
            </div>

            <div class="mb-3">
                <label><b>Parentesco (Opcional):</b></label>
                <asp:TextBox ID="txtOpcParentesco" runat="server" CssClass="form-control" TextMode="Number" />
            </div>

            <div class="d-flex justify-content-between">
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-success" OnClick="btnGuardar_Click" />
                <asp:Button ID="btnActualizar" runat="server" Text="Actualizar" CssClass="btn btn-warning" Visible="false" OnClick="btnActualizar_Click" />
                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary" Visible="false" OnClick="btnCancelar_Click" />
            </div>
        </asp:Panel>
    </div>
</div>

    <br />
   <div class="container d-flex justify-content-start align-items-center" style="margin-left: 16%;">
    <div class="col-md-8">
        <h2 class="text-center mb-4">Listado de Propietarios</h2>

        <asp:GridView ID="lstPropietarios" runat="server"
            CssClass="table table-bordered table-striped table-hover text-center align-middle shadow-sm"
            AutoGenerateColumns="False"
            PageSize="10"
            AllowPaging="true"
            DataKeyNames="prp_id"
            PagerStyle-CssClass="pagination justify-content-center my-3"
            HeaderStyle-CssClass="table-primary"
            OnRowCommand="lstPropietarios_RowCommand"
            OnPageIndexChanging="lstPropietarios_PageIndexChanging">

            <Columns>
                <asp:BoundField DataField="prp_id" HeaderText="ID" />
                <asp:BoundField DataField="pro_id" HeaderText="ID Propietario" />
                <asp:BoundField DataField="pro_id_conyuge" HeaderText="ID Cónyuge" />
                <asp:BoundField DataField="pro_id_rep_legal" HeaderText="ID Rep Legal" />
                <asp:BoundField DataField="pre_id" HeaderText="ID Predio" />
                <asp:BoundField DataField="prp_alicuota" HeaderText="Alicuota (%)" DataFormatString="{0:N2}" />
                <asp:BoundField DataField="prp_tiene_escritura" HeaderText="Tiene Escritura" />
                <asp:BoundField DataField="prp_representante" HeaderText="Representante" />
                <asp:BoundField DataField="prp_fecha_inscripcion" HeaderText="Fecha Inscripción" DataFormatString="{0:yyyy-MM-dd}" />
                <asp:BoundField DataField="prp_fecha_registro" HeaderText="Fecha Registro" DataFormatString="{0:yyyy-MM-dd}" />
                <asp:BoundField DataField="prp_area_escritura" HeaderText="Área Escritura" DataFormatString="{0:N2}" />

                <asp:TemplateField HeaderText="Acciones">
                    <ItemTemplate>
                        <div class="d-flex justify-content-center gap-2">
                            <asp:ImageButton ID="btn_modificar" runat="server" ImageUrl="img/lapiz.png"
                                ToolTip="Editar" Height="28" Width="28"
                                CommandName="Modificar" CommandArgument='<%# Eval("prp_id") %>' />
                            <asp:ImageButton ID="btn_eliminar" runat="server" ImageUrl="img/eli1.png"
                                ToolTip="Eliminar" Height="28" Width="28"
                                CommandName="Eliminar" CommandArgument='<%# Eval("prp_id") %>'
                                CssClass="btn-eliminar" />
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>

        </asp:GridView>
    </div>
</div>


<script>
    document.addEventListener("DOMContentLoaded", function () {
        document.querySelectorAll(".btn-eliminar").forEach(function (btn) {
            btn.addEventListener("click", function (e) {
                e.preventDefault(); // Evita que se envíe el postback inmediatamente

                Swal.fire({
                    title: '¿Está seguro?',
                    text: "Esta acción eliminará el registro.",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#d33',
                    cancelButtonColor: '#3085d6',
                    confirmButtonText: 'Sí, eliminar',
                    cancelButtonText: 'Cancelar'
                }).then((result) => {
                    if (result.isConfirmed) {
                        // Dispara el clic real para que ASP.NET lo maneje correctamente
                        __doPostBack(btn.name, '');
                    }
                });
            });
        });
    });
</script>






</asp:Content>
