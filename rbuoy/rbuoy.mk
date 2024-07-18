CFLAGS =

ifneq (, $(shell which dcc))
CC	?= dcc
else
CC	?= clang
CFLAGS += -Wall
endif

EXERCISES	  += rbuoy

SRC = rbuoy.c rbuoy_main.c rbuoy_provided.c
INCLUDES = rbuoy.h

# if you add extra .c files, add them here
SRC +=

# if you add extra .h files, add them here
INCLUDES +=


rbuoy:	$(SRC) $(INCLUDES)
	$(CC) $(CFLAGS) $(SRC) -o $@
