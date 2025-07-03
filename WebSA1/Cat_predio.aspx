<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cat_predio.aspx.cs" Inherits="WebSA1.Cat_predio" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Referencias necesarias para Leaflet y dibujo -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet.draw/1.0.4/leaflet.draw.css" />
    <script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet.draw/1.0.4/leaflet.draw.js"></script>
    
    <style>
        #map { 
            height: 400px; 
            margin-bottom: 20px; 
            z-index: 1;
        }
        .map-container { 
            margin-bottom: 30px; 
            border: 1px solid #ddd; 
            border-radius: 4px; 
        }
        .leaflet-draw-toolbar .leaflet-draw-draw-polygon {
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="%23333"><path d="M17 15.7V13h2v4.5c0 .8-.7 1.5-1.5 1.5H13v-2h2.7l-3.2-3.2-2.8 2.8L5 9.3V13H3V6.5C3 5.7 3.7 5 4.5 5H11v2H8.3l5.2 5.2 2.8-2.8L17 15.7z"/></svg>') !important;
        }
    </style>
    <div id="main">
        <header class="mb-3">
            <a href="#" class="burger-btn d-block d-xl-none">
                <i class="bi bi-justify fs-3"></i>
            </a>
        </header>

        <div class="page-heading">
        </div>
        <div class="page-content">
            <section class="row">
                <div class="col-12 col-lg-9">
                    <div class="row">
                    </div>
                </div>
            </section>
        </div>

        <!-- Sección del Mapa - AÑADIR ESTO ANTES DEL PANEL -->
            <div class="card mb-4 map-container">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">Ubicación Geográfica del Predio</h5>
                </div>
                <div class="card-body">
                    <div id="map"></div>
                    <div class="mt-3">
                        <label>Geometría (WKT):</label>
                        <asp:TextBox ID="txtGeometriaWKT" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" />
                        <small class="form-text text-muted">Geometría en formato WKT. Puede editarla directamente o dibujar en el mapa.</small>
                    </div>
                </div>
            </div>


        <div class="container py-5">
            <h2 class="text-center text-primary mb-4">Registrar Predio</h2>

            <asp:Panel ID="pnlPredio" runat="server" CssClass="card p-4 shadow-sm" ScrollBars="Auto" Style="max-height: 600px; overflow-y: auto;">

                <asp:HiddenField ID="hfPreId" runat="server" />


                <h5>Identificación</h5>
                <div class="form-group mb-3">
                    <label>Código Catastral:</label>
                    <asp:TextBox ID="txtCodigoCatastral" runat="server" CssClass="form-control" MaxLength="32" />
                </div>

                <div class="form-group mb-3">
                    <label>Código Anterior:</label>
                    <asp:TextBox ID="txtCodigoAnterior" runat="server" CssClass="form-control" MaxLength="512" />
                </div>

                <div class="form-group mb-3">
                    <label>Número:</label>
                    <asp:TextBox ID="txtNumero" runat="server" CssClass="form-control" MaxLength="32" />
                </div>

                <div class="form-group mb-3">
                    <label>Nombre Predio:</label>
                    <asp:TextBox ID="txtNombrePredio" runat="server" CssClass="form-control" MaxLength="128" />
                </div>

                <h5>Dimensiones y Áreas</h5>

                <div class="form-group mb-3">
                    <label>Área Total Terreno:</label>
                    <asp:TextBox ID="txtAreaTotalTer" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group mb-3">
                    <label>Área Total Construcción:</label>
                    <asp:TextBox ID="txtAreaTotalConst" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group mb-3">
                    <label>Fondo Relativo:</label>
                    <asp:TextBox ID="txtFondoRelativo" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group mb-3">
                    <label>Frente Fondo:</label>
                    <asp:TextBox ID="txtFrenteFondo" runat="server" CssClass="form-control" />
                </div>


                <h5>Otros Detalles</h5>
                <div class="form-group mb-3">
                    <label>Observaciones:</label>
                    <asp:TextBox ID="txtObservaciones" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" MaxLength="1024" />
                </div>

                <div class="form-group mb-3">
                    <label>Dimensión Tomado Planos:</label>
                    <asp:TextBox ID="txtDimTomadoPlanos" runat="server" CssClass="form-control" MaxLength="4" />
                </div>

                <div class="form-group mb-3">
                    <label>Otra Fuente Información:</label>
                    <asp:TextBox ID="txtOtraFuenteInfo" runat="server" CssClass="form-control" MaxLength="4" />
                </div>

                <div class="form-group mb-3">
                    <label>Número Nuevo Bloque:</label>
                    <asp:TextBox ID="txtNumNuevoBloque" runat="server" CssClass="form-control" MaxLength="4" />
                </div>

                <div class="form-group mb-3">
                    <label>Número Ampli Bloque:</label>
                    <asp:TextBox ID="txtNumAmpliBloque" runat="server" CssClass="form-control" />
                </div>

                <div class="form-group mb-3">
                    <label>Tipo:</label>
                    <asp:TextBox ID="txtTipo" runat="server" CssClass="form-control" />
                </div>

                <div class="form-group mb-3">
                    <label>Propiedad Horizontal:</label>
                    <asp:TextBox ID="txtPropiedadHorizontal" runat="server" CssClass="form-control" MaxLength="4" />
                </div>

                <div class="form-group mb-3">
                    <label>Estado:</label>
                    <asp:TextBox ID="txtEstado" runat="server" CssClass="form-control" />
                </div>

                <div class="form-group mb-3">
                    <label>Dominio:</label>
                    <asp:TextBox ID="txtDominio" runat="server" CssClass="form-control" />
                </div>




                <div class="form-group mb-3">
                    <label>Fecha Ingreso:</label>
                    <asp:TextBox ID="txtFechaIngreso" runat="server" CssClass="form-control" Placeholder="yyyy-MM-dd" />
                </div>


                <div class="form-group mb-3">
                    <label>Fecha Modificación:</label>
                    <asp:TextBox ID="txtFechaModificacion" runat="server" CssClass="form-control" Placeholder="yyyy-MM-dd" />
                </div>

                 <div class="form-group mb-3">
                    <label>Num Habitantes:</label>
                    <asp:TextBox ID="txtNumHabitantes" runat="server" CssClass="form-control" MaxLength="128" />
                </div>
                 <div class="form-group mb-3">
                    <label>Propietario Anterior:</label>
                    <asp:TextBox ID="txtPropietarioAnterior" runat="server" CssClass="form-control" MaxLength="128" />
                </div>
                  <div class="form-group mb-3">
                    <label>Clasificacion Vivienda:</label>
                    <asp:TextBox ID="txtClasificacionVivienda" runat="server" CssClass="form-control" MaxLength="128" />
                </div>

                <h5>Más Información</h5>

                    <div class="form-group mb-3">
                        <label>Carta Topográfica:</label>
                        <asp:TextBox ID="txtCartaTopografica" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group mb-3">
                        <label>Foto Aérea:</label>
                        <asp:TextBox ID="txtFotoAerea" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group mb-3">
                        <label>Manzana ID:</label>
                        <asp:TextBox ID="txtManId" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group mb-3">
                        <label>Número de Familias:</label>
                        <asp:TextBox ID="txtNumFamilias" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group mb-3">
                        <label>Porcentaje Dominio:</label>
                        <asp:TextBox ID="txtPorcentajeDominio" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group mb-3">
                        <label>Detalle Dominio:</label>
                        <asp:TextBox ID="txtDetalleDominio" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group mb-3">
                        <label>Tipo Mixto:</label>
                        <asp:TextBox ID="txtTipoMixto" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group mb-3">
                        <label>Valor Tipo Mixto:</label>
                        <asp:TextBox ID="txtValorTipoMixto" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group mb-3">
                        <label>Linderos Definidos:</label>
                        <asp:TextBox ID="txtLinderosDefinidos" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group mb-3">
                        <label>Área Terreno Anterior:</label>
                        <asp:TextBox ID="txtAreaTerrenoAnterior" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group mb-3">
                        <label>Localización Otros:</label>
                        <asp:TextBox ID="txtLocalizacionOtros" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group mb-3">
                        <label>Bien Mostrenco:</label>
                        <asp:TextBox ID="txtBienMostrenco" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group mb-3">
                        <label>En Conflicto:</label>
                        <asp:TextBox ID="txtEnConflicto" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group mb-3">
                        <label>Área Terreno Gráfico:</label>
                        <asp:TextBox ID="txtAreaTerGrafico" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group mb-3">
                        <label>Propietario Desconocido:</label>
                        <asp:TextBox ID="txtPropietarioDesconocido" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group mb-3">
                        <label>Área Terreno Alfanumérico:</label>
                        <asp:TextBox ID="txtAreaTerAlfa" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group mb-3">
                        <label>Dominio Detalle:</label>
                        <asp:TextBox ID="txtDominioDetalle" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group mb-3">
                        <label>Dirección Principal:</label>
                        <asp:TextBox ID="txtDireccionPrincipal" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group mb-3">
                        <label>Área Construcción Alfanumérico:</label>
                        <asp:TextBox ID="txtAreaConstAlfa" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group mb-3">
                        <label>Tipo de Vivienda:</label>
                        <asp:TextBox ID="txtTipoVivienda" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group mb-3">
                        <label>Número de Celulares:</label>
                        <asp:TextBox ID="txtNumCelulares" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group mb-3">
                        <label>Modalidad PH:</label>
                        <asp:TextBox ID="txtModalidadPH" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group mb-3">
                        <label>Alicuota Total:</label>
                        <asp:TextBox ID="txtAlicuotaTotal" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group mb-3">
                        <label>Tipo PH:</label>
                        <asp:TextBox ID="txtTipoPH" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group mb-3">
                        <label>Observación PH:</label>
                        <asp:TextBox ID="txtObservacionPH" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group mb-3">
                        <label>Hipoteca GAD:</label>
                        <asp:TextBox ID="txtHipotecaGAD" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group mb-3">
                        <label>Régimen PH:</label>
                        <asp:TextBox ID="txtRegimenPH" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group mb-3">
                        <label>Prorrateo Título:</label>
                        <asp:TextBox ID="txtProrrateoTitulo" runat="server" CssClass="form-control" />
                    </div>




                <div class="d-flex justify-content-between">
                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-primary" OnClick="btnGuardar_Click" />
                    <asp:Button ID="btnActualizar" runat="server" Text="Actualizar" CssClass="btn btn-warning" Visible="false" OnClick="btnActualizar_Click" />
                    <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary" Visible="false" OnClick="btnCancelar_Click" />
                </div>

            </asp:Panel>

            <br />
            <br />
            <h2>Listado de Predios</h2>

            <asp:GridView ID="lstPredios" runat="server"
                CssClass="table table-bordered table-striped table-hover text-center align-middle shadow-sm"
                AutoGenerateColumns="False"
                PageSize="10" 
                AllowPaging="true"
                DataKeyNames="pre_id"
                OnRowCommand="lstPredios_RowCommand"
                OnPageIndexChanging="lstPredios_PageIndexChanging"
                PagerStyle-CssClass="pagination justify-content-center my-3"
                HeaderStyle-CssClass="table-primary">

                <Columns>
                    <asp:BoundField DataField="pre_id" HeaderText="ID" />
                    <asp:BoundField DataField="pre_codigo_catastral" HeaderText="Código Catastral" />
                    <asp:BoundField DataField="pre_nombre_predio" HeaderText="Nombre del Predio" />
                    <asp:BoundField DataField="pre_area_total_ter" HeaderText="Área Terreno" DataFormatString="{0:N2}" />
                    <asp:BoundField DataField="pre_area_total_const" HeaderText="Área Construcción" DataFormatString="{0:N2}" />
                    <asp:BoundField DataField="pre_estado" HeaderText="Estado" />
                    <asp:BoundField DataField="pre_num_habitantes" HeaderText="# Habitantes" />
                    <asp:BoundField DataField="pre_num_familias" HeaderText="# Familias" />
                    <asp:BoundField DataField="pre_tipo_vivienda" HeaderText="Tipo Vivienda" />
                    <asp:BoundField DataField="pre_direccion_principal" HeaderText="Dirección Principal" />
                    <asp:BoundField DataField="pre_fecha_ingreso" HeaderText="Fecha Ingreso" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField DataField="pre_fecha_modificacion" HeaderText="Fecha Modificación" DataFormatString="{0:yyyy-MM-dd}" />

                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>
                            <div class="d-flex justify-content-center gap-2">
                                
                                <asp:ImageButton ID="btn_modificar" runat="server" ImageUrl="img/lapiz.png"
                                    ToolTip="Editar" Height="28" Width="28"
                                    CommandName="Modificar" CommandArgument='<%# Eval("pre_id") %>' />
                                <asp:ImageButton ID="btn_eliminar" runat="server" ImageUrl="img/eli1.png"
                                    ToolTip="Eliminar" Height="28" Width="28"
                                    CommandName="Eliminar" CommandArgument='<%# Eval("pre_id") %>'
                                    OnClientClick="return confirmarEliminacion();" />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>

            </asp:GridView>

        </div>

    </div>
     <script>
         // Inicializar el mapa con coordenadas más genéricas
         var map = L.map('map').setView([-1.8312, -78.1834], 6); // Coordenadas centradas en Ecuador

         // Capa base de OpenStreetMap
         L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
             attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>'
         }).addTo(map);

         // Grupo para las formas dibujadas
         var drawnItems = new L.FeatureGroup();
         map.addLayer(drawnItems);

         // Configuración de controles de dibujo
         var drawControl = new L.Control.Draw({
             position: 'topright',
             draw: {
                 polygon: {
                     allowIntersection: false,
                     showArea: true,
                     metric: true,
                     shapeOptions: {
                         color: '#3388ff',
                         fillColor: '#3388ff',
                         fillOpacity: 0.2
                     }
                 },
                 rectangle: {
                     shapeOptions: {
                         color: '#3388ff',
                         fillColor: '#3388ff',
                         fillOpacity: 0.2
                     }
                 },
                 circle: false,
                 polyline: false,
                 marker: false
             },
             edit: {
                 featureGroup: drawnItems,
                 remove: true
             }
         });
         map.addControl(drawControl);

         // Evento cuando se crea una forma
         map.on(L.Draw.Event.CREATED, function (e) {
             var type = e.layerType,
                 layer = e.layer;

             drawnItems.addLayer(layer);

             // Convertir a GeoJSON y luego a WKT
             var geoJSON = layer.toGeoJSON();
             var wkt = geoJSONToWKT(geoJSON.geometry);
             document.getElementById('<%= txtGeometriaWKT.ClientID %>').value = wkt;

            // Centrar el mapa en la forma
            map.fitBounds(layer.getBounds());
        });

         // Evento cuando se edita una forma
         map.on('draw:edited', function (e) {
             var layers = e.layers;
             layers.eachLayer(function (layer) {
                 var geoJSON = layer.toGeoJSON();
                 var wkt = geoJSONToWKT(geoJSON.geometry);
                 document.getElementById('<%= txtGeometriaWKT.ClientID %>').value = wkt;
            });
        });

         // Evento cuando se elimina una forma
         map.on('draw:deleted', function (e) {
             document.getElementById('<%= txtGeometriaWKT.ClientID %>').value = '';
        });

        // Función para convertir GeoJSON a WKT (simplificada)
        function geoJSONToWKT(geoJSON) {
            if (geoJSON.type === 'Polygon') {
                var coords = geoJSON.coordinates[0].map(c => c.reverse().join(' ')).join(', ');
                return 'POLYGON((' + coords + '))';
            } else if (geoJSON.type === 'MultiPolygon') {
                var polygons = geoJSON.coordinates.map(poly => 
                    '(' + poly[0].map(c => c.reverse().join(' ')).join(', ') + ')'
                ).join(', ');
                return 'MULTIPOLYGON(' + polygons + ')';
            }
            return '';
        }

        // Función para cargar geometría existente
        function cargarGeometriaExistente() {
            var wkt = document.getElementById('<%= txtGeometriaWKT.ClientID %>').value;
            if (wkt && wkt.trim() !== '') {
                try {
                    // Convertir WKT a GeoJSON (simplificado)
                    var geoJSON = wktToGeoJSON(wkt);
                    if (geoJSON) {
                        var layer = L.geoJSON(geoJSON, {
                            style: {
                                color: '#3388ff',
                                fillColor: '#3388ff',
                                fillOpacity: 0.2,
                                weight: 2
                            }
                        }).addTo(drawnItems);
                        map.fitBounds(layer.getBounds());
                    }
                } catch (e) {
                    console.error("Error al cargar geometría:", e);
                }
            }
        }

        // Función simplificada para convertir WKT a GeoJSON
        function wktToGeoJSON(wkt) {
            if (wkt.startsWith('POLYGON')) {
                var coords = wkt.replace(/POLYGON\(\(|\)\)/g, '').split(', ');
                var points = coords.map(c => {
                    var xy = c.split(' ');
                    return [parseFloat(xy[1]), parseFloat(xy[0])]; // Lat, Lng
                });
                return {
                    type: 'Polygon',
                    coordinates: [points]
                };
            }
            return null;
        }

        // Cargar geometría al iniciar
        document.addEventListener('DOMContentLoaded', function() {
            cargarGeometriaExistente();
            
            // También puedes escuchar cambios en el textbox
            document.getElementById('<%= txtGeometriaWKT.ClientID %>').addEventListener('change', function () {
                drawnItems.clearLayers();
                cargarGeometriaExistente();
            });
        });
     </script>
</asp:Content>
