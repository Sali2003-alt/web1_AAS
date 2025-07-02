<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cat_predio.aspx.cs" Inherits="WebSA1.Cat_predio" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">



<div class="container py-5">
    <h2 class="text-center text-primary mb-4">Registrar Predio</h2>

    <asp:Panel ID="pnlPredio" runat="server" CssClass="card p-4 shadow-sm" ScrollBars="Auto" Style="max-height:600px; overflow-y:auto;">

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

        
        <div class="d-flex justify-content-between">
            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-primary" OnClick="btnGuardar_Click" />
            <asp:Button ID="btnActualizar" runat="server" Text="Actualizar" CssClass="btn btn-warning" Visible="false" />
            <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary" Visible="false"/>
        </div>

    </asp:Panel>

    <br /><br />
    <h2>Listado de Predios</h2>

    <asp:GridView ID="lstPredios" runat="server" AutoGenerateColumns="False"  CssClass="table table-hover"  PageSize="10" AllowPaging="true">
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
                   <div style="display: inline-flex; gap: 10px;">
                       <asp:ImageButton ID="btn_modificar" runat="server" ImageUrl="img/lapiz.png" Text="Modificar" Height="30" Width="30" CommandName="Modificar" CommandArgument='<%# Eval("pre_id") %>' />
                         &nbsp;
                        <asp:ImageButton ID="btn_eliminar" runat="server" ImageUrl="img/eli1.png" Text="Eliminar" Height="30" Width="30" CommandName="Eliminar" CommandArgument='<%# Eval("pre_id") %>' OnClientClick="return confirmarEliminacion();" />
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

</div>



</asp:Content>
