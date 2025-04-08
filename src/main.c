#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/select.h>
#include "linenoise.h"
#include <sqlite3.h>

int main() {
   sqlite3* db;
   int rc = sqlite3_open(":memory:", &db);

   if (rc != SQLITE_OK) {
      // 处理数据库打开失败的情况
   }

   // 执行数据库操作

   sqlite3_close(db);

   return 0;
}
// int main(int argc, char **argv)
// {
//     printf("hello world!\r\n");
//     return 0;
// }