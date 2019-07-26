
DEFINE l_user VARCHAR(25)
DEFINE l_dbname VARCHAR(25)
DEFINE l_username VARCHAR(25)
DEFINE l_password VARCHAR(25)

MAIN

	DISPLAY "\nGenero Test."

  DISPLAY "\nVariables from CMD Prompt:"
  DISPLAY SFMT("INFORMIXDIR=%1", fgl_getenv("INFORMIXDIR"))
  DISPLAY SFMT("INFORMIXSERVER=%1", fgl_getenv("INFORMIXSERVER"))
  DISPLAY SFMT("INFORMIXSQLHOSTS=%1", fgl_getenv("INFORMIXSQLHOSTS"))
  DISPLAY SFMT("USERDOMAIN=%1", fgl_getenv("USERDOMAIN"))
  DISPLAY SFMT("USERNAME=%1", fgl_getenv("USERNAME"))
  DISPLAY SFMT("LOGNAME=%1", fgl_getenv("LOGNAME"))

	LET l_dbname = ARG_VAL(1)

	DISPLAY SFMT("Trying: DATABASE %1 ...", l_dbname)
	TRY
		DATABASE l_dbname
		SELECT UNIQUE(USER) INTO l_user FROM systables
		DISPLAY SFMT("Opened %1 okay", l_dbname)
		DISPLAY SFMT("DB User is %1", l_user)
	CATCH
		DISPLAY STATUS,":",SQLERRMESSAGE
	END TRY

	DISCONNECT CURRENT
	DISPLAY ""	
	LET l_username = ARG_VAL(2)
	LET l_password = ARG_VAL(3)
	DISPLAY SFMT("Trying: CONNECT TO %1 USER %2 USING %3 ...", l_dbname, l_username, l_password)
	TRY
		CONNECT TO l_dbname USER l_username USING l_password
		SELECT UNIQUE(USER) INTO l_user FROM systables
		DISPLAY SFMT("Opened %1 okay", l_dbname)
		DISPLAY SFMT("DB User is %1", l_user)
	CATCH
		DISPLAY STATUS,":",SQLERRMESSAGE
	END TRY

END MAIN
