.PHONY: clean all

CASM 	  ?= customasm
CASMFLAGS ?= -f binstr

OBJS := task1.coe task1.txt

all: $(OBJS)

%.coe: %.txt
	./convert.py < $< > $@

%.txt: %.asm
	$(CASM) $(CASMFLAGS) -o $@ $^

clean:
	rm -f $(OBJS)
