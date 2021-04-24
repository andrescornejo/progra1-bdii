<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ArticulosCliente.aspx.cs" Inherits="SubastasOracle.Pages.Cliente.ArticulosCliente" %>

<%@ Register Src="~/Pages/Cliente/ClienteTemplate.ascx" TagPrefix="uc1" TagName="ClienteTemplate" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <uc1:ClienteTemplate runat="server" ID="ClienteTemplate" />
        <div class="mb-3 mx-5">
            <asp:Button ID="btnBack" CssClass="btn btn-outline-secondary btn-lg" OnClick="btnBack_Click" Text="Volver" runat="server" />
        </div>
        <div class="container">
            <div class="jumbotron">
                <asp:Label ID="lblDisplay" CssClass="display-4" runat="server" Text="Placeholder text"></asp:Label>
                <div class="py-3">
                    <asp:Label ID="lblLead" CssClass="lead" runat="server" >Placeholder text</asp:Label>
                    <br/>
                    <asp:Button ID="btn_AddArtic" CssClass="btn btn-primary btn-lg my-2" OnClick="btnAddArtic_Click" Text="Agregar" runat="server" />
                </div>
                <br/>

                <hr class="my-4"/>
                <asp:GridView ID="gridArtic" runat="server" CssClass="table table-hover table-dark" AutoGenerateColumns="false">
                    <Columns>
                        <asp:BoundField DataField="nomb" HeaderText="Nombre" />
                        <asp:BoundField DataField="desc" HeaderText="Descripción" />
                        <asp:BoundField DataField="cat" HeaderText="Categoria" />
                        <asp:BoundField DataField="subcat" HeaderText="Subcategoria" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>
