using System;
using System.Data;
using Microsoft.SqlServer.Server;
using System.Data.SqlTypes;

public class StoredProcedures 
{
 /// <summary>
 /// Ejecutar una instrucción y enviar la lista de clientes activos
 /// </summary>
 [Microsoft.SqlServer.Server.SqlProcedure]
 public static void ListActiveCustomers()
 {
 using(SqlConnection connection = new SqlConnection("context connection=true")) 
 {
 connection.Open();
 SqlCommand command = new SqlCommand("SELECT FirstName, LastName, CustomerID FROM Sales.Customers WHERE CustomerStatusID = 1", connection);
 SqlDataReader r = command.ExecuteReader();
 SqlContext.Pipe.Send(r);
 }
 }
}