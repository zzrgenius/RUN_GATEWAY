#include <stdio.h>
#include <unistd.h>
#include "zlog.h"

int main(int argc, char** argv)
{
        int rc;
    	int i = 0;
        zlog_category_t *c;

        rc = zlog_init("./zlog.conf");
        if (rc) {
                printf("init failed\n");
                return -1;
        }

        c = zlog_get_category("my_cat");
        if (!c) {
                printf("get cat fail\n");
                zlog_fini();
                return -2;
        }

    	while(i < 10){
            zlog_debug(c, "hello, zlog");
            zlog_info(c, "hello, zlog");
            zlog_notice(c, "hello, zlog");
            zlog_warn(c, "hello, zlog");
        	zlog_error(c, "hello, zlog");
            zlog_fatal(c, "hello, zlog");
            sleep(1);
            ++i;
        }
        
        zlog_fini();

        return 0;
}

