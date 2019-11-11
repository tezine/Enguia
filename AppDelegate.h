#ifndef APPDELEGATE_H
#define APPDELEGATE_H
#include <QObject>

class AppDelegate: public QObject{

public:
    AppDelegate();
    int MyCPPMethod(void *self, void * aParam);

private:

};
#endif
