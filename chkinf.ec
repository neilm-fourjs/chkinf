
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

$char l_dbname[18] = "stores7";
$char l_user[32] = "";
$char l_username[32] = "training1";
$char l_password[32] = "fourjs";
$integer x;


/*  DWORD dwSize = 50; */

int main( int argc, char *argv[] )
{
	printf("Informix Environment Checker\n");

	printf("\nVariables from CMD Prompt:\n");
	printf("INFORMIXDIR=%s\n",getenv("INFORMIXDIR"));
	printf("INFORMIXSERVER=%s\n",getenv("INFORMIXSERVER"));
	printf("INFORMIXSQLHOSTS=%s\n",getenv("INFORMIXSQLHOSTS"));
	printf("USERDOMAIN=%s\n",getenv("USERDOMAIN"));
	printf("USERNAME=%s\n",getenv("USERNAME"));
	printf("LOGNAME=%s\n",getenv("LOGNAME"));

	if ( argc > 1 ) {
		strcpy(l_dbname,argv[1]);
	}
	if ( argc > 2 ) {
		strcpy(l_username,argv[2]);
	}
	if ( argc > 3 ) {
		strcpy(l_password,argv[3]);
	}

	printf("\nTrying: database %s ...\n", l_dbname);
	/* open database */
	$database $l_dbname;

	if (sqlca.sqlcode != 0) {
		printf("Error %d trying to open %s\n", sqlca.sqlcode,l_dbname);
	} else {
		printf("Opened %s okay.\n", l_dbname);
		$select unique(USER) into $l_user from systables;
		printf("DB User is %s\n", l_user);
	}

	$select count(*) into $x from syscolumns;
	printf("Number records in syscolumns %d\n",x++);

	printf("disconnect\n");
	$disconnect all;

	printf("\nTrying: connect to %s user %s using %s ...\n", l_dbname, l_username, l_password);
	$connect to $l_dbname user $l_username using $l_password;
	if (sqlca.sqlcode != 0) {
		printf("Error %d trying to open %s\n",sqlca.sqlcode,l_dbname);
	} else {
		printf("Opened %s okay.\n",l_dbname);
		$select unique(USER) into $l_user from systables;
		printf("DB User is %s\n", l_user);
	}

	exit(0);
}
