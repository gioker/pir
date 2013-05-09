/****************************************************************************
** Meta object code from reading C++ file 'uielement.h'
**
** Created: Thu May 9 13:41:35 2013
**      by: The Qt Meta Object Compiler version 63 (Qt 4.8.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "include/uielement.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'uielement.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_UiElement[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       1,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      19,   11,   10,   10, 0x0a,

       0        // eod
};

static const char qt_meta_stringdata_UiElement[] = {
    "UiElement\0\0newSize\0callToResize(QSize)\0"
};

void UiElement::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        UiElement *_t = static_cast<UiElement *>(_o);
        switch (_id) {
        case 0: _t->callToResize((*reinterpret_cast< QSize(*)>(_a[1]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData UiElement::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject UiElement::staticMetaObject = {
    { &QWidget::staticMetaObject, qt_meta_stringdata_UiElement,
      qt_meta_data_UiElement, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &UiElement::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *UiElement::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *UiElement::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_UiElement))
        return static_cast<void*>(const_cast< UiElement*>(this));
    return QWidget::qt_metacast(_clname);
}

int UiElement::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QWidget::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 1)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 1;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
