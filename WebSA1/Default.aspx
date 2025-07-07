<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebSA1._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<!-- Imagen ajustada considerando el sidebar con texto encima -->
<div style="margin-left: 190px; position: relative;">
    <img src="img/paisa.jpg" alt="Imagen ajustada"
         style="
            width: calc(100vw - 315px);
            height: 650px;
            object-fit: cover;
            display: block;
        " />

    <!-- Texto encima de la imagen -->
    <div style="
        position: absolute;
        top: 80%; /* Centrado vertical */
        left: 40%; /* Centrado horizontal */
        transform: translate(-50%, -50%);
        color: white;
        font-size: 48px;
        font-weight: bold;
        text-shadow: 2px 2px 6px rgba(0,0,0,0.8);
        text-align: center;
        width: 100%;
    ">
        A Mejía, "el Valle de los 9 Volcanes"
    </div>
</div>


</asp:Content>
