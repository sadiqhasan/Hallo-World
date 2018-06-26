<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="BankInfo.aspx.cs" Inherits="TalukderPOS.Web.UI.BankInfo" Title="Bank Info" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ViewContentPlace" runat="server">
    <asp:UpdateProgress ID="updProgress" AssociatedUpdatePanelID="UpdatePanel1" runat="server">
        <ProgressTemplate>
            <img alt="progress" src="../Images/progress.gif" />
            Processing...</ProgressTemplate>
    </asp:UpdateProgress>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:TabContainer ID="tabContainerBankInfo" runat="server" Width="100%" CssClass="fancy fancy-green"
                ActiveTabIndex="0">
                <%--<asp:TabPanel ID="TabPanel1" runat="server" HeaderText="Bank List">
                    <ContentTemplate>
                        <div>
                        </div>
                    </ContentTemplate>
                </asp:TabPanel>--%>
                <asp:TabPanel ID="tpEditor" runat="server" HeaderText="Bank Add/Edit">
                    <ContentTemplate>
                        <div id="dvBankForm" style="padding: 15px;">
                            <div class="row">
                                <div class="col-md-2">
                                    Bank Name
                                </div>
                                <div class="col-md-4">
                                    <asp:TextBox ID="txtBankNameBF" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="col-md-2">
                                </div>
                                <div class="col-md-4">
                                    <asp:Label ID="lblBankID" runat="server"></asp:Label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-2">
                                    Account No
                                </div>
                                <div class="col-md-4">
                                    <asp:TextBox ID="txtAccountNo" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="col-md-2">
                                </div>
                                <div class="col-md-4">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-2">
                                    Status
                                </div>
                                <div class="col-md-4">
                                    <asp:DropDownList ID="ddlStatusBF" runat="server" CssClass="form-control">
                                        <asp:ListItem Selected="True">Active</asp:ListItem>
                                        <asp:ListItem>Inactive</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-4">
                                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-sm btn-success"
                                        OnClick="btnSave_Click" />
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-sm btn-warning"
                                        OnClick="btnCancel_Click" />
                                </div>
                                <div class="col-md-2">
                                </div>
                            </div>
                            <div class="row" style="padding-top: 20px;">
                                <asp:GridView ID="gvBankList" runat="server" AutoGenerateColumns="False" BorderColor="#CCCCCC"
                                    BorderStyle="None" BorderWidth="1px" CellPadding="3" CssClass="table table-bordered table-condensed table-hover table-responsive"
                                    DataKeyNames="BankID,BankName,AccountNo,Status" EmptyDataText="No rows returned"
                                    GridLines="None" Width="100%">
                                    <AlternatingRowStyle CssClass="alt" />
                                    <Columns>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                SI
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblSRNO0" runat="server" Text="<%#Container.DataItemIndex+1 %>"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="BankName" HeaderText="Bank Name">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="AccountNo" HeaderText="Account No">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Status" HeaderText="Status">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="EntryDate" HeaderText="Date">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="UserFullName" HeaderText="Entered by">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="View">
                                            <ItemTemplate>
                                                <asp:Button ID="btnEditBF" runat="server" CssClass="btn btn-sm btn-warning" Text="Edit"
                                                    OnClick="btnEditBF_Click" />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:TabPanel>
                <%--<asp:TabPanel ID="TabPanel2" runat="server" HeaderText="TabPanel2">
                    <ContentTemplate>
                        <div id="dvOtherRequisitionForm" style="padding: 15px;">
                            <div class="row">
                                <div class="col-md-2">
                                   
                                </div>
                                <div class="col-md-4">
                                    
                                </div>
                                <div class="col-md-2">
                                </div>
                                <div class="col-md-4">
                                    <asp:Label ID="Label1" runat="server"></asp:Label>
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:TabPanel>--%>
            </asp:TabContainer>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
