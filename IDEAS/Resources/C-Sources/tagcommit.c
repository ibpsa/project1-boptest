/* Functions for getching git sha's and printing them to file.
 *
 * Filip Jorissen, KU Leuven				2018-10-23
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>	

/* Fetch the sha of a library in the folder 'path' and return it in 'res'. */
void getCommit(const char *path, char* res){
  /* Buffers */
  char buffer[250]; 
  char sha[42];
  /* Command to fetch sha */
  sprintf(buffer, "cd %s && git rev-parse HEAD", path); 

  /* Read command result */
  FILE *fp;
  #ifdef __linux__ 
    fp = popen(buffer, "r");
   #elif _WIN32
    fp = _popen(buffer, "r");
  #else
    ModelicaFormatError("Unsupported operating system\n");
  #endif  
  
  if (fp == NULL) {
    ModelicaFormatError("Failed to call git command\n");
  }
  if (fgets(sha, sizeof(sha)-1, fp) == NULL){
  	ModelicaFormatError("Path %s does not exist or git cannot be called\n", path);
  }
  
  #ifdef __linux__ 
    pclose(fp);
  #else
    _pclose(fp);
  #endif    

  /* Return result */
  strcpy(res,sha);
}


/* Fetch sha's for the libraries at locations 'libPaths' and print them to the file 'fileName'. */
void tagCommit(const char *fileName, const char **libNames, const char **libPaths, int nLib, int verbose){ 
	/* Buffers */
	char sha[44];
	char buffer[250]; 

	/* Write header */
	FILE *fOut = fopen(fileName, "w");
	sprintf(buffer, "Library: sha\n---------------------------\n"); 
	if (fputs(buffer, fOut)==EOF){
		ModelicaFormatError("In tagcommit.c: failed to write to file %s.", fileName);
 	}

 	/* Fetch library sha's and print to file */
 	int i;
	for (i = 0; i < nLib; ++i)
	{
		getCommit(libPaths[i], sha);
		sprintf(buffer, "%s: %s\n", libNames[i],sha); 
		if (verbose)
			ModelicaFormatMessage("Library %s has sha %s. Writing to file path %s\n", libNames[i], sha, fileName);
		if (fputs(buffer, fOut)==EOF){
			ModelicaFormatError("In tagcommit.c: failed to write to file %s.", fileName);
 		}
	}
	fclose(fOut);
}
