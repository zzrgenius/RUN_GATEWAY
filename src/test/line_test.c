#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <uv.h>
#include "linenoise.h"

void completion(const char *buf, linenoiseCompletions *lc) {
    if (buf[0] == 'h') {
        linenoiseAddCompletion(lc, "hello");
        linenoiseAddCompletion(lc, "hello there");
    }
}

char *hints(const char *buf, int *color, int *bold) {
    if (!strcasecmp(buf, "hello")) {
        *color = 35;
        *bold = 0;
        return " World";
    }
    return NULL;
}

void on_input(uv_stream_t *stream, ssize_t nread, const uv_buf_t *buf) {
    if (nread > 0) {
        buf->base[nread] = '\0'; // Null-terminate the input
        char *line = linenoise(buf->base);
        if (line) {
            printf("echo: '%s'\n", line);
            linenoiseHistoryAdd(line);
            linenoiseHistorySave("history.txt");
            free(line);
        }
    } else if (nread < 0) {
        fprintf(stderr, "Error reading from serial port: %s\n", uv_strerror(nread));
        uv_close((uv_handle_t *)stream, NULL);
    }
    free(buf->base);
}

void on_alloc(uv_handle_t *handle, size_t suggested_size, uv_buf_t *buf) {
    buf->base = malloc(suggested_size);
    buf->len = suggested_size;
}

int main() {
    uv_loop_t *loop = uv_default_loop();
    linenoiseSetCompletionCallback(completion);
    linenoiseSetHintsCallback(hints);
    linenoiseHistoryLoad("history.txt");

    uv_tty_t tty;
    uv_tty_init(loop, &tty, 0, 1); // 0 = stdin (serial input)

    uv_read_start((uv_stream_t *)&tty, on_alloc, on_input);

    printf("Listening for input on serial port...\n");
    return uv_run(loop, UV_RUN_DEFAULT);
}