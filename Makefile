.PHONY: clean all

CASM 	  ?= customasm
CASMFLAGS ?= -f binstr

OBJS := task1.coe task1.txt original_excel.txt original_excel.coe

all: $(OBJS)

%.coe: %.txt
	./convert.py < $< > $@

%.txt: %.asm
	$(CASM) $(CASMFLAGS) -o $@ $^

clean:
	rm -f $(OBJS)
