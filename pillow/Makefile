all : fuzzer-loadimg

PYTHON_CONFIG_PATH=$(CPYTHON_INSTALL_PATH)/bin/python3-config
CXXFLAGS += $(shell $(PYTHON_CONFIG_PATH) --cflags)
LDFLAGS += -rdynamic $(shell $(PYTHON_CONFIG_PATH) --ldflags --embed)

fuzzer-loadimg:
	clang++ $(CXXFLAGS) $(LIB_FUZZING_ENGINE) -std=c++17 fuzzer.cpp -DPYTHON_HARNESS_PATH="\"loadimg.py\"" -ldl $(LDFLAGS) -o fuzzer-loadimg
