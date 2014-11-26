#include "stdio.h"
#include "stdlib.h"
#include "string.h"

int main(void) {
    char *token;
    char *rawpath = getenv("PATH");
    token = strtok(rawpath, ";");
    while (token != NULL) {
        printf("%s\n", token);
        token = strtok(NULL, ";");
    }
    return 0;
}
