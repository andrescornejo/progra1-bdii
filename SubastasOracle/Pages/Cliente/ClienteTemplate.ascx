<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ClienteTemplate.ascx.cs" Inherits="SubastasOracle.Pages.Cliente.ClienteTemplate" %>

<link href="../../Content/bootstrap.css" rel="stylesheet" />
<link href="../../Content/dashboard.css" rel="stylesheet" />



<%-- Enable js scripts from codebehind, and partial reloading to prevent gridview postback --%>
<asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true"></asp:ScriptManager>

<div class="pos-f-t">
    <div class="collapse" id="navbarToggleExternalContent">
        <div class="bg-dark p-4">
            <asp:Label ID="lblUsername" CssClass="h3 text-white unselectable" runat="server" Text=""></asp:Label>
            <hr class="my-2">

            <ul class="nav navbar-nav">
                <li class="my-1"><a href="Cliente/SubastasActivas.aspx" class="btn btn-dark btn-lg">Ver subastas activas</a></li>
                <li class="my-1"><a href="Cliente/ArticulosCliente.aspx" class="btn btn-dark btn-lg">Ver y registrar artículos</a></li>
            </ul>
        </div> 
    </div>
  <nav class="navbar navbar-dark bg-dark">
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarToggleExternalContent" aria-controls="navbarToggleExternalContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <a class="navbar-brand unselectable" href="HomeCliente.aspx">Sistema de Subastas</a>
    <ul class="navbar-nav px-3">
        <li class="nav-item text-nowrap">
            <asp:Button ID="logoutBtn" runat="server" Text="Cerrar sesión" OnClick="logoutBtn_Click" CssClass="btn btn-outline-danger my-2 my-sm-0" type="submit"/>
        </li>
    </ul>
  </nav>
</div>

<div class="py-3"></div>

<script src="../../Scripts/jquery-3.6.0.min.js"></script>
<script src="../../Scripts/umd/popper.min.js"></script>
<script src="../../Scripts/bootstrap.min.js"></script>
