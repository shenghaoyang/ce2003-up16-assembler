.PHONY: clean all

CASM 	  ?= customasm
CASMFLAGS ?= -f binstr

OBJS := irom.coe irom.txt

all: $(OBJS)

irom.coe: irom.txt
	./convert.py < $< > $@

irom.txt: up16.asm
	$(CASM) $(CASMFLAGS) -o $@ $^

clean:
	rm -f $(OBJS)
