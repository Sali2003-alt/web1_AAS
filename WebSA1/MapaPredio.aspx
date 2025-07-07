<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MapaPredio.aspx.cs" Inherits="WebSA1.MapaPredio" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<!-- Leaflet CSS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />

    <style>
        #map {
            height: 600px;
            width: 100%;
        }
    </style>

    <asp:Literal ID="litGeoJson" runat="server" EnableViewState="false" />

    <div id="map"></div>

    <button onclick="window.history.back();" style="padding: 10px 20px; background-color: #6c757d; color: white; border: none; border-radius: 5px;">
    ← Regresar
    </button>


    <!-- Leaflet JS -->
    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>

    <script>
        window.onload = function () {
            if (geoJsonData) {
                var map = L.map('map').setView([0, 0], 2);

                L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                    attribution: '&copy; OpenStreetMap contributors'
                }).addTo(map);

                var geojsonLayer = L.geoJSON(geoJsonData).addTo(map);
                map.fitBounds(geojsonLayer.getBounds());
            } else {
                alert("No hay datos de geometría para mostrar.");
            }
        };
    </script>



</asp:Content>
