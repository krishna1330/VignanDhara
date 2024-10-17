<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="VignanDhara.Web._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
        <div class="jumbotron text-center">
            <h1>Welcome, <%: Session["Username"] ?? "Guest user" %><asp:Label ID="lblUsername" runat="server" Text=""></asp:Label></h1>
            <p class="lead">We're glad to have you here!</p>
        </div>

        <div class="row">
            <div class="col-md-12">
                <h2>What is Vignan Dhara?</h2>
                <p>
                    Vignan Dhara is an innovative platform aimed at providing quality education and resources to students and professionals alike. 
                    We believe in the power of knowledge and strive to create an engaging learning environment that fosters growth, creativity, 
                    and excellence. Our mission is to empower learners through effective and accessible educational solutions.
                </p>
                <p>
                    Our platform offers a variety of courses, resources, and tools designed to help individuals achieve their personal and professional goals. 
                    Whether you're looking to enhance your skills, learn something new, or simply explore your interests, Vignan Dhara is here to support your journey.
                </p>
            </div>
        </div>

        <div class="text-center">
            <a class="btn btn-primary btn-lg" href="Courses.aspx">Explore Courses &raquo;</a>
        </div>
    </div>

</asp:Content>
