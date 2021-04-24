<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomeCliente.aspx.cs" Inherits="SubastasOracle.Pages.Cliente.HomeCliente" %>

<%@ Register Src="~/Pages/Cliente/ClienteTemplate.ascx" TagPrefix="uc1" TagName="ClienteTemplate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sistema de subastas</title>
</head>
<body>
    <form id="form1" runat="server">
        <uc1:ClienteTemplate runat="server" id="ClienteTemplate" />
        <div class="container">
            <div class="card-deck my-2">
                <div class="card text-center" style="width: 18rem;">
                    <div class="card-body">
                        <h3 class="card-title">Ver las subastas activas</h3>
                        <p class="card-text">Ver cuales son las subastas activas por categorías, y subcategorías.</p>
                        <asp:Button ID="btnVerSubastasActivas" CssClass="btn btn-primary btn-lg my-2" OnClick="btnVerSubastasActivasClick" Text="Ver" runat="server" />
                    </div>
                </div>

                <div class="card text-center" style="width: 18rem;">
                    <div class="card-body">
                        <h3 class="card-title">Ver y agregar artículos.</h3>
                        <p class="card-text">Página para ver y agregar sus artículos.</p>
                        <asp:Button ID="btnVerItems" CssClass="btn btn-primary btn-lg my-2" OnClick="btnVerItemsClick" Text="Ver" runat="server" />
                    </div>
                </div>


                <!-- <div class="card text-center" style="width: 18rem;">
                    <div class="card-body">
                        <h3 class="card-title">Propietarios de una propiedad</h3>
                        <p class="card-text">Ver los distintos propietarios de una propiedad.</p>
                        <a href="verPropietarioDePropiedad.aspx" class="btn btn-primary">Ver</a>
                    </div>
                </div> -->
            </div>


            <!-- <div class="card-deck my-5">

                <div class="card text-center" style="width: 18rem;">
                    <div class="card-body">
                        <h3 class="card-title">Propiedades de un usuario</h3>
                        <p class="card-text">Ver las propiedades que le pertenecen a un usuario.</p>
                        <a href="verPropiedadesDeUsuario.aspx" class="btn btn-primary">Ver</a>
                    </div>
                </div>

                <div class="card text-center" style="width: 18rem;">
                    <div class="card-body">
                        <h3 class="card-title">Usuario de una propiedad</h3>
                        <p class="card-text">Ver el usuario al que le pertenece una propiedad.</p>
                        <a href="verUsuarioDePropiedad.aspx" class="btn btn-primary">Ver</a>
                    </div>
                </div>

                <div class="card text-center" style="width: 18rem;">
                    <div class="card-body">
                        <h3 class="card-title">Cambios realizados a entidades</h3>
                        <p class="card-text">Ver los cambios que se le han realizado a las entidades en el pasado.</p>
                        <a href="consultaCambioEntidad.aspx" class="btn btn-primary">Ver</a>
                    </div>
                </div>

            </div>
            
            <div class="card-deck my-5">

                <div class="card text-center" style="width: 18rem;">
                    <div class="card-body">
                        <h3 class="card-title">Arreglos de pago</h3>
                        <p class="card-text">Generar un arreglo de pago para un usuario designado.</p>
                        <a href="crearArregloDePago.aspx" class="btn btn-primary">Ver</a>
                    </div>
                </div>

            </div> -->
        </div>
    </form>
</body>
</html>
