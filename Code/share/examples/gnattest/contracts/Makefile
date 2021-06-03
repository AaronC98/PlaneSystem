include ../Makefile.inc

contracts:
	$(PREFIX)gnattest -Pcontracts.gpr $(QUIET)
	$(PREFIX)gprbuild -Pobj/gnattest/harness/test_driver.gpr $(QUIET)
ifeq ($(RUN),true)
	obj/gnattest/harness/test_runner$(EXE)
endif

clean:
	$(PREFIX)gprclean -Pcontracts.gpr
	$(RM) -r obj/gnattest

.PHONY: clean contracts