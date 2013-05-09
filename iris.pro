# #####################################################################
# Automatically generated by qmake (2.01a) Wed Feb 3 19:10:56 2010
# #####################################################################
TEMPLATE = app
TARGET = 
DEPENDPATH += . \
    include \
    src \
    src/codes \
    src/filters \
    src/processing \
    src/ui \
    src/utils
INCLUDEPATH += . \
    include
#QT += core widgets

# Input
HEADERS += include/coswavelet.h \
    include/database.h \
    include/dilationfilter.h \
    include/eimage.h \
    include/erosionfilter.h \
    include/eutils.h \
    include/filter.h \
    include/gabortoimage.h \
    include/gabortopixel.h \
    include/gaussian.h \
    include/gaussianfilter.h \
    include/imagefilter.h \
    include/iriscode.h \
    include/irisview.h \
    include/mainview.h \
    include/mainwindow.h \
    include/median.h \
    include/preferences.h \
    include/processiris.h \
    include/sinusoidal.h \
    include/sinwavelet.h \
    include/sobelfilter.h \
    include/sobelfilterx.h \
    include/sobelfiltery.h \
    include/uicircle.h \
    include/uielement.h \
    include/uiparabola.h \
    include/matchdialog.h \
    include/uibarchart.h \
    include/histogram.h 
SOURCES += src/main.cpp \
    src/mainwindow.cpp \
    src/codes/iriscode.cpp \
    src/filters/coswavelet.cpp \
    src/filters/dilationfilter.cpp \
    src/filters/erosionfilter.cpp \
    src/filters/filter.cpp \
    src/filters/gaussian.cpp \
    src/filters/gaussianfilter.cpp \
    src/filters/imagefilter.cpp \
    src/filters/median.cpp \
    src/filters/sinusoidal.cpp \
    src/filters/sinwavelet.cpp \
    src/filters/sobelfilter.cpp \
    src/filters/sobelfilterx.cpp \
    src/filters/sobelfiltery.cpp \
    src/processing/eimage.cpp \
    src/processing/gabortoimage.cpp \
    src/processing/gabortopixel.cpp \
    src/processing/processiris.cpp \
    src/processing/histogram.cpp \
    src/ui/irisview.cpp \
    src/ui/mainview.cpp \
    src/ui/preferences.cpp \
    src/ui/uicircle.cpp \
    src/ui/uielement.cpp \
    src/ui/uiparabola.cpp \
    src/utils/database.cpp \
    src/utils/eutils.cpp \
    src/ui/matchdialog.cpp \
    src/ui/uibarchart.cpp
RESOURCES += imgs.qrc
