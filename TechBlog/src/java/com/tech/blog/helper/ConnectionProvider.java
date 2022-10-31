
package com.tech.blog.helper;
import java.sql.*;

public class ConnectionProvider {
    
    private static  Connection conn;
    public static Connection getConnection()
    {
        try
        {
            if(conn==null)
            {
            //Drive Class Load
           Class.forName("com.mysql.jdbc.Driver");
           
           //create Connection
           conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/techblog","root","root@123");
            
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return conn;
    }
    
}
