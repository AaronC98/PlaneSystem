include ../Makefile.inc

additional_tests: harness mixing

harness:
	$(PREFIX)gnattest -Padditional/harness/harness.gpr --harness-dir=harness_only --harness-only $(QUIET)
	$(PREFIX)gprbuild -Padditional/harness/obj/harness_only/test_driver.gpr $(QUIET)
ifeq ($(RUN),true)
	additional/harness/obj/harness_only/test_runner$(EXE)
endif

mixing:
	$(PREFIX)gnattest -Psimple.gpr --additional-tests=additional/harness/harness.gpr \
	--harness-dir=mixing $(QUIET)
	$(PREFIX)gprbuild -Pobj/mixing/test_driver.gpr $(QUIET)
ifeq ($(RUN),true)
	obj/mixing/test_runner$(EXE)
endif

clean:
	$(PREFIX)gprclean -Padditional/harness/harness.gpr -r
	$(PREFIX)gprclean -Psimple.gpr
	$(RM) -r obj/mixing
	$(RM) -r obj/harness_only
	$(RM) -r obj/gnattest

.PHONY: clean harness mixing 