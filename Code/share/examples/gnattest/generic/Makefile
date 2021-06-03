include ../Makefile.inc

simple:
	$(PREFIX)gnattest -Pgenerics.gpr $(QUIET)
	$(PREFIX)gprbuild -Pobj/gnattest/harness/test_driver.gpr $(QUIET)
ifeq ($(RUN),true)
	obj/gnattest/harness/test_runner$(EXE)
endif

clean:
	$(PREFIX)gprclean -Pgenerics.gpr
	$(RM) -r obj/gnattest/harness
	$(RM) obj/gnattest/tests/instantiations-test_data-tests-sort_integers-test_data-tests.ads
	$(RM) obj/gnattest/tests/instantiations-test_data-tests-sort_integers-test_data.ads
	$(RM) obj/gnattest/tests/instantiations-test_data-tests-sort_integers.ads
	$(RM) obj/gnattest/tests/instantiations-test_data-tests-sort_string_3-test_data-tests.ads
	$(RM) obj/gnattest/tests/instantiations-test_data-tests-sort_string_3-test_data.ads
	$(RM) obj/gnattest/tests/instantiations-test_data-tests-sort_string_3.ads
	$(RM) obj/gnattest/tests/instantiations-test_data-tests.ads
	$(RM) obj/gnattest/tests/instantiations-test_data.ad?
	$(RM) obj/gnattest/tests/sorting_algorithms-test_data-tests.ads
	$(RM) obj/gnattest/tests/sorting_algorithms-test_data.adb
	

.PHONY: clean simple 