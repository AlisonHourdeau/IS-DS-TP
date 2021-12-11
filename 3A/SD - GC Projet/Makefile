# MAKEFILE GENERIC :

EXENAME = a.out

CC = gcc
CFLAGS  = -Wall
CFLAGS += -D_XOPEN_SOURCE=500
CFLAGS += -g
LDFLAGS = -g

SRC = $(wildcard *.c)
OBJS = $(SRC:.c=.o)
AOUT = $(EXENAME)

all : $(AOUT)


$(EXENAME) : $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $^

%.o : %.c
	$(CC) $(CFLAGS) -o $@ -c $<

%: %.o
	${CC} ${LDFLAGS} -o $@ $^

clean :
	@rm *.o

cleaner : clean
	@rm $(AOUT)
