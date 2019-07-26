
DB=njm_demo310
INFCSDK=/opt/inf_csdk450fc1
INFORMIXDIR=/opt/informix1410
USER=training1
PASS=fourjs
FGLSQLDEBUG=0

INFORMIXC=gcc -m64
PATH+=$(INFCSDK)/bin:/bin:/usr/bin
LD_LIBRARY_PATH=$(INFCSDK)/lib:$(INFCSDK)/lib/esql

all : chkinf chkinf.42m

chkinf : chkinf.ec
	INFORMIXDIR=$(INFCSDK); esql $(ESQL_FLAGS) -o $@ chkinf.ec $(ESQL_C_FLAGS) $(ESQL_L_FLAGS)

clean :
	rm chkinf chkinf.c *.42?

chkinf.42m: chkinf.4gl
	fglcomp chkinf.4gl

run : chkinf chkinf.42m
	./chkinf $(DB) $(USER) $(PASS)
	fglrun chkinf.42m $(DB) $(USER) $(PASS)
