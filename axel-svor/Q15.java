// Forritið má þýða og keyra svona í Windows:
//   javac Sample.java
//   java -cp .;sqlite-jdbc-....jar Sample
// Í Unix:
//   javac Sample.java
//   java -cp .:sqlite-jdbc-....jar Sample

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Q15
{
  public static void main(String[] args) throws ClassNotFoundException
  {
    // load the sqlite-JDBC driver using the current class loader
    Class.forName("org.sqlite.JDBC");
    
    Connection connection = null;
    try
    {
      // create a database connection
      connection = DriverManager.getConnection("jdbc:sqlite:prof.db");
      Statement statement = connection.createStatement();
     
      int sum = 0;
      ResultSet rs = statement.executeQuery("SELECT length FROM Movie");
      while(rs.next())
      {
        sum += rs.getInt(1);
      }
      rs.close();
      System.out.println("Heildarlengd allra mynda er: " + sum);
    }
    catch(SQLException e)
    {
      System.err.println(e.getMessage());
    }
    finally
    {
      try
      {
        if(connection != null)
          connection.close();
      }
      catch(SQLException e)
      {
        System.err.println(e);
      }
    }
  }
}

