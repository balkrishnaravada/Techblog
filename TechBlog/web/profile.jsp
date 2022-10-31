
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.helper.Message"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error_page.sp" %>
<%
    User user=(User) session.getAttribute("currentUser");
    if(user==null)
    {
    response.sendRedirect("login_page.jsp");
    }

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Page</title>
           <!-- css -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
              integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
              crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        
        
        
    </head>
    <body>
      
        <!-- Start of Navbar --> 
        <nav class="navbar navbar-expand-lg navbar-dark primary-background">
            <a class="navbar-brand" href="#"><span class="fa fa-group"></span>TechBlog</a>
              <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
              <span class="navbar-toggler-icon"></span>
              </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                  <li class="nav-item active">
                      <a class="nav-link" href="#"><span class="fa fa-mortar-board"></span>Learn with me <span class="sr-only">(current)</span></a>
                  </li>

                  <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <span class="fa fa-clone"></span> Categories
                    </a>
                      <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                      <a class="dropdown-item" href="#">Programming Language</a>
                      <a class="dropdown-item" href="#">Project Implementation</a>
                      <div class="dropdown-divider"></div>
                      <a class="dropdown-item" href="#">Data Structure</a>
                      </div>
                  </li>
                  <li class="nav-item">
                      <a class="nav-link" href="#"><span class="fa fa-phone"></span>Contact Us</a>
                  </li>
                  
                   <li class="nav-item">
                      <a class="nav-link" href="#" data-toggle="modal" data-target="#addPostModal"><span class="fa fa-send-o"></span>Do Post</a>
                   </li><!-- comment -->
                </ul>
                
                <ul class="navbar-nav mr-right">
                  <li class="nav-item">
                      <a class="nav-link" href="#1" data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user-circle-o"></span><%=user.getName()%></a>
                  </li>
                  <li class="nav-item">
                      <a class="nav-link" href="LogoutServlet"><span class="fa fa-sign-out"></span>LogOut</a>
                  </li>   
                </ul>
            </div>
        </nav> 
        <!-- End of Navbar --> 
        
         <!-- Success Message -->
          <%
                          Message m=(Message)session.getAttribute("msg");
                          if(m!=null)
                          {
                          

                          %>
                          <div class="alert <%=m.getCssClass()%>" role="alert">
                                <%=m.getContent()%>
                           </div>
                          <%
                              session.removeAttribute("msg");
                        }
                            
                        %> 
        
        

            <!-- Modal -->
            <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header primary-background text-center">
                    <h5 class="modal-title text-center" id="exampleModalLabel">Profile</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                  </div>
                  <div class="modal-body">
                     <div class="container text-center mt-3">
                         <img src="pics/<%= user.getProfile() %>" class="img-fluid" style="border-radius: 50%; max-width: 125px">
                     <h5 class="modal-title mt-3" id="exampleModalLabel"><%= user.getName() %></h5>
                     
                     <!-- Details -->
                     <div id="profile-details">
                     <table class="table">
                        
                        <tbody>
                          <tr>
                            <th scope="row">ID:</th>
                            <td><%= user.getId() %></td>  
                          </tr>
                          <tr>
                            <th scope="row">Email-Id:</th>
                            <td><%= user.getEmail()%></td>
                          </tr>
                          <tr>
                            <th scope="row">Gender:</th>
                            <td><%=user.getGender()%></td>
                          </tr>
                          <tr>
                            <th scope="row">About Me:</th>
                            <td><%=user.getAbout()%></td>
                          </tr>
                          <tr>
                            <th scope="row">Registered:</th>
                            <td><%= user.getDateTime()%></td>
                          </tr>
                        </tbody>
                      </table>
                     </div>
                     
                    <!-- Edit Details --> 
                    
                    <div  id="profile-edit" style="display: none">
                        <h3 class="mt-2">Update Details</h3>
                        <form action="EditServlet" method="post" enctype="multipart/form-data">
                            <table class="table">
                               <tr>
                               <th scope="row">ID:</th>
                               <td><%= user.getId() %></td>  
                               </tr> 
                               <tr>
                               <th scope="row">Email:</th>
                               <td><input type="email" class="form-control" name="user_email" value="<%= user.getEmail() %>"/></td>  
                               </tr> 
                                <tr>
                               <th scope="row">Password:</th>
                               <td><input type="password" class="form-control" name="user_password" value="<%= user.getPassword() %>"/></td>  
                               </tr> 
                               <tr>
                               <th scope="row">Gender:</th>
                                <td><%= user.getGender().toUpperCase() %></td>   
                               </tr> 
                               <tr>
                               <th scope="row">About:</th>
                               <td><textarea  name="about" rows="2" cols="10"  class="form-control"> <%= user.getAbout()%>
                                   </textarea></td>
                               </tr>
                               <tr>
                               <th scope="row">New Profile:</th>
                               <td><input type="file" name="image" calss="form-control"></td>   
                               </tr> 
                            </table> 
                                   <div class="container text-center">
                                   <button type="submit" class="btn-primary">Save</button>
                                   </div>
                        </form>  
                    </div>
                     </div>       
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Ok</button>
                    <button type="button" id="edit-profile-btn" class="btn btn-primary">Edit</button>
                  </div>
                </div>
              </div>
            </div>
        
        <!--End of Edit Details --> 
        
        <!-- Post Modal--> 
                
                <!-- Modal -->
                <div class="modal fade" id="addPostModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                  <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Add your post details...</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        
                        <div class="modal-body">
                           <form action="AddPostServlet" method="post" id="add-post-form">
                                <div class="form-group">
                                    <select class="form-control" name="cid">
                                        <option selected disabled>----Select Category----</option>
                                        <%
                                            PostDao p=new PostDao(ConnectionProvider.getConnection());
                                            ArrayList<Category> list=p.getAllCategories();
                                            for(Category c:list)
                                            {
                                        %>
                                        <option value="<%= c.getCid()%>"><%= c.getName() %> </option>
                                        <%    
                                        }
                                         %>
                                    </select>
                                </div>
                               
                                <div class="form-group">
                                    <input type="text" name="title" placeholder="Enter Post Title" class="form-control"/>
                                </div>
                                <div class="form-group">  
                                    <textarea type="text" style="height:150px" name="content" placeholder="Enter Post Content" class="form-control"></textarea>
                                </div>
                                <div class="form-group">  
                                    <textarea type="text" style="height:150px" name="code" placeholder="Enter your Program Code(If any)" class="form-control"></textarea>
                                </div>
                                <div class="form-group">
                                    <label>Select your pic..</label>
                                    <input type="file" name="pic" placeholder="Add your pic" class="form-control"/>
                                </div>
                                <div class="container text-center">
                                     <button type="submit" class="btn btn-primary">Post</button>
                               </div>
                           </form>
                        </div>
                        
                    </div>
                  </div>
                </div>
        
        
        <!-- End of Post Modal --> 
        
        
        
         <!-- Javascript -->
        <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
         <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
         <script src="js/myjs.js" type="text/javascript"></script>
         
         <script>
             
             
             $(document).ready(function(){
                 
                 let editStatus=false;
                 
                 $('#edit-profile-btn').click(function()
                 {
                     if(editStatus == false)
                     {
                  $('#profile-details').hide();
                  $('#profile-edit').show();
                  editStatus=true;
                  $(this).text("Back");
              }
              else
              {
                  $('#profile-details').show();
                  $('#profile-edit').hide();
                  editStatus=false;
                  $(this).text("Edit");
              }
                 });
             });
             
         </script>
         
         <!-- Add Post --> 
         <script>
         
         $(document).ready(function(e){
             
             $("#add-post-form").on("submit",function(event){ //it will called when form is submitted
                 event.preventDefault();
                     console.log("you have clicked on submit") ;   
                  let form=new FormData(this);
                  
                  //now requesting to server
                  $.ajax({
                      url:"AddPostServlet",
                      type:'POST',
                      data: form,
                      success: function (data, textStatus, jqXHR) {
                       console.log(data); 
                    },
                       error: function (jqXHR, textStatus, errorThrown) {
                        
                    },
                    processData:false,
                    contentType:false
                   })
                 
                 
             })
             
         });
         </script>
    </body>
</html>
