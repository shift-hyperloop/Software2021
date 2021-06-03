#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <string.h>

#include <time.h>

#define PORT 8070
#define SA struct sockaddr

#define CAN_ID 0x333
typedef struct {
    uint32_t value_0;
} int_32_struct_t;

static int_32_struct_t can_data = {56};
static uint32_t timeMs = 0;
static uint16_t can_id = CAN_ID;

/* msleep(): Sleep for the requested number of milliseconds. */
int msleep(long msec)
{
    struct timespec ts;
    int res;
    int errno = 0;

    if (msec < 0)
    {
        errno = 1;
        return -1;
    }

    ts.tv_sec = msec / 1000;
    ts.tv_nsec = (msec % 1000) * 1000000;

    do {
        res = nanosleep(&ts, &ts);
    } while (res && errno == 0);

    return res;
}

int main()
{
    int sockfd, connfd, len;
    struct sockaddr_in servaddr, cli = {};

    // socket create and verification
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd == -1) {
        printf("socket creation failed...\n");
        exit(0);
    }

    // assign IP, PORT
    servaddr.sin_family = AF_INET;
    servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
    servaddr.sin_port = htons(PORT);

    // Binding newly created socket to given IP and verification
    if ((bind(sockfd, (SA *) &servaddr, sizeof(servaddr))) != 0) {
        printf("Failed to bind socket\n");
        exit(0);
    }

    // Now server is ready to listen and verification
    if ((listen(sockfd, 8)) != 0) {
        printf("Listen failed\n");
        exit(0);
    }

    printf("Server listening...\n");
    len = sizeof(cli);

    connfd = accept(sockfd, (SA *) &cli, (socklen_t*) &len);

    if (connfd < 0) {
        printf("server acccept failed...\n");
        exit(0);
    } else {
        printf("server acccept the client...\n");
    }

    while (1) {
        char buffer[7 + sizeof(can_data)];
        char dataSize = sizeof(can_data);
        time_t t;

        srand((unsigned) time(&t));
        int num = rand() % 50 + 200;

        can_data.value_0 = num;

        memcpy(buffer, (void*) &timeMs, 4);
        memcpy(buffer + 4, (void*) &can_id, 2);
        memcpy(buffer + 6, (void*) &dataSize, 1);
        memcpy(buffer + 7, (void*) &can_data, sizeof(can_data));
        if (send(connfd, (void*) buffer, 7 + sizeof(can_data), 0) == -1) {
            printf("Can not send :(\n");
        }
        printf("Sent value %d!\n", can_data.value_0);
        timeMs += 50;
        msleep(50);
    }
}
