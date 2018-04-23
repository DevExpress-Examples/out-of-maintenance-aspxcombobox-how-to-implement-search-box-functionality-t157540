Imports DevExpress.Web.ASPxCallbackPanel
Imports DevExpress.Web.ASPxEditors
Imports System
Imports System.Collections
Imports System.Collections.Generic
Imports System.Data
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.HtmlControls
Imports System.Web.UI.WebControls

Partial Public Class _Default
    Inherits System.Web.UI.Page

    Protected Sub ASPxComboBox2_Callback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxClasses.CallbackEventArgsBase)
        ASPxComboBox2.DataBind()
    End Sub
    Protected Sub ASPxComboBox1_DataBound(ByVal sender As Object, ByVal e As EventArgs)
        ASPxComboBox1.Items.Insert(0, New DevExpress.Web.ASPxEditors.ListEditItem("All", ""))
    End Sub
    Protected Sub PanelDetails_Callback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxClasses.CallbackEventArgsBase)
        sqlProductDetails.SelectParameters("ProductID").DefaultValue = ASPxComboBox2.Value.ToString()
        Dim dataTable As DataTable = CType(sqlProductDetails.Select(New DataSourceSelectArguments()), DataView).Table
        Dim table As HtmlTable = New HtmlTable With {.ID = "detailTable", .ClientIDMode = System.Web.UI.ClientIDMode.Static}
        If dataTable.Rows.Count <> 0 Then
            Dim details As DataRow = dataTable.Rows(0)
            Dim panel As ASPxCallbackPanel = TryCast(sender, ASPxCallbackPanel)
            For i As Integer = 0 To details.ItemArray.Length - 1
                Dim row As New HtmlTableRow()
                Dim cellField As New HtmlTableCell() With {.InnerText = String.Format("{0}: ", dataTable.Columns(i).Caption), .Width = ASPxComboBox1.Width.ToString()}
                Dim cellValue As New HtmlTableCell() With {.InnerText = details(i).ToString()}
                row.Cells.Add(cellField)
                row.Cells.Add(cellValue)
                table.Rows.Add(row)
            Next i
            table.Style.Add("text-align", "right")
            panel.Controls.Add(table)
        End If
    End Sub

End Class