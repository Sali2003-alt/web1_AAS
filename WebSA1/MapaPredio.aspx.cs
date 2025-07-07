using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

namespace WebSA1
{
    public partial class MapaPredio : System.Web.UI.Page
    {
        public string GeoJsonPredio { get; private set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["GeoJsonPredio"] != null)
                {
                    GeoJsonPredio = Session["GeoJsonPredio"].ToString();
                }
                else
                {
                    GeoJsonPredio = "{}"; // JSON vacío para evitar error
                }

                // Escapar comillas simples para evitar romper el JavaScript
                string safeGeoJson = GeoJsonPredio.Replace("'", "\\'");
                litGeoJson.Text = $"<script>var geoJsonData = JSON.parse('{safeGeoJson}');</script>";
            }
        }
    }
}