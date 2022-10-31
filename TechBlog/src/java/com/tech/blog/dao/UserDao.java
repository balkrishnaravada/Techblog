/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tech.blog.dao;
import com.tech.blog.entities.User;
import java.sql.*;
public class UserDao {
    
    private Connection con;

    public UserDao(Connection con) {
        this.con = con;
    }
    
    //insert data
    
    public boolean saveUser(User user)
    {
        boolean f=false;
        try
        {
            //user--> database
            
            String query="insert into user (name,email,password,gender,about) values(?,?,?,?,?)";
            PreparedStatement psmt=this.con.prepareStatement(query);
            psmt.setString(1, user.getName());
            psmt.setString(2, user.getEmail());
            psmt.setString(3,user.getPassword());
            psmt.setString(4,user.getGender());
            psmt.setString(5,user.getAbout());
            
            psmt.executeUpdate();
            f=true;
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return f;
    }
    
    //get user from user email & password
    public User getUserByEmailAndPassWord(String email,String password)
    {
        User user=null;
        try
        {
            String query="select * from user where email=? and password=?";
            PreparedStatement psmt=con.prepareStatement(query);
            psmt.setString(1,email);
            psmt.setString(2,password);
            
            ResultSet set=psmt.executeQuery();
            if(set.next())
            {
                user=new User();
                
                //data from db
                String name=set.getString("name");
                //set in user
                user.setName(name);
                
                user.setId(set.getInt("id"));
                user.setPassword(set.getString("password"));
                user.setEmail(set.getString("email"));
                user.setGender(set.getString("gender"));
                user.setAbout(set.getString("about"));
                user.setDateTime(set.getTimestamp("rdate"));
                user.setProfile(set.getString("profile"));
            }
            
        }
        catch(Exception e)
        {
         e.printStackTrace();
        }
        return user;    
    }
    
    //update user from edit servlet and profile page in database
    
    public boolean updateUser(User user)
    {
        boolean f=false;
        try
        {
            String query="update user set email=?,name=?,password=?,gender=?,about=?,profile=? where id=?";
            PreparedStatement p=con.prepareStatement(query);
            p.setString(1,user.getEmail());
            p.setString(2,user.getName());
            p.setString(3,user.getPassword());
            p.setString(4,user.getGender());
            p.setString(5,user.getAbout());
            p.setString(6,user.getProfile());
            p.setInt(7,user.getId());
            
            p.executeUpdate();
            f=true;
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return f;
    }
    
}
