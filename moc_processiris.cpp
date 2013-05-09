/****************************************************************************
** Meta object code from reading C++ file 'processiris.h'
**
** Created: Thu May 9 13:41:33 2013
**      by: The Qt Meta Object Compiler version 63 (Qt 4.8.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "include/processiris.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'processiris.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_ProcessIris[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       5,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       5,       // signalCount

 // signals: signature, parameters, type, tag, flags
      15,   13,   12,   12, 0x05,
      57,   47,   12,   12, 0x05,
      89,   81,   12,   12, 0x05,
     129,  120,   12,   12, 0x05,
     154,  152,   12,   12, 0x05,

       0        // eod
};

static const char qt_meta_stringdata_ProcessIris[] = {
    "ProcessIris\0\0,\0imageUnwrapped(QImage*,QImage*)\0"
    "histogram\0buildingHistogram(int*)\0"
    "min,max\0initialiseProgressBar(int,int)\0"
    "progress\0updateProgressBar(int)\0x\0"
    "markHistogram(int)\0"
};

void ProcessIris::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        ProcessIris *_t = static_cast<ProcessIris *>(_o);
        switch (_id) {
        case 0: _t->imageUnwrapped((*reinterpret_cast< QImage*(*)>(_a[1])),(*reinterpret_cast< QImage*(*)>(_a[2]))); break;
        case 1: _t->buildingHistogram((*reinterpret_cast< int*(*)>(_a[1]))); break;
        case 2: _t->initialiseProgressBar((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 3: _t->updateProgressBar((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 4: _t->markHistogram((*reinterpret_cast< int(*)>(_a[1]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData ProcessIris::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject ProcessIris::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_ProcessIris,
      qt_meta_data_ProcessIris, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &ProcessIris::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *ProcessIris::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *ProcessIris::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_ProcessIris))
        return static_cast<void*>(const_cast< ProcessIris*>(this));
    return QObject::qt_metacast(_clname);
}

int ProcessIris::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 5)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 5;
    }
    return _id;
}

// SIGNAL 0
void ProcessIris::imageUnwrapped(QImage * _t1, QImage * _t2)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void ProcessIris::buildingHistogram(int * _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void ProcessIris::initialiseProgressBar(int _t1, int _t2)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void ProcessIris::updateProgressBar(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}

// SIGNAL 4
void ProcessIris::markHistogram(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 4, _a);
}
QT_END_MOC_NAMESPACE
