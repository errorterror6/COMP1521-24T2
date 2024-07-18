////////////////////////////////////////////////////////////////////////
// COMP1521 24T2 --- Assignment 2: `rbuoy', a simple file synchroniser
// <https://cgi.cse.unsw.edu.au/~cs1521/24T2/assignments/ass2/index.html>
//
// Written by YOUR-NAME-HERE (z5555555) on INSERT-DATE-HERE.
// INSERT-DESCRIPTION-OF-PROGAM-HERE
//
// 2023-07-12   v1.0    Team COMP1521 <cs1521 at cse.unsw.edu.au>


#include <assert.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

#include "rbuoy.h"


/// @brief Create a TABI file from an array of pathnames.
/// @param out_pathname A path to where the new TABI file should be created.
/// @param in_pathnames An array of strings containing, in order, the files
//                      that should be placed in the new TABI file.
/// @param num_in_pathnames The length of the `in_pathnames` array. In
///                         subset 5, when this is zero, you should include
///                         everything in the current directory.
void stage_1(char *out_pathname, char *in_pathnames[], size_t num_in_pathnames) {
    // TODO: implement this.

    // Hint: you will need to:
    //   * Open `out_pathname` using fopen, which will be the output TABI file.
    //   * For each pathname in `in_pathnames`:
    //      * Write the length of the pathname as a 2 byte little endian integer
    //      * Write the pathname
    //      * Check the size of the input file, e.g. using stat
    //      * Compute the number of blocks using number_of_blocks_in_file
    //      * Write the number of blocks as a 3 byte little endian integer
    //      * Open the input file, and read in blocks of size BLOCK_SIZE, and
    //         * For each block call hash_black to compute the hash
    //         * Write out that hash as an 8 byte little endian integer
    // Each time you need to write out a little endian integer you should
    // compute each byte using bitwise operations like <<, &, or |
}


/// @brief Create a TBBI file from a TABI file.
/// @param out_pathname A path to where the new TBBI file should be created.
/// @param in_pathname A path to where the existing TABI file is located.
void stage_2(char *out_pathname, char *in_pathname) {
    // TODO: implement this.
}


/// @brief Create a TCBI file from a TBBI file.
/// @param out_pathname A path to where the new TCBI file should be created.
/// @param in_pathname A path to where the existing TBBI file is located.
void stage_3(char *out_pathname, char *in_pathname) {
    // TODO: implement this.
}


/// @brief Apply a TCBI file to the filesystem.
/// @param in_pathname A path to where the existing TCBI file is located.
void stage_4(char *in_pathname) {
    // TODO: implement this.
}
