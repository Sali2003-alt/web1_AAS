<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Predio.aspx.cs" Inherits="WebSA1.Predio" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <div id="main">
        <header class="mb-3">
            <a href="#" class="burger-btn d-block d-xl-none">
                <i class="bi bi-justify fs-3"></i>
            </a>
        </header>

        <div class="page-heading">
            <h1>Gestión de Predios Catastrales</h1>
        </div>
        
        <div class="page-content">
            <section class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title">Registro de Predios</h4>
                        </div>
                        <div class="card-body">
                            <asp:Panel ID="pnlRegistrarPredio" runat="server" class="form-horizontal">
                                <!-- Sección 1: Información Básica -->
                                <div class="row mb-4">
                                    <h5 class="text-primary">Información Básica</h5>
                                    <div class="col-md-6">
                                        <div class="form-group mb-3">
                                            <label for="txtCodigoCatastral" class="form-label">Código Catastral*:</label>
                                            <asp:TextBox ID="txtCodigoCatastral" runat="server" CssClass="form-control" required="true"></asp:TextBox>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="txtCodigoAnterior" class="form-label">Código Anterior:</label>
                                            <asp:TextBox ID="txtCodigoAnterior" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="txtNumero" class="form-label">Número Predio:</label>
                                            <asp:TextBox ID="txtNumero" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="txtNombrePredio" class="form-label">Nombre Predio*:</label>
                                            <asp:TextBox ID="txtNombrePredio" runat="server" CssClass="form-control" required="true"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group mb-3">
                                            <label for="ddlTipoPredio" class="form-label">Tipo Predio*:</label>
                                            <asp:DropDownList ID="ddlTipoPredio" runat="server" CssClass="form-select" required="true">
                                                <asp:ListItem Value="">-- Seleccione --</asp:ListItem>
                                                <asp:ListItem Value="1">Urbano</asp:ListItem>
                                                <asp:ListItem Value="2">Rural</asp:ListItem>
                                                <asp:ListItem Value="3">Mixto</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="ddlEstado" class="form-label">Estado*:</label>
                                            <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-select" required="true">
                                                <asp:ListItem Value="1">Activo</asp:ListItem>
                                                <asp:ListItem Value="0">Inactivo</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="ddlDominio" class="form-label">Dominio:</label>
                                            <asp:DropDownList ID="ddlDominio" runat="server" CssClass="form-select">
                                                <asp:ListItem Value="">-- Seleccione --</asp:ListItem>
                                                <asp:ListItem Value="1">Público</asp:ListItem>
                                                <asp:ListItem Value="2">Privado</asp:ListItem>
                                                <asp:ListItem Value="3">Mixto</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="txtFechaRegistro" class="form-label">Fecha Registro:</label>
                                            <asp:TextBox ID="txtFechaRegistro" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>

                                <!-- Sección 2: Dimensiones y Áreas -->
                                <div class="row mb-4">
                                    <h5 class="text-primary">Dimensiones y Áreas</h5>
                                    <div class="col-md-6">
                                        <div class="form-group mb-3">
                                            <label for="txtAreaTotalTerreno" class="form-label">Área Total Terreno (m²)*:</label>
                                            <asp:TextBox ID="txtAreaTotalTerreno" runat="server" CssClass="form-control" TextMode="Number" step="0.01" required="true"></asp:TextBox>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="txtAreaTotalConstruida" class="form-label">Área Total Construida (m²):</label>
                                            <asp:TextBox ID="txtAreaTotalConstruida" runat="server" CssClass="form-control" TextMode="Number" step="0.01"></asp:TextBox>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="txtFondoRelativo" class="form-label">Fondo Relativo:</label>
                                            <asp:TextBox ID="txtFondoRelativo" runat="server" CssClass="form-control" TextMode="Number" step="0.01"></asp:TextBox>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="txtFrenteFondo" class="form-label">Relación Frente/Fondo:</label>
                                            <asp:TextBox ID="txtFrenteFondo" runat="server" CssClass="form-control" TextMode="Number" step="0.01"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group mb-3">
                                            <label for="txtAreaGrafico" class="form-label">Área Terreno (Gráfico):</label>
                                            <asp:TextBox ID="txtAreaGrafico" runat="server" CssClass="form-control" TextMode="Number" step="0.01"></asp:TextBox>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="txtAreaAlfanumerico" class="form-label">Área Terreno (Alfanumérico):</label>
                                            <asp:TextBox ID="txtAreaAlfanumerico" runat="server" CssClass="form-control" TextMode="Number" step="0.01"></asp:TextBox>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="txtAreaConstAlfanumerico" class="form-label">Área Construida (Alfanumérico):</label>
                                            <asp:TextBox ID="txtAreaConstAlfanumerico" runat="server" CssClass="form-control" TextMode="Number" step="0.01"></asp:TextBox>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="txtAreaTerrenoAnterior" class="form-label">Área Terreno Anterior:</label>
                                            <asp:TextBox ID="txtAreaTerrenoAnterior" runat="server" CssClass="form-control" TextMode="Number" step="0.01"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>

                                <!-- Sección 3: Propiedad Horizontal -->
                                <div class="row mb-4">
                                    <h5 class="text-primary">Propiedad Horizontal</h5>
                                    <div class="col-md-6">
                                        <div class="form-group mb-3">
                                            <label for="txtPropiedadHorizontal" class="form-label">Propiedad Horizontal:</label>
                                            <asp:TextBox ID="txtPropiedadHorizontal" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="ddlModalidadPH" class="form-label">Modalidad PH:</label>
                                            <asp:DropDownList ID="ddlModalidadPH" runat="server" CssClass="form-select">
                                                <asp:ListItem Value="">-- Seleccione --</asp:ListItem>
                                                <asp:ListItem Value="1">Regular</asp:ListItem>
                                                <asp:ListItem Value="2">Especial</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="txtAlicuotaPH" class="form-label">Alicuota PH:</label>
                                            <asp:TextBox ID="txtAlicuotaPH" runat="server" CssClass="form-control" TextMode="Number" step="0.01"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group mb-3">
                                            <label for="ddlTipoPH" class="form-label">Tipo PH:</label>
                                            <asp:DropDownList ID="ddlTipoPH" runat="server" CssClass="form-select">
                                                <asp:ListItem Value="">-- Seleccione --</asp:ListItem>
                                                <asp:ListItem Value="1">Residencial</asp:ListItem>
                                                <asp:ListItem Value="2">Comercial</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="ddlRegimenPH" class="form-label">Régimen PH:</label>
                                            <asp:DropDownList ID="ddlRegimenPH" runat="server" CssClass="form-select">
                                                <asp:ListItem Value="">-- Seleccione --</asp:ListItem>
                                                <asp:ListItem Value="1">Común</asp:ListItem>
                                                <asp:ListItem Value="2">Especial</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="txtObservacionesPH" class="form-label">Observaciones PH:</label>
                                            <asp:TextBox ID="txtObservacionesPH" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>

                                <!-- Sección 4: Ubicación y Características -->
                                <div class="row mb-4">
                                    <h5 class="text-primary">Ubicación y Características</h5>
                                    <div class="col-md-6">
                                        <div class="form-group mb-3">
                                            <label for="ddlManzana" class="form-label">Manzana:</label>
                                            <asp:DropDownList ID="ddlManzana" runat="server" CssClass="form-select" DataSourceID="sqlManzanas" DataTextField="man_nombre" DataValueField="man_id">
                                                <asp:ListItem Value="">-- Seleccione --</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="sqlManzanas" runat="server" ConnectionString="<%$ ConnectionStrings:TuCadenaConexion %>" 
                                                SelectCommand="SELECT man_id, man_nombre FROM catastro.cat_manzana ORDER BY man_nombre"></asp:SqlDataSource>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="txtDireccionPrincipal" class="form-label">Dirección Principal*:</label>
                                            <asp:TextBox ID="txtDireccionPrincipal" runat="server" CssClass="form-control" required="true"></asp:TextBox>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="txtLocalizacionOtros" class="form-label">Localización Otros:</label>
                                            <asp:TextBox ID="txtLocalizacionOtros" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="txtNumBloque" class="form-label">Número Bloque:</label>
                                            <asp:TextBox ID="txtNumBloque" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group mb-3">
                                            <label for="txtNumAmpliacionBloque" class="form-label">Ampliación Bloque:</label>
                                            <asp:TextBox ID="txtNumAmpliacionBloque" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="txtNumHabitantes" class="form-label">N° Habitantes:</label>
                                            <asp:TextBox ID="txtNumHabitantes" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="txtNumFamilias" class="form-label">N° Familias:</label>
                                            <asp:TextBox ID="txtNumFamilias" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="txtNumCelulares" class="form-label">N° Celulares:</label>
                                            <asp:TextBox ID="txtNumCelulares" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>

                                <!-- Sección 5: Información Adicional -->
                                <div class="row mb-4">
                                    <h5 class="text-primary">Información Adicional</h5>
                                    <div class="col-md-6">
                                        <div class="form-group mb-3">
                                            <label for="txtPropietarioAnterior" class="form-label">Propietario Anterior:</label>
                                            <asp:TextBox ID="txtPropietarioAnterior" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="txtCartaTopografica" class="form-label">Carta Topográfica:</label>
                                            <asp:TextBox ID="txtCartaTopografica" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="txtFotoAerea" class="form-label">Foto Aérea:</label>
                                            <asp:TextBox ID="txtFotoAerea" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="txtFuenteInfo" class="form-label">Otra Fuente Información:</label>
                                            <asp:TextBox ID="txtFuenteInfo" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group mb-3">
                                            <label for="txtDetalleDominio" class="form-label">Detalle Dominio:</label>
                                            <asp:TextBox ID="txtDetalleDominio" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="txtPorcentajeDominio" class="form-label">% Dominio:</label>
                                            <asp:TextBox ID="txtPorcentajeDominio" runat="server" CssClass="form-control" TextMode="Number" step="0.01"></asp:TextBox>
                                        </div>
                                        <div class="form-group mb-3">
                                            <label for="txtObservaciones" class="form-label">Observaciones Generales:</label>
                                            <asp:TextBox ID="txtObservaciones" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>

                                <!-- Botones de Acción -->
                                <div class="row">
                                    <div class="col-12 text-end">
                                        <asp:Button ID="btnGuardar" runat="server" Text="Guardar Predio" CssClass="btn btn-primary me-2"/>
                                        <asp:Button ID="btnActualizar" runat="server" Text="Actualizar" CssClass="btn btn-warning me-2" Visible="false" />
                                        <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary" Visible="false" />
                                    </div>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                    
                    <!-- Listado de Predios -->
                    <div class="card mt-4">
                        <div class="card-header">
                            <h4 class="card-title">Listado de Predios Registrados</h4>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <asp:GridView ID="lstPredios" runat="server" AutoGenerateColumns="False" DataKeyNames="pre_id"
                                    CssClass="table table-striped table-bordered datatable-predios" OnRowCommand="gvPredios_RowCommand"
                                    >
                                    <Columns>
                                        <asp:BoundField DataField="pre_codigo_catastral" HeaderText="Código Catastral" HeaderStyle-Width="12%" />
                                        <asp:BoundField DataField="pre_nombre_predio" HeaderText="Nombre Predio" HeaderStyle-Width="18%" />
                                        <asp:BoundField DataField="pre_direccion_principal" HeaderText="Dirección" HeaderStyle-Width="20%" />
                                        <asp:BoundField DataField="pre_area_total_ter" HeaderText="Área Terreno (m²)" DataFormatString="{0:N2}" HeaderStyle-Width="8%" ItemStyle-HorizontalAlign="Right" />
                                        <asp:BoundField DataField="pre_area_total_const" HeaderText="Área Const. (m²)" DataFormatString="{0:N2}" HeaderStyle-Width="8%" ItemStyle-HorizontalAlign="Right" />
                                        <asp:BoundField DataField="pre_num_habitantes" HeaderText="Habitantes" HeaderStyle-Width="6%" ItemStyle-HorizontalAlign="Center" />
                                        <asp:BoundField DataField="Estado" HeaderText="Estado" HeaderStyle-Width="8%" />
                                        
                                        <asp:TemplateField HeaderText="Acciones" HeaderStyle-Width="10%" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnEditar" runat="server" CommandName="Editar" CommandArgument='<%# Eval("pre_id") %>'
                                                    CssClass="btn btn-sm btn-icon btn-primary me-1" ToolTip="Editar">
                                                    <i class="bi bi-pencil"></i>
                                                </asp:LinkButton>
                                                
                                                <asp:LinkButton ID="btnEliminar" runat="server" CommandName="Eliminar" CommandArgument='<%# Eval("pre_id") %>'
                                                    CssClass="btn btn-sm btn-icon btn-danger" ToolTip="Eliminar" 
                                                    OnClientClick="return confirm('¿Está seguro de eliminar este predio?');">
                                                    <i class="bi bi-trash"></i>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <PagerSettings Mode="NumericFirstLast" Position="Bottom" PageButtonCount="5" />
                                    <PagerStyle CssClass="pagination justify-content-center" />
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>

    <script>
        $(document).ready(function () {
            $('.datatable-predios').DataTable({
                "language": {
                    "url": "//cdn.datatables.net/plug-ins/1.10.25/i18n/Spanish.json"
                },
                "responsive": true,
                "dom": '<"top"lf>rt<"bottom"ip><"clear">',
                "columnDefs": [
                    { "orderable": true, "targets": [0, 1, 2, 3, 4, 5, 6] },
                    { "orderable": false, "targets": [7] }
                ],
                "order": [[0, "asc"]]
            });
        });
    </script>





</asp:Content>
