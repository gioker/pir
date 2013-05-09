/****************************************************************************
** Meta object code from reading C++ file 'mainview.h'
**
** Created: Thu May 9 13:41:32 2013
**      by: The Qt Meta Object Compiler version 63 (Qt 4.8.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "include/mainview.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'mainview.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_MainView[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
      16,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: signature, parameters, type, tag, flags
      10,    9,    9,    9, 0x05,

 // slots: signature, parameters, type, tag, flags
      24,    9,    9,    9, 0x0a,
      42,   40,    9,    9, 0x0a,
      82,   74,    9,    9, 0x0a,
     103,    9,    9,    9, 0x0a,
     115,    9,    9,    9, 0x0a,
     128,    9,    9,    9, 0x0a,
     140,    9,    9,    9, 0x0a,
     155,    9,    9,    9, 0x0a,
     174,    9,    9,    9, 0x0a,
     198,  192,    9,    9, 0x0a,
     219,    9,    9,    9, 0x0a,
     242,    9,    9,    9, 0x0a,
     273,  268,    9,    9, 0x0a,
     295,  293,    9,    9, 0x0a,
     316,  314,    9,    9, 0x08,

       0        // eod
};

static const char qt_meta_stringdata_MainView[] = {
    "MainView\0\0imageLoaded()\0enableButtons()\0"
    ",\0imageUnwrapped(QImage*,QImage*)\0"
    "newSize\0resizeIrisBox(QSize)\0cleanedUp()\0"
    "pupilFound()\0irisFound()\0irisComplete()\0"
    "autodetectFailed()\0showProgressBar()\0"
    "value\0hideProgressBar(int)\0"
    "on_addButton_clicked()\0on_searchButton_clicked()\0"
    "hist\0plotHistogram(int*)\0x\0"
    "markHistogram(int)\0p\0"
    "connectProcessIris(ProcessIris*)\0"
};

void MainView::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        MainView *_t = static_cast<MainView *>(_o);
        switch (_id) {
        case 0: _t->imageLoaded(); break;
        case 1: _t->enableButtons(); break;
        case 2: _t->imageUnwrapped((*reinterpret_cast< QImage*(*)>(_a[1])),(*reinterpret_cast< QImage*(*)>(_a[2]))); break;
        case 3: _t->resizeIrisBox((*reinterpret_cast< QSize(*)>(_a[1]))); break;
        case 4: _t->cleanedUp(); break;
        case 5: _t->pupilFound(); break;
        case 6: _t->irisFound(); break;
        case 7: _t->irisComplete(); break;
        case 8: _t->autodetectFailed(); break;
        case 9: _t->showProgressBar(); break;
        case 10: _t->hideProgressBar((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 11: _t->on_addButton_clicked(); break;
        case 12: _t->on_searchButton_clicked(); break;
        case 13: _t->plotHistogram((*reinterpret_cast< int*(*)>(_a[1]))); break;
        case 14: _t->markHistogram((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 15: _t->connectProcessIris((*reinterpret_cast< ProcessIris*(*)>(_a[1]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData MainView::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject MainView::staticMetaObject = {
    { &QWidget::staticMetaObject, qt_meta_stringdata_MainView,
      qt_meta_data_MainView, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &MainView::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *MainView::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *MainView::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_MainView))
        return static_cast<void*>(const_cast< MainView*>(this));
    return QWidget::qt_metacast(_clname);
}

int MainView::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QWidget::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 16)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 16;
    }
    return _id;
}

// SIGNAL 0
void MainView::imageLoaded()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}
QT_END_MOC_NAMESPACE
