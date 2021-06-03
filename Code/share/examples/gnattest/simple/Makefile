include ../Makefile.inc

simple:
	$(PREFIX)gnattest -Psimple.gpr $(QUIET)
	$(PREFIX)gprbuild -Pobj/gnattest/harness/test_driver.gpr $(QUIET)
ifeq ($(RUN),true)
	obj/gnattest/harness/test_runner$(EXE)
endif

clean:
	$(PREFIX)gprclean -Psimple.gpr
	$(RM) -r obj/gnattest

.PHONY: clean simple 