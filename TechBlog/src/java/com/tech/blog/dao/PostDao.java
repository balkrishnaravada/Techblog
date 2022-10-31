
package com.tech.blog.dao;
import com.tech.blog.entities.Category;
import java.sql.*;
import java.util.ArrayList;

public class PostDao {
    
    Connection con;
    
    public PostDao(Connection con)
    {
        this.con=con;
    }
    
  public ArrayList<Category> getAllCategories()
  {
           ArrayList<Category> list=new ArrayList<>();
           try
           {
               String query="select * from categories";
               Statement st=this.con.createStatement();
               ResultSet r=st.executeQuery(query);
               while(r.next())
               {
                 int cid=r.getInt("cid");
               String name=r.getString("name");
               String description=r.getString("description");
                 Category c=new Category(cid,name,description);
                 list.add(c);
               }
              
           }
           catch(Exception e)
           {
               e.printStackTrace();
           }
    return list;       
           
  }
  
  
    
}
