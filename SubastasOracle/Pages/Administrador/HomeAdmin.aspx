<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomeAdmin.aspx.cs" Inherits="SubastasOracle.Pages.Administrador.HomeAdmin" %>

<%@ Register Src="~/Pages/Administrador/AdministradorTemplate.ascx" TagPrefix="uc1" TagName="AdministradorTemplate" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Panel de administrador</title>
</head>
<body>
    <form id="form1" runat="server">
        <uc1:AdministradorTemplate runat="server" id="AdministradorTemplate" />
        <div class="container">
            <div class="card-deck my-2">
                <div class="card text-center" style="width: 18rem;">
                    <div class="card-body">
                        <h3 class="card-title">Agregar usuarios al sistema</h3>
                        <p class="card-text">Agregar usuarios al sistema y definir sus privilegios.</p>
                        <asp:Button ID="btnAgregarUsuario" CssClass="btn btn-primary btn-lg my-2" OnClick="btnAgregarUsuarioClick" Text="Ver" runat="server" />
                    </div>
                </div>

                <div class="card text-center" style="width: 18rem;">
                    <div class="card-body">
                        <h3 class="card-title">Cambiar los valores de pujas.</h3>
                        <p class="card-text">Cambiar los valores para relizar pujas en el sistema.</p>
                        <asp:Button ID="btnCambiarValores" CssClass="btn btn-primary btn-lg my-2" OnClick="btnCambiarValoresClick" Text="Ver" runat="server" />
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
