<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.15.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.15.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.15.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.15.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Scripts/jquery-2.1.1.js"></script>
    <script src="Scripts/Scripts.js"></script>
    <link href="Content/Style.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" ShowHeader="false">
            <PanelCollection>
                <dx:PanelContent>
                    <table style="border-spacing: 0px; width: 100%" class="nullPadding">
                        <tr>
                            <td>
                                <dx:ASPxComboBox ID="ASPxComboBox1"
                                    runat="server"
                                    ValueType="System.String"
                                    DataSourceID="sqlCategories"
                                    TextField="CategoryName"
                                    ValueField="CategoryID" Width="100px"
                                    CssClass="categorySelector"
                                    ClientInstanceName="categoriesCombo"
                                    OnDataBound="ASPxComboBox1_DataBound">
                                    <ButtonStyle CssClass="buttonCategorySelector" Cursor="default">
                                    </ButtonStyle>
                                    <ClientSideEvents SelectedIndexChanged="OnCategoryChanged"  />
                                </dx:ASPxComboBox>
                            </td>
                            <td>
                                <dx:ASPxComboBox ID="ASPxComboBox2"
                                    runat="server"
                                    ValueType="System.String"
                                    IncrementalFilteringMode="StartsWith"
                                    DataSourceID="sqlProducts"
                                    DropDownStyle="DropDown"
                                    TextField="ProductName"
                                    ValueField="ProductID"
                                    ClientInstanceName="productsCombo"
                                    OnCallback="ASPxComboBox2_Callback"
                                    NullText="Search..."
                                    EnableFocusedStyle="false" Width="100%">
                                    <DropDownButton Visible="false"></DropDownButton>
                                    <ButtonStyle CssClass="search"></ButtonStyle>
                                    <Buttons>
                                        <dx:EditButton Image-SpriteProperties-CssClass="size"></dx:EditButton>
                                    </Buttons>
                                    <ClientSideEvents Init="OnInit" SelectedIndexChanged="OnProductChanged" ButtonClick="OnSearchButtonClick" />
                                </dx:ASPxComboBox>
                            </td>
                        </tr>
                    </table>
                    <dx:ASPxCallbackPanel ID="DetailsPanel" runat="server" OnCallback="PanelDetails_Callback" ClientInstanceName="detailsPanel" CssClass="detailsPanel" ClientVisible="false">
                        <ClientSideEvents EndCallback="OnEndCallback" />
                    </dx:ASPxCallbackPanel>
                    <asp:SqlDataSource ID="sqlCategories"
                        runat="server"
                        ConnectionString="<%$ ConnectionStrings:NORTHWINDConnectionString %>"
                        SelectCommand="SELECT [CategoryName], [CategoryID] FROM [Categories]" />
                    <asp:SqlDataSource ID="sqlProducts"
                        runat="server"
                        ConnectionString="<%$ ConnectionStrings:NORTHWINDConnectionString %>"
                        SelectCommand="SELECT [ProductID], [ProductName] FROM [Products] WHERE [CategoryID] = ISNULL(@CategoryID, CategoryID)" CancelSelectOnNullParameter="false">
                        <SelectParameters>
                            <asp:ControlParameter Name="CategoryID" ControlID="ASPxComboBox1" PropertyName="Value" ConvertEmptyStringToNull="true" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="sqlProductDetails" runat="server" ConnectionString="<%$ ConnectionStrings:NORTHWINDConnectionString %>" SelectCommand="SELECT [ProductID], [ProductName], [CategoryID], [UnitPrice], [UnitsInStock], [Discontinued] FROM [Products] WHERE ([ProductID] = @ProductID)">
                        <SelectParameters>
                            <asp:Parameter Name="ProductID" DefaultValue="" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>
    </form>
</body>
</html>
