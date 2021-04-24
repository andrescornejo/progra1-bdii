<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SubastasActivas.aspx.cs" Inherits="SubastasOracle.Pages.Cliente.SubastasCliente" %>

<%@ Register Src="~/Pages/Cliente/ClienteTemplate.ascx" TagPrefix="uc1" TagName="ClienteTemplate" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Subastas Activas</title>
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
                    <div class="col-cs-2">
                        <asp:Label ID="lblCat" CssClass="lead pb-2" runat="server" Text="Categorias"></asp:Label>
                        <br />
                        <asp:DropDownList ID="dropDownCat" CssClass="btn btn-secondary dropdown-toggle" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownCat_SelectedIndexChanged"></asp:DropDownList>
                    </div>
                    <div class="col-cs-2">
                        <asp:Label ID="lblSubcat" CssClass="lead pb-2" runat="server" Text="Subcategorias"></asp:Label>
                        <br />
                        <asp:DropDownList ID="dropDownSubcat" CssClass="btn btn-secondary dropdown-toggle" runat="server"></asp:DropDownList>
                    </div>
                    <asp:Button ID="btnConsultar" CssClass="btn btn-primary btn-lg my-2" OnClick="btnConsultarClick" Text="Consultar" runat="server" />
                </div>
                <br/>

                <hr class="my-4"/>
                <asp:GridView ID="gridSubs" runat="server" CssClass="table table-hover table-dark" AutoGenerateColumns="false">
                    <Columns>
                        <asp:TemplateField>  
                          <ItemTemplate>  
                            <asp:Button ID="btnGrid" runat ="server" CommandArgument ='<%#Eval("nomb")%>'   
                                Text = "Ver Pujas" CommandName ="Select" CssClass="btn btn-info btn-lg"
                                OnClick="btnVerPujasClick"></asp:Button>  
                          </ItemTemplate>  
                        </asp:TemplateField>
                        <asp:BoundField DataField="nomb" HeaderText="Nombre" />
                        <asp:BoundField DataField="item" HeaderText="Artículo subastado" />
                        <asp:BoundField DataField="desc" HeaderText="Descripción" />
                        <asp:BoundField DataField="vend" HeaderText="Usuario vendedor" />
                        <asp:BoundField DataField="finit" HeaderText="Fecha inicio" />
                        <asp:BoundField DataField="ffin" HeaderText="Fecha fin" />
                        <asp:BoundField DataField="vact" HeaderText="Valor actual" />
                        <asp:BoundField DataField="vinit" HeaderText="Valor inicial" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>
