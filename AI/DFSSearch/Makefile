HEADERS_PATH := lib/headers
HEADERS := $(HEADERS_PATH)/*.h
IMPLEMENTATIONS := lib/implementations/*.cpp
OBJECTS := objects/*.o
CFLAGS := -std=c++11 -Wall -I$(HEADERS_PATH)

.PHONY: output clean r

output: $(OBJECTS)
	g++ -o $@ $^ 

$(OBJECTS): $(IMPLEMENTATIONS) | $(HEADERS)
	g++ $(CFLAGS) -c $^
	@mv *.o objects

make r: output
	@clear
	./output

clean:
	@rm objects/*.o output