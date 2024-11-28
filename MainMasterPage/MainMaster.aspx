<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MainMaster.aspx.cs" Inherits="MainMasterPage_MainMaster" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
     <form id="form1" runat="server">
     <div>
         <!-- ======= Header ======= -->
         <header id="header" class="header fixed-top d-flex align-items-center">

             <div class="d-flex align-items-center justify-content-between">
                 <a href="#" class="logo d-flex align-items-center">
                     <img src="assets/img/logo.png" alt="">
                     <span class="d-none d-lg-block">Pofile</span>
                 </a>
                 <i class="bi bi-list toggle-sidebar-btn"></i>
             </div>
             <!-- End Logo -->


             <!-- End Search Bar -->

             <nav class="header-nav ms-auto">
                 <ul class="d-flex align-items-center">
                     <li class="nav-item dropdown pe-3">
                         <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
                             <img src="assets/img/profile-img.jpg" alt="Profile" class="rounded-circle"/>
                             <span class="d-none d-md-block dropdown-toggle ps-2">Account holder</span>
                         </a>
                         <!-- End Profile Iamge Icon -->

                         <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
                             <li class="dropdown-header">
                                 <h6>
                                     <asp:Label runat="server" ID="lblUserName"></asp:Label></h6>
                                 <span>Account holder</span>
                             </li>
                             <li>
                                 <hr class="dropdown-divider">
                             </li>

                             <li>
                                 <a class="dropdown-item d-flex align-items-center" href="ViewProfile.aspx">
                                     <i class="bi bi-person"></i>
                                     <span>View Profile</span>
                                 </a>
                             </li>
                             <li>
                                 <hr class="dropdown-divider">
                             </li>

                             <li>
                                 <hr class="dropdown-divider">
                             </li>

                             <li>
                                 <a class="dropdown-item d-flex align-items-center" href="Login.aspx">
                                     <i class="bi bi-box-arrow-right"></i>
                                     <span>Sign Out</span>
                                 </a>
                             </li>

                         </ul>
                         <!-- End Profile Dropdown Items -->
                     </li>
                     <!-- End Profile Nav -->

                 </ul>
             </nav>
             <!-- End Icons Navigation -->

         </header>
         <!-- End Header -->

         <!-- ======= Sidebar ======= -->
         <aside id="sidebar" class="sidebar">

             <ul class="sidebar-nav" id="sidebar-nav">

                 <li class="nav-item">
                     <a class="nav-link " href="ViewProfile.aspx">
                         <i class="bi bi-grid"></i>
                         <span>View Pofile</span>
                     </a>
                 </li>
                 <li class="nav-item">
                     <a class="nav-link " href="login.aspx">
                         <i class="bi bi-person-add"></i>
                         <span>Sign Out</span>
                     </a>
                 </li>
                 <!-- End Dashboard Nav -->
             </ul>

         </aside>
         <!-- End Sidebar-->

         <main id="main" class="main">

             <asp:ContentPlaceHolder ID="ContentBody" runat="server">
             </asp:ContentPlaceHolder>

         </main>
         <!-- End #main -->

         <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

         <!-- Vendor JS Files -->
         <script src="/assets/vendor/apexcharts/apexcharts.min.js"></script>
         <script src="/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
         <script src="/assets/vendor/chart.js/chart.umd.js"></script>
         <script src="/assets/vendor/echarts/echarts.min.js"></script>
         <script src="/assets/vendor/quill/quill.min.js"></script>
         <script src="/assets/vendor/simple-datatables/simple-datatables.js"></script>
         <script src="/assets/vendor/tinymce/tinymce.min.js"></script>
         <script src="/assets/vendor/php-email-form/validate.js"></script>
         <!-- Template Main JS File -->
         <script src="assets/js/main.js"></script>
         <asp:ContentPlaceHolder ID="ContentFooter" runat="server">
         </asp:ContentPlaceHolder>
     </div>
 </form>
</body>
</html>
