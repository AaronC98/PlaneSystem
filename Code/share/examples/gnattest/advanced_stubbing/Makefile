include ../Makefile.inc

advanced_stubbing:
	$(PREFIX)gnattest -Pops --stub -r $(QUIET)
	make -C obj/gnattest_stub
ifeq ($(RUN),true)
	gnattest obj/gnattest/harness/test_drivers.list
endif

clean:
	$(PREFIX)gprclean -r -Pops
	$(RM) -r obj/gnattest*

.PHONY: clean advanced_stubbing
