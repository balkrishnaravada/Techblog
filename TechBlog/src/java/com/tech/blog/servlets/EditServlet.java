/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.tech.blog.servlets;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Message;
import com.tech.blog.helper.PhotoAddHelper;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
public class EditServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            
            String email=request.getParameter("user_email");
            //String name=request.getParameter("user_name");
            String password=request.getParameter("user_password");
            String about=request.getParameter("about");
            //to get image from form
            Part part=request.getPart("image");
            //to get image name from file
            String imageName=part.getSubmittedFileName();
            
            //get the user from session;
            
            HttpSession s=request.getSession();
            User user=(User) s.getAttribute("currentUser");
            user.setEmail(email);
            user.setPassword(password);
            user.setAbout(about);
            String oldFilePath=user.getProfile();
            user.setProfile(imageName);
            
            UserDao u=new UserDao(ConnectionProvider.getConnection());
           boolean ans= u.updateUser(user);
           if(ans==true)
           {
        
               
               String path=request.getRealPath("/")+"pics"+File.separator+user.getProfile();
              
               String pathOldFile=request.getRealPath("/")+"pics"+File.separator+oldFilePath;
               if(!oldFilePath.equals("default.png"))
               {
               
               PhotoAddHelper.deleteFile(pathOldFile);
               
               }
                       
                if(PhotoAddHelper.saveFile(part.getInputStream(),path))
                        {
                            out.println("Profile Updated");
                            
                    Message msg= new Message("Photo Submitted Successfully","success","alert-success");
              
                s.setAttribute("msg",msg);
          
               response.sendRedirect("profile.jsp");
                        }
               
           }
           else
           {
               out.println("Not Updated");
               Message msg= new Message("Something Went wrong","error","alert-danger");
              
                s.setAttribute("msg",msg);
               
           }
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
