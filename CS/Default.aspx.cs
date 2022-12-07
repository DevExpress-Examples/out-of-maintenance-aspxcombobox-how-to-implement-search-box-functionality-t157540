using DevExpress.Web;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page {
    protected void ASPxComboBox2_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e) {
        ASPxComboBox2.DataBind();
    }
    protected void ASPxComboBox1_DataBound(object sender, EventArgs e) {
        ASPxComboBox1.Items.Insert(0, new DevExpress.Web.ListEditItem("All", ""));
    }
    protected void PanelDetails_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e) {
        sqlProductDetails.SelectParameters["ProductID"].DefaultValue = ASPxComboBox2.Value.ToString();
        DataTable dataTable = ((DataView)sqlProductDetails.Select(new DataSourceSelectArguments())).Table;
        HtmlTable table = new HtmlTable { ID = "detailTable", ClientIDMode = System.Web.UI.ClientIDMode.Static };
        if (dataTable.Rows.Count != 0) {
            DataRow details = dataTable.Rows[0];
            ASPxCallbackPanel panel = sender as ASPxCallbackPanel;
            for (int i = 0; i < details.ItemArray.Length; i++) {
                HtmlTableRow row = new HtmlTableRow();
                HtmlTableCell cellField = new HtmlTableCell() { InnerText = string.Format("{0}: ", dataTable.Columns[i].Caption), Width = ASPxComboBox1.Width.ToString() };
                HtmlTableCell cellValue = new HtmlTableCell() { InnerText = details[i].ToString() };
                row.Cells.Add(cellField); row.Cells.Add(cellValue);
                table.Rows.Add(row);
            }
            table.Style.Add("text-align", "right");
            panel.Controls.Add(table);
        }
    }

}