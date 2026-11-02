/* Small standard Brainfuck interpreter used to execute baseline.bf. */
#include <stdio.h>
#include <stdlib.h>
#ifdef _WIN32
#include <fcntl.h>
#include <io.h>
#endif
enum { TAPE_CELLS = 30000 };
int main(int argc, char **argv) {
    FILE *source; long length, *bracket, *stack, depth=0, ip=0, cell=0, i;
    char *program; unsigned char *tape;
#ifdef _WIN32
    _setmode(_fileno(stdin), _O_BINARY); _setmode(_fileno(stdout), _O_BINARY);
#endif
    if (argc != 2) { fprintf(stderr,"usage: bf_interpreter program.bf\n"); return 2; }
    source=fopen(argv[1],"rb"); if(!source){perror("open program");return 2;}
    if(fseek(source,0,SEEK_END)!=0||(length=ftell(source))<0||fseek(source,0,SEEK_SET)!=0){perror("read program");return 2;}
    program=malloc((size_t)length+1); bracket=malloc(((size_t)length+1)*sizeof(long)); stack=malloc(((size_t)length+1)*sizeof(long)); tape=calloc(TAPE_CELLS,1);
    if(!program||!bracket||!stack||!tape){fprintf(stderr,"out of memory\n");return 2;}
    if(fread(program,1,(size_t)length,source)!=(size_t)length){fprintf(stderr,"short program read\n");return 2;} fclose(source); program[length]='\0';
    for(i=0;i<length;i++) bracket[i]=-1;
    for(i=0;i<length;i++){if(program[i]=='[')stack[depth++]=i;else if(program[i]==']'){long open;if(depth==0){fprintf(stderr,"unmatched ] at %ld\n",i);return 2;}open=stack[--depth];bracket[open]=i;bracket[i]=open;}}
    if(depth){fprintf(stderr,"unmatched [ at %ld\n",stack[depth-1]);return 2;}
    while(ip<length){switch(program[ip]){case '>':if(++cell>=TAPE_CELLS)return 3;break;case '<':if(--cell<0)return 3;break;case '+':++tape[cell];break;case '-':--tape[cell];break;case '.':if(putchar(tape[cell])==EOF)return 3;break;case ',':{int c=getchar();tape[cell]=c==EOF?0:(unsigned char)c;break;}case '[':if(tape[cell]==0)ip=bracket[ip];break;case ']':if(tape[cell]!=0)ip=bracket[ip];break;default:break;}++ip;}
    free(program);free(bracket);free(stack);free(tape);return 0;
}
