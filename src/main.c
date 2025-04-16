#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/select.h>
#include "libmodbus/libmodbus.h"
// #include "linenoise.h"
#include "sqlite3.h"
#define DATABASE_NAME                 "MyDBDemo.db"
int callback(void* ,int nCount,char** pValue,char** pName)
{
    char print_str[128];
    for(int i=0;i<nCount;i++)
    {
      sprintf(print_str,"[%s] = %s\n",pName[i],pValue[i]);       
    }
    printf("%s", print_str);
    return 0;  
}
int main() {
   sqlite3* db;
   int rc = sqlite3_open(DATABASE_NAME, &db);

   if (rc != SQLITE_OK) {
      fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
      return 1;
   }

   // Create table
   char* err_msg = 0;
   const char* create_table_sql = 
      "CREATE TABLE IF NOT EXISTS Users("
      "Id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "Name TEXT NOT NULL,"
      "Age INTEGER);";
   
   rc = sqlite3_exec(db, create_table_sql, 0, 0, &err_msg);
   if (rc != SQLITE_OK) {
      fprintf(stderr, "SQL error: %s\n", err_msg);
      sqlite3_free(err_msg);
      sqlite3_close(db);
      return 1;
   }

   // Insert data
   const char* insert_sql = 
      "INSERT INTO Users (Name, Age) VALUES ('Alice', 25);"
      "INSERT INTO Users (Name, Age) VALUES ('Bob', 30);";
   
   rc = sqlite3_exec(db, insert_sql, 0, 0, &err_msg);
   if (rc != SQLITE_OK) {
      fprintf(stderr, "SQL error: %s\n", err_msg);
      sqlite3_free(err_msg);
      sqlite3_close(db);
      return 1;
   }

   // Query and display data
   printf("User Data:\n");
   printf("ID\tName\tAge\n");
   
   const char* select_sql = "SELECT * FROM Users;";
   rc = sqlite3_exec(db, select_sql, callback, 0, &err_msg);
   
   if (rc != SQLITE_OK) {
      fprintf(stderr, "SQL error: %s\n", err_msg);
      sqlite3_free(err_msg);
   } else {

      printf("Data retrieved successfully.\n");
   }

   sqlite3_close(db);
    printf("hello world!\r\n");

   return 0;
}
