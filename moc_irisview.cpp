/****************************************************************************
** Meta object code from reading C++ file 'irisview.h'
**
** Created: Thu May 9 13:41:32 2013
**      by: The Qt Meta Object Compiler version 63 (Qt 4.8.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "include/irisview.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'irisview.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_IrisView[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
      10,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
      10,       // signalCount

 // signals: signature, parameters, type, tag, flags
      15,   10,    9,    9, 0x05,
      37,    9,    9,    9, 0x05,
      50,    9,    9,    9, 0x05,
      62,    9,    9,    9, 0x05,
      77,    9,    9,    9, 0x05,
      98,   96,    9,    9, 0x05,
     130,    9,    9,    9, 0x05,
     150,  142,    9,    9, 0x05,
     190,  181,    9,    9, 0x05,
     215,  213,    9,    9, 0x05,

       0        // eod
};

static const char qt_meta_stringdata_IrisView[] = {
    "IrisView\0\0size\0hasBeenResized(QSize)\0"
    "pupilFound()\0irisFound()\0irisComplete()\0"
    "autodetectFailed()\0,\0"
    "imageUnwrapped(QImage*,QImage*)\0"
    "cleanedUp()\0min,max\0initialiseProgressBar(int,int)\0"
    "progress\0updateProgressBar(int)\0p\0"
    "creatingProcessIris(ProcessIris*)\0"
};

void IrisView::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        IrisView *_t = static_cast<IrisView *>(_o);
        switch (_id) {
        case 0: _t->hasBeenResized((*reinterpret_cast< QSize(*)>(_a[1]))); break;
        case 1: _t->pupilFound(); break;
        case 2: _t->irisFound(); break;
        case 3: _t->irisComplete(); break;
        case 4: _t->autodetectFailed(); break;
        case 5: _t->imageUnwrapped((*reinterpret_cast< QImage*(*)>(_a[1])),(*reinterpret_cast< QImage*(*)>(_a[2]))); break;
        case 6: _t->cleanedUp(); break;
        case 7: _t->initialiseProgressBar((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 8: _t->updateProgressBar((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 9: _t->creatingProcessIris((*reinterpret_cast< ProcessIris*(*)>(_a[1]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData IrisView::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject IrisView::staticMetaObject = {
    { &QWidget::staticMetaObject, qt_meta_stringdata_IrisView,
      qt_meta_data_IrisView, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &IrisView::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *IrisView::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *IrisView::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_IrisView))
        return static_cast<void*>(const_cast< IrisView*>(this));
    return QWidget::qt_metacast(_clname);
}

int IrisView::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QWidget::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 10)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 10;
    }
    return _id;
}

// SIGNAL 0
void IrisView::hasBeenResized(QSize _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void IrisView::pupilFound()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}

// SIGNAL 2
void IrisView::irisFound()
{
    QMetaObject::activate(this, &staticMetaObject, 2, 0);
}

// SIGNAL 3
void IrisView::irisComplete()
{
    QMetaObject::activate(this, &staticMetaObject, 3, 0);
}

// SIGNAL 4
void IrisView::autodetectFailed()
{
    QMetaObject::activate(this, &staticMetaObject, 4, 0);
}

// SIGNAL 5
void IrisView::imageUnwrapped(QImage * _t1, QImage * _t2)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 5, _a);
}

// SIGNAL 6
void IrisView::cleanedUp()
{
    QMetaObject::activate(this, &staticMetaObject, 6, 0);
}

// SIGNAL 7
void IrisView::initialiseProgressBar(int _t1, int _t2)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 7, _a);
}

// SIGNAL 8
void IrisView::updateProgressBar(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 8, _a);
}

// SIGNAL 9
void IrisView::creatingProcessIris(ProcessIris * _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 9, _a);
}
QT_END_MOC_NAMESPACE
