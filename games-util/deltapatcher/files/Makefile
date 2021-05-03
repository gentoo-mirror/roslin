CXX = $(shell wx-config --cxx)
CXXFLAGS += -I. -I ../include $(shell wx-config --cxxflags)
DEFINES =
PROGRAM = deltapatcher
PREFIX = /usr/local
OBJECTS = DPApp.o \
		  patcher/XDeltaPatch.o \
		  gui/dpgui.o \
		  gui/DeltaPatcherAboutDialog.o \
		  gui/DeltaPatcherDecodePanel.o \
		  gui/DeltaPatcherDropTarget.o \
		  gui/DeltaPatcherEncodePanel.o \
		  gui/DeltaPatcherMainDialog.o \
		  utils/base64.o \

.SUFFIXES: .o .cpp

.cpp.o :
	$(CXX) -c $(CXXFLAGS) $(DEFINES) -o $@ $<

all: $(PROGRAM)

$(PROGRAM): $(OBJECTS)
	$(CXX) -o $@ $(OBJECTS) $(shell wx-config --libs) $(LDFLAGS)

install: $(PROGRAM)
	install -D -m755 $(PROGRAM) $(DESTDIR)/$(PREFIX)/bin/$(PROGRAM)

clean:
	rm -f $(OBJECTS) $(PROGRAM)

