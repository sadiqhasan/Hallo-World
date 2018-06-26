using System;
using System.Web;
using System.Data;
using System.Collections;
using System.Collections.Generic;
using TalukderPOS.BLL;
using TalukderPOS.DAL;
using TalukderPOS.BusinessObjects;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

namespace TalukderPOS.Web.UI
{
    public partial class BankInfo : System.Web.UI.Page
    {
        string EntryUserID = string.Empty;
        private string userID = string.Empty;
        private string Shop_id = string.Empty;
        private string userPassword = string.Empty;
        T_WGPGBLL BILL = new T_WGPGBLL();
        CommonDAL DAL = new CommonDAL();

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                EntryUserID = Session["EntryUserID"].ToString();
                userID = Session["UserID"].ToString();
                userPassword = Session["Password"].ToString();
                Shop_id = Session["StoreID"].ToString();
            }
            catch
            {
                Response.Redirect("~/frmLogin.aspx");
            }
            bool isAuthenticate = CommonBinder.CheckPageAuthentication(System.Web.HttpContext.Current.Request.Url.AbsolutePath, userID);

            if (!isAuthenticate)
            {
                Response.Redirect("~/UnAuthorizedUser.aspx");
            }
            if (!Page.IsPostBack)
            {
                //load dropdown
                //LoadDropDown();

                //loadGrid
                LoadGrid();

            }

        }

        private void LoadGrid()
        {

            string sql = string.Format(@"
select b.BankID,b.BankName,b.AccountNo,b.Status,b.Remarks 
,CONVERT(nvarchar(12),b.EntryDate,126) EntryDate
,usr.UserFullName,b.EntryUserID
from BankInfo b
left join [User] usr on usr.Id=b.EntryUserID
--where b.Status='Active'
order by BankName
");
            DataTable dt = DAL.LoadDataByQuery(sql);

            gvBankList.DataSource = null;
            gvBankList.DataSource = dt;
            gvBankList.DataBind();

        }

        private void LoadDropDown(DropDownList ddl, string sql)
        {
            DataTable dt = DAL.LoadDataByQuery(sql);

            if (dt.Rows.Count > 0)
            {
                ddl.DataSource = dt;
                ddl.DataValueField = "value";
                ddl.DataTextField = "text";
                ddl.DataBind();

                ddl.Items.Insert(0, new ListItem("...Select One...", String.Empty));
                ddl.SelectedIndex = 0;
            }


        }



        //============================================================================================

        protected void btnSave_Click(object sender, EventArgs e)
        {

            if (string.IsNullOrEmpty(txtBankNameBF.Text))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Bank Name!');", true);
                txtBankNameBF.Text = string.Empty;
                txtBankNameBF.Focus();

                return;
            }
            if (string.IsNullOrEmpty(txtAccountNo.Text))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Account No!');", true);
                txtAccountNo.Text = string.Empty;
                txtAccountNo.Focus();
                return;
            }


            //check
            string sqlExist = string.Format(@"select * from BankInfo where UPPER(BankName)='{0}' and AccountNo='{1}'
", txtBankNameBF.Text.Trim().ToUpper(), txtAccountNo.Text.Trim().ToUpper());

            DataTable dtExint = DAL.LoadDataByQuery(sqlExist);
            if (dtExint.Rows.Count > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Already Existed!');", true);

                txtBankNameBF.Text = string.Empty;
                txtBankNameBF.Focus();
                return;
            }

            //save or update 
            string sqlBank = string.Empty;

            if (string.IsNullOrEmpty(lblBankID.Text))
            {
                string sqlpk = string.Format(@"(select ((ISNULL(MAX(BankID),1000))+1) as pk from BankInfo)");
                DataTable dtpk = DAL.LoadDataByQuery(sqlpk);
                string pk = dtpk.Rows[0]["pk"].ToString();

                sqlBank = string.Format(@"
insert into BankInfo( BankID, BankName, AccountNo, Status, Remarks          , EntryUserID, EntryDate)
values('{0}','{1}','{2}','{3}','{4}',   '{5}','{6}')
", pk, txtBankNameBF.Text.Trim(), txtAccountNo.Text.Trim(), ddlStatusBF.SelectedValue, "", EntryUserID, DateTime.Now.ToString());

            }
            else
            {

                sqlBank = string.Format(@"
update BankInfo set BankName='{1}' ,AccountNo='{2}' ,Status='{3}' where BankID='{0}'
", lblBankID.Text, txtBankNameBF.Text.Trim(), txtAccountNo.Text.Trim(), ddlStatusBF.SelectedValue);
            }

            DAL.LoadDataByQuery(sqlBank);

            //msg
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Saved!');", true);

            ClearBF();
            LoadGrid();
        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ClearBF();
        }
        protected void btnEditBF_Click(object sender, EventArgs e)
        {
            int rowIndex = ((sender as Button).NamingContainer as GridViewRow).RowIndex;

            string BankID = gvBankList.DataKeys[rowIndex].Values["BankID"].ToString();
            string BankName = gvBankList.DataKeys[rowIndex].Values["BankName"].ToString();
            string AccountNo = gvBankList.DataKeys[rowIndex].Values["AccountNo"].ToString();
            string Status = gvBankList.DataKeys[rowIndex].Values["Status"].ToString();

            lblBankID.Text = string.Empty;
            lblBankID.Text = BankID;
            txtBankNameBF.Text = BankName;
            txtAccountNo.Text = AccountNo;
            ddlStatusBF.SelectedValue = Status;

            btnSave.Text = "Update";

        }
        private void ClearBF()
        {
            lblBankID.Text = string.Empty;
            lblBankID.Text = string.Empty;
            txtBankNameBF.Text = string.Empty;
            txtAccountNo.Text = string.Empty;
            ddlStatusBF.SelectedIndex = -1;

            btnSave.Text = "Save";

        }
    }
}

