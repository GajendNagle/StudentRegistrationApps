using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

public partial class Master_Default2 : System.Web.UI.Page
{
    string connectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            FillGrid();
        }
    }
    public void FillGrid()
    {
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT StudentID,Name,ISNULL(ParentsName, 'No Parent') AS ParentsName,Gender,Course,Subjects,RegistrationDate FROM Students", conn);
            cmd.CommandType = CommandType.Text;
            DataSet ds = new DataSet();
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            sda.Fill(ds);
            grdStudentData.DataSource = ds;
            grdStudentData.DataBind();
        }
    }
    protected void ClearFields()
    {
        txtName.Text = string.Empty;
        txtParentName.Text = string.Empty;
        ddlCourse.ClearSelection();
        rblGender.ClearSelection();
        cblSubject.ClearSelection();
    }
    protected void BtnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string name = txtName.Text.Trim();
            string parentName = txtParentName.Text.Trim();
            string gender = rblGender.SelectedItem.Text;
            string course = ddlCourse.SelectedItem.Text;
            string cblvalues = "";
            foreach (ListItem item in cblSubject.Items)
            {
                if (item.Selected)
                {
                    cblvalues += item.Text + ",";
                }
            }
            cblvalues = cblvalues.TrimEnd(',');

            if (Page.IsValid)
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    if (BtnSubmit.Text == "Submit")
                    {
                        SqlCommand cmd = new SqlCommand("USP_InsertStudent", conn);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@ParentsName", parentName);
                        cmd.Parameters.AddWithValue("@Gender", gender);
                        cmd.Parameters.AddWithValue("@Course", course);
                        cmd.Parameters.AddWithValue("@Subjects", cblvalues);
                        conn.Open();
                        SqlDataAdapter sda = new SqlDataAdapter(cmd);
                        DataSet ds = new DataSet();
                        sda.Fill(ds);
                        if (ds.Tables.Count > 0)
                        {
                            if (Convert.ToBoolean(ds.Tables[0].Rows[0]["status"]))
                            {
                                string msg = Convert.ToString(ds.Tables[0].Rows[0]["msg"]);
                                string encodedMsg = HttpUtility.JavaScriptStringEncode(msg);
                                ClientScript.RegisterStartupScript(GetType(), "alert", "alert('" + encodedMsg + "');", true);

                            }
                        }
                    }
                    else if (BtnSubmit.Text == "Update")
                    {
                        SqlCommand cmd = new SqlCommand("[USP_StudentsUpdate]", conn);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@StudentID", ViewState["StudentID"].ToString());
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@ParentName", parentName);
                        cmd.Parameters.AddWithValue("@Gender", gender);
                        cmd.Parameters.AddWithValue("@Course", course);
                        cmd.Parameters.AddWithValue("@Subjects", cblvalues);
                        DataSet ds = new DataSet();
                        SqlDataAdapter sda = new SqlDataAdapter(cmd);
                        sda.Fill(ds);
                        if (ds.Tables.Count > 0)
                        {
                            if (Convert.ToBoolean(ds.Tables[0].Rows[0]["status"]))
                            {
                                string msg = Convert.ToString(ds.Tables[0].Rows[0]["msg"]);
                                string encodedMsg = HttpUtility.JavaScriptStringEncode(msg);
                                ClientScript.RegisterStartupScript(GetType(), "alert", "alert('" + encodedMsg + "');", true);

                            }
                        }

                    }
                    FillGrid();
                    ClearFields();
                }
            }

        }
        catch (Exception ex)
        {

            string errorMessage = "An error occurred. Please try again.";
            string script = "<script>alert('{errorMessage}');</script>";
            Response.Write(script);
        }
    }



    protected void grdStudentData_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            GridViewRow row = (GridViewRow)((LinkButton)e.CommandSource).NamingContainer;
            Label lblName = (Label)row.FindControl("lblname");
            Label lblParentsName = row.FindControl("lblParentsName") as Label;
            Label lblGender = row.FindControl("lblGender") as Label;
            Label lblSubjects = row.FindControl("lblSubjects") as Label;
            Label lblCourse = row.FindControl("lblCourse") as Label;
            ViewState["StudentID"] = e.CommandArgument.ToString();
            if (e.CommandName == "EditRecord")
            {
                txtName.Text = lblName.Text;
                txtParentName.Text = lblParentsName.Text;
                rblGender.ClearSelection();
                rblGender.Items.FindByText(lblGender.Text).Selected = true;
                string[] cblvalue = lblSubjects.Text.Split(',');
                cblSubject.ClearSelection();
                foreach (var item in cblvalue)
                {
                    ListItem listItem = cblSubject.Items.FindByText(item.Trim());
                    if (listItem != null)
                    {
                        listItem.Selected = true;
                    }
                }
                ddlCourse.ClearSelection();
                ddlCourse.Items.FindByText(lblCourse.Text).Selected = true;
                rblGender.ClearSelection();
                rblGender.Items.FindByText(lblGender.Text).Selected = true;
                BtnSubmit.Text = "Update";
            }
            else if (e.CommandName == "DeleteRecord")
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("[USP_StudentDelete]", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@StudentID", Convert.ToString(ViewState["StudentID"]));
                    DataSet ds = new DataSet();
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    sda.Fill(ds);
                    if (ds.Tables.Count > 0)
                    {
                        if (Convert.ToBoolean(ds.Tables[0].Rows[0]["status"]))
                        {
                            string msg = Convert.ToString(ds.Tables[0].Rows[0]["msg"]);
                            string encodedMsg = HttpUtility.JavaScriptStringEncode(msg);
                            ClientScript.RegisterStartupScript(GetType(), "alert", "alert('" + encodedMsg + "');", true);
                        }
                    }
                    FillGrid();
                }
            }
        }
        catch (Exception)
        {
            throw;
        }
    }
}
