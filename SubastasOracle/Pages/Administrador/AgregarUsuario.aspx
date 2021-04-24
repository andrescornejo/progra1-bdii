<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AgregarUsuario.aspx.cs" Inherits="SubastasOracle.Pages.Administrador.AgregarUsuario" %>

<%@ Register Src="~/Pages/Administrador/AdministradorTemplate.ascx" TagPrefix="uc1" TagName="AdministradorTemplate" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <uc1:AdministradorTemplate runat="server" ID="AdministradorTemplate" />
        <div class ="container">
            <%-- Create section --%>
            <div id="jtCreate" class="jumbotron" runat="server">
                <h1 class="display-4">Agregar un usuario al sistema.</h1>
                <p class="lead">Ingrese los datos del nuevo usuario.</p>
                <hr class="my-4"/>
                <div class="form-group row px-3 pb-4">
                    <div class="col-xs-2">
                        <p class="lead">Nombre</p>
                        <asp:TextBox ID="tb_Nombre" runat="server" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                    </div>
                    <div class="col-xs-2 px-3">
                        <p class="lead">Apellido</p>
                        <asp:TextBox ID="tb_Apellido" runat="server" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                    </div>
                    <div class="col-xs-2">
                        <p class="lead">Email</p>
                        <asp:TextBox ID="tb_Email" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group row px-3 pb-4">
                    <div class="col-xs-2">
                        <p class="lead">Nombre de Usuario</p>
                        <asp:TextBox ID="tb_User" runat="server" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                    </div>
                    <div class="col-xs-2 px-3">
                        <p class="lead">Contraseña</p>
                        <asp:TextBox ID="tb_Passwd" runat="server" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                    </div>
                    <div class="col-xs-2">
                        <p class="lead">Identificacion</p>
                        <asp:TextBox ID="tb_identif" runat="server" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group row px-3 pb-4">
                    <div class="col-xs-2">
                        <p class="lead">Tipo de ID</p>
                        <asp:TextBox ID="tb_tipoID" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                        <asp:DropDownList ID="dropDownTID" CssClass="btn btn-secondary dropdown-toggle" runat="server"></asp:DropDownList>
                    </div>
                    <div class="col-xs-2">
                        <asp:CheckBox ID="checkboxIsAdmin" runat="server" />
                    </div>
                </div>
                <asp:Button ID="btnCreateProp" runat="server" Text="Crear propiedad" CssClass="btn btn-primary btn-lg" OnClick="btnCreateProp_Click"/>
            </div>
        </div>
    </form>
</body>
</html>
