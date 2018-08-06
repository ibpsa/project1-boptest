/* Function that exchange data with an external object via socket connection.
 *
 * Sen Huang, PNNL                     2018-07-09
 */

#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<assert.h>
#include<ModelicaUtilities.h>

/* Function to parse message. */
char** str_split(char* a_str, char a_delim)
{
    char** result = NULL;
    size_t count = 0;
    char* tmp = a_str;
    char* last_comma = NULL;
    char delim[2];
    delim[0] = a_delim;
    delim[1] = 0;

    /* Count how many elements will be extracted. */
    while (*tmp)
    {
        if (a_delim == *tmp)
        {
            count++;
            last_comma = tmp;
        }
        tmp++;
    }

    /* Add space for trailing token. */
    count += last_comma < (a_str + strlen(a_str) - 1);

    /* Add space for terminating null string so caller
       knows where the list of returned strings ends. */
    count++;

    result = malloc(sizeof(char*) * count);

    if (result)
    {
        size_t idx  = 0;
        char* token = strtok(a_str, delim);

       while (token)
        {
            assert(idx < count);
            *(result + idx++) = strdup(token);
            token = strtok(0, delim);
        }
        assert(idx == count - 1);
        *(result + idx) = 0;
    /* assign the parsed string to individual element of the resulting array. */
    }
    else {
       ModelicaError("Error: Not enough memory to allocate string array in the str_split function plotSendReal.c");
    }
    return result;
}


/* Detect the operation system and choose corresponding dependencies to set up the socket connection. */
#ifdef __linux__
   #include<sys/socket.h>
   #include<arpa/inet.h>
#elif _WIN32
   #include<winsock2.h>
   #include<io.h>
   #pragma comment (lib, "Ws2_32.lib")
   #pragma comment (lib, "Mswsock.lib")
   #pragma comment (lib, "AdvApi32.lib")
   #pragma warning(disable:4996)
   #pragma comment (lib, "Ws2_32.lib")
   #pragma comment (lib, "Mswsock.lib")
   #pragma comment (lib, "AdvApi32.lib")
   #pragma warning(disable:4996)
#endif

int swap(int as, double a[], char** varNam, char** host, int port, double c[])
{
    ;
    struct sockaddr_in server;
    char message[4000], server_reply[3000];
    char** tokens;
    
    size_t count = 0;
    int i;
    /* Check the length of the variables. */
    for(i = 0; i < as; i = i + 1){
        count=count+strlen(varNam[i]);        
    }
    /* Check if the data is too big for the allocated memory. */
    if (count>4000-(22)*as)
    {
        ModelicaError("Error: Not enough memory for the sockclient.c");
        return 1;  
    }
      #ifdef _WIN32 
        WSADATA wsa;
        SOCKET sock;
        if (WSAStartup(MAKEWORD(2,2),&wsa) != 0)
        {
            ModelicaError("Error: Socket failed for the sockclient.c");
            return 1;
        }
      #elif __linux__
       int sock;
      #endif


    /* Create socket. */
    sock = socket(AF_INET, SOCK_STREAM, 0);
    if (sock == -1)
    {
        ModelicaError("Error: Could not create socket for the sockclient.c");
        return 1;
    }

    ModelicaMessage("Socket created \n");
    server.sin_addr.s_addr = inet_addr(host);
    server.sin_family = AF_INET;
    server.sin_port = htons(port);

    /* Connect to remote server. */
    if (connect(sock, (struct sockaddr *)&server, sizeof(server)) < 0)
    {
        ModelicaError("Error: socket connect failed for the sockclient.c");
        return 1;
    }

    ModelicaMessage("Socket connected \n");

   /* for loop execution. */
    strcpy(message, "");
    for(i = 0; i < as; i = i + 1){
      char buf[20];
      strcpy(buf, "");
      if ((a[i]>99999999999999999.0) || (a[i]<-9999999999999999.0))
      {
        ModelicaError("Error: Not enough memory for the sockclient.c");
        return 1;  
      }
      sprintf(buf,"%.2f", a[i]);
      strcat(message, varNam[i]);
      strcat(message, ",");
      strcat(message, buf);
      strcat(message, ",");
    }

    ModelicaMessage("Message created \n");
    /* Send data to remote server. */
    if(send(sock, message, strlen(message), 0) < 0)
    {
        ModelicaError("Error: socket message failed to be sent for the sockclient.c");
        return 1;
    }
    ModelicaMessage("Message sent \n");
    /* Receive data to remote server. */
    if(recv(sock, server_reply, 2000, 0) < 0)
    {
        ModelicaError("Error: socket message failed to be received for the sockclient.c");
        return 1;
    }
    if(strlen(server_reply) == 2000)
    {
        ModelicaError("Error: Not enough memory for the sockclient.c");
        return 1;
    }
    ModelicaMessage("Message received \n");
    
    /* Process data to remote server. */
    tokens = str_split(server_reply, ',');
    ModelicaMessage("Message parsed \n");
    for(i = 0; i <as; i = i + 1 ){
         *(c+i) = atof(*(tokens+i));
    }

    #ifdef __linux__
       close(sock);
    #elif _WIN32
       closesocket(sock);
       WSACleanup();
    #endif
    ModelicaMessage("Socket closed \n");
    return 0;
}