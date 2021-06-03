include ../Makefile.inc

complex:
	$(PREFIX)gnattest -Pcomplex.gpr --tests-root=tests -r $(QUIET)
	$(PREFIX)gprbuild -Pobj/gnattest/harness/test_driver.gpr $(QUIET)
ifeq ($(RUN),true)
	obj/gnattest/harness/test_runner$(EXE)
endif

clean:
	$(PREFIX)gprclean -Pcomplex.gpr -r
	$(RM) -r obj/gnattest

.PHONY: clean complex 