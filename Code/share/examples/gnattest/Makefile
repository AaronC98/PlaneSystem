include Makefile.inc

ALL_TARGETS = simple tagged_rec contracts complex additional_tests generic simple_stubbing

all: $(ALL_TARGETS)

$(ALL_TARGETS):
	make -C $@ $(MAKESILENT) 

clean:
	$(foreach DIR,$(ALL_TARGETS), make -C $(DIR) clean &&) echo end
	
.PHONY: $(ALL_TARGETS) clean
