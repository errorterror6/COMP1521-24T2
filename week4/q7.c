struct _coord {
    double x;
    double y;
};
// x = 0
// y = 8

//total_ size = 16


typedef struct _node Node;
struct _node {
    int value;
    Node *next;
};

//value = 0
// *next = 4

//8 total size

struct _enrolment {
    int stu_id;         // e.g. 5012345
    char course[9]:     // e.g. "COMP1521"
    char term[5];       // e.g. "17s2"
    char grade[3];      // e.g. "HD"
    double mark;        // e.g. 87.3
};

//stu_id  0
// course 4
//term    13
//grade    18
//mark      24

//total size: 32

struct _queue {
    0int nitems;     // # items currently in queue
   4 int head;       // index of oldest item added
  8  int tail;       // index of most recent item added
  12  int maxitems;   // size of array
  16  Item *items;    // malloc'd array of Items
};

0
4
8
12
16

//total size: 20