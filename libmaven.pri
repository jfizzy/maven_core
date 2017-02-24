OUTPUT_DIR = $$(OUTPUT_DIR)
isEmpty(OUTPUT_DIR):OUTPUT_DIR=$$PWD/build

INSTALL_LIBDIR = $$(INSTALL_LIBDIR)
unix {
  !mac {
    isEmpty(INSTALL_LIBDIR):INSTALL_LIBDIR=lib
} }

INSTALL_PREFIX=$$(DESTDIR)$$INSTALL_PREFIX
DEFINES += INSTALL_LIBDIR=\\\"$$INSTALL_LIBDIR\\\"

#QMAKE_CXXFLAGS_RELEASE += -O3 -Wall -Wno-sign-conversion -Wno-c+11-extensions -std=c++11 -Wno-sign-compare
#QMAKE_CXXFLAGS_DEBUG   += -g  -Wall -Wno-sign-conversion -Wno-std=c++11 -Wno-sign-compare

QMAKE_CXXFLAGS_RELEASE   += -O3 -std=c++11
QMAKE_CXXFLAGS_DEBUG   += -g -std=c++11
QMAKE_CXXFLAGS_WARN_ON = -Wall -Wno-sign-conversion -Wno-c++11-extensions -Wno-sign-compare



QT += core
CONFIG += silent exceptions std++14
OBJECTS_DIR = tmp
MOC_DIR = tmp
UI_DIR   =  tmp
QMAKE_CC = gcc
QMAKE_CXX = g++

win32-g++:contains(QMAKE_HOST.arch, x86_64):{
    DEFINES -= CDFPARSER
    DEFINES -= ZLIB
    LIBS -= -lz -lcdfread -lnetcdf
}

win32 {
    message("using win32 config")
    DEFINES += MINGW
    DEFINES += WIN32
}

mac {
    message("using mac config")
    DEFINES -= CDFPARSER
    LIBS -= -lcdfread -lnetcdf

    DEFINES += ZLIB
    LIBS += -lz
}

unix {
    message("using unix config")
    DEFINES -= LITTLE_ENDIAN
 #  DEFINES += CDFPARSER
 #  LIBS += -lcdfread -lnetcdf
    DEFINES += ZLIB
 #  LIBS += -lz -lcdfread -lnetcdf
}


TOPLEVELDIR = $$PWD
INCLUDEPATH += $$TOPLEVELDIR

LIBS += -L$$OUTPUT_DIR/lib -L$$OUTPUT_DIR/plugin
