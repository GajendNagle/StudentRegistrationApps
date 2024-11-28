<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="Master_Default2" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../assets/css/bootstrap.min.css" rel="stylesheet" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server" >
        <div class="container-fluid">
            <div class="card">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-3">
                            <label>Name</label>
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtName"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
                                ErrorMessage="Name is required." CssClass="text-danger" ValidationGroup="BtnA" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                        <div class="col-md-3">
                            <label>Parent Name</label>
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtParentName"></asp:TextBox>
                        </div>

                        <div class="col-md-3">
                            <label>Gender</label>
                            <asp:RadioButtonList CssClass="form-control" RepeatDirection="Horizontal" runat="server" ID="rblGender">
                                <asp:ListItem Text="Male" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Female" Value="2"></asp:ListItem>
                                <asp:ListItem Text="Other" Value="3"></asp:ListItem>
                            </asp:RadioButtonList>
                            <asp:RequiredFieldValidator ID="rfvGender" runat="server" ControlToValidate="rblGender"
                                ErrorMessage="Gender is required." CssClass="text-danger" ValidationGroup="BtnA" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                        <div class="col-md-3">
                            <label>Course</label>
                            <asp:DropDownList CssClass="form-select" runat="server" ID="ddlCourse">
                                <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                <asp:ListItem Text="BBA" Value="1"></asp:ListItem>
                                <asp:ListItem Text="BCom" Value="2"></asp:ListItem>
                                <asp:ListItem Text="Bsc" Value="3"></asp:ListItem>
                                <asp:ListItem Text="BA" Value="4"></asp:ListItem>
                                <asp:ListItem Text="BE" Value="5"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvCourse" runat="server" ControlToValidate="ddlCourse"
                                ErrorMessage="Course selection is required." CssClass="text-danger" ValidationGroup="BtnA" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                        <div class="col-md-5">
                            <label>Subjects</label>
                            <asp:CheckBoxList CssClass="form-control" runat="server" RepeatDirection="Horizontal" ID="cblSubject">
                                <asp:ListItem Text="Maths" Value="0"></asp:ListItem>
                                <asp:ListItem Text="Science" Value="1"></asp:ListItem>
                                <asp:ListItem Text="English" Value="3"></asp:ListItem>
                                <asp:ListItem Text="History" Value="4"></asp:ListItem>
                                <asp:ListItem Text="Computer Science" Value="5"></asp:ListItem>
                            </asp:CheckBoxList>
                            <asp:CustomValidator ID="cvSubjects" runat="server" ErrorMessage="At least one subject is required."
                                CssClass="text-danger" ValidationGroup="BtnA" ClientValidationFunction="validateSubjects" Display="Dynamic"></asp:CustomValidator>
                        </div>

                        <div class="col-md-12 mt-2">
                            <asp:Button CssClass="btn btn-primary" ValidationGroup="BtnA" runat="server" ID="BtnSubmit" Text="Submit" OnClick="BtnSubmit_Click" />
                        </div>
                    </div>
                    <script type="text/javascript">
                        function validateSubjects(sender, args) {
                            var checkboxList = document.getElementById('<%= cblSubject.ClientID %>');
                            var isChecked = false;
                            var checkboxes = checkboxList.getElementsByTagName('input');

                            for (var i = 0; i < checkboxes.length; i++) {
                                if (checkboxes[i].checked) {
                                    isChecked = true;
                                    break;
                                }
                            }

                            args.IsValid = isChecked;
                        }
                    </script>

                </div>
                <div class="card-footer">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="table table-responsive">
                                <asp:GridView runat="server" OnRowCommand="grdStudentData_RowCommand" ID="grdStudentData" CssClass="table table-bordered" AutoGenerateColumns="false">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Sr No.">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblid" Text='<%# Container.DataItemIndex+1 %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Name">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblname" Text='<%# Eval("Name") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Parents Name">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblParentsName" Text='<%# Eval("ParentsName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Gender">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblGender" Text='<%# Eval("Gender") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Course">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblCourse" Text='<%# Eval("Course") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Subjects">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblSubjects" Text='<%# Eval("Subjects") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Registration Date">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblRegistrationDate" Text='<%# Eval("RegistrationDate") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Action">
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server" CommandName="EditRecord" CommandArgument='<%# Eval("StudentID") %>' Text="Edit" CssClass="btn btn-info"></asp:LinkButton>

                                                <asp:LinkButton runat="server" CommandName="DeleteRecord" CommandArgument='<%# Eval("StudentID") %>' Text="Delete" CssClass="btn btn-danger"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <%--<script type="text/javascript">
       function validateForm() {
           var isValid = true;

           document.getElementById("nameError").style.display = "none";
           document.getElementById("parentNameError").style.display = "none";
           document.getElementById("genderError").style.display = "none";
           document.getElementById("courseError").style.display = "none";
           document.getElementById("subjectError").style.display = "none";

           var name = document.getElementById("<%= txtName.ClientID %>").value;
        if (name.trim() === "") {
            document.getElementById("nameError").style.display = "inline";
            isValid = false;
        }

        

        var gender = document.querySelector('input[name="rblGender"]:checked');
        if (!gender) {
            document.getElementById("genderError").style.display = "inline";
            isValid = false;
        }

        var course = document.getElementById("<%= ddlCourse.ClientID %>").value;
        if (course === "0") {
            document.getElementById("courseError").style.display = "inline";
            isValid = false;
        }

        var subjects = document.querySelectorAll('#<%= cblSubject.ClientID %> input:checked');
           if (subjects.length === 0) {
               document.getElementById("subjectError").style.display = "inline";
               isValid = false;
           }

           return isValid;
       }
   </script>--%>
</body>
</html>
