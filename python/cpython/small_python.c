/*
@author: keefewu
@date: 2019/9/1
@intro: python对象的实现：PyObject PyTypeObject-->(type int str dict) 
	PyIntObject PyStringObject PyDictObject
@refer: 《python源码剖析》之实现small python https://blog.csdn.net/wangyuquanliuli/article/details/8654478
*/
#include<iostream>
#include<string.h>
#include<iterator>
#include<stdlib.h>
#include<stdio.h>
#include<memory>
#include<map>
#include<ctype.h>

using namespace std;
#define PyObject_HEAD							\
	int refCount; \
	struct tagPyTypeObject *type

#define PyObject_HEAD_INIT(typePtr) \
	0,typePtr

typedef struct tagPyObject
{
    PyObject_HEAD;
} PyObject;

typedef void (*PrintFun)(PyObject*object);	// 打印函数 PrintFun
typedef PyObject* (*AddFun)(PyObject* left,PyObject*right);	// 相加函数 AddFun
typedef long (*HashFun)(PyObject* object);	// 哈希函数 HashFun

typedef struct tagPyTypeObject
{
    PyObject_HEAD;
    char* name;
    PrintFun print;		
    AddFun add;
    HashFun hash;
} PyTypeObject;

PyTypeObject PyType_Type =
{
    PyObject_HEAD_INIT(&PyType_Type),
    "type",
    0,
    0,
    0
};


// int type
typedef struct tagIntObject
{
    PyObject_HEAD;
    int value;
} PyIntObject;

static  void int_print(PyObject*object);
static PyObject* int_add(PyObject*left,PyObject* right);
static long int_hash(PyObject* object);

PyTypeObject PyInt_Type =
{
    PyObject_HEAD_INIT(&PyType_Type),
    "int",
    int_print,
    int_add,
    int_hash
};


PyObject* PyInt_Create(int value)
{
    PyIntObject *object = new PyIntObject;
    object->refCount = 1;
    object->type = &PyInt_Type;
    object->value = value;
    return (PyObject*)object;
}

static  void int_print(PyObject*object)
{
    PyIntObject* intObject = (PyIntObject*)object;
    printf("%d\n",intObject->value);
}

static PyObject* int_add(PyObject*left,PyObject* right)
{
    PyIntObject* leftInt = (PyIntObject*)left;
    PyIntObject* rightInt = (PyIntObject*)right;
    PyIntObject* result = (PyIntObject*)PyInt_Create(0);
    if(result == NULL)
    {
        printf("we have no enough memory");
        exit(1);
    }
    else
    {
        result->value = leftInt->value+rightInt->value;
    }
    return (PyObject*)result;
}

static long int_hash(PyObject* object)
{
    return (long)((PyIntObject*)object)->value;
}


// string type
typedef struct tagPyStrObject
{
    PyObject_HEAD;
    int length;
    long hashValue;
    char value[50];
} PyStringObject;
static void string_print(PyObject*object);
static long string_hash(PyObject*object);
static PyObject* string_add(PyObject*left, PyObject*right);
PyTypeObject PyString_Type =
{
    PyObject_HEAD_INIT(&PyType_Type),
    "str",
    string_print,
    string_add,
    string_hash
};
PyObject* PyStr_Create(const char*value)
{
    PyStringObject* object = new PyStringObject;
    object->refCount = 1;
    object->type = &PyString_Type;
    object->length = (value ==NULL? 0: strlen(value));
    object->hashValue = -1;
    memset(object->value,0,50);
    if(value!=NULL)
    {
        strcpy(object->value,value);
    }
    return (PyObject*)object;
}

static void string_print(PyObject*object)
{
    PyStringObject*strObject = (PyStringObject*)object;
    printf("%s\n",strObject->value);
}

static long string_hash(PyObject*object)
{
    PyStringObject* strObject = (PyStringObject*)object;
    register int len;
    register unsigned char* p;
    register long x;

    if(strObject->hashValue!=-1)
        return strObject->hashValue;
    len = strObject->length;
    p = (unsigned char*)strObject->value;
    x = *p<<7;
    while(--len>0)
        x = (1000003*x)^*p++;
    x^=strObject->length;
    if(x==-1)
        x=-2;
    strObject->hashValue = x;
    return x;
}

static PyObject* string_add(PyObject*left, PyObject*right)
{
    PyStringObject*leftStr = (PyStringObject*)left;
    PyStringObject*rightStr = (PyStringObject*)right;
    PyStringObject*result = (PyStringObject*)PyStr_Create(NULL);
    if(result == NULL)
    {
        printf("we have no enough memory");
        exit(1);
    }
    else
    {
        strcpy(result->value,leftStr->value);
        strcat(result->value,rightStr->value);//something in book wrong
    }
    return (PyObject*)result;
}


// dict type
typedef struct tagPyDictObject
{
    PyObject_HEAD;
    map<long,PyObject*>dict;
} PyDictObject;
PyDictObject *m_LocalEnvironment= new PyDictObject;
static void dict_print(PyObject*object);
PyTypeObject PyDict_Type =
{
    PyObject_HEAD_INIT(&PyType_Type),
    "dict",
    dict_print,
    0,
    0
};
PyObject*PyDict_Create()
{
    PyDictObject*object = new PyDictObject;
    object->refCount = 1;
    object->type = &PyDict_Type;
    return (PyObject*)object;
}

PyObject* PyDict_GetItem(PyObject*target,PyObject*key)
{
    long keyHashValue = (key->type)->hash(key);
    map<long,PyObject*>&dict = ((PyDictObject*)target)->dict;
    map<long,PyObject*>::iterator it= dict.find(keyHashValue);
    map<long,PyObject*>::iterator end= dict.end();
    if(it==end)
        return NULL;
    return it->second;

}

int PyDict_SetItem(PyObject*target,PyObject*key,PyObject*value)
{
    long keyHashValue = (key->type)->hash(key);
    PyDictObject* dictObject = (PyDictObject*)target;
    (dictObject->dict)[keyHashValue]=value;
    return 0;
}

static void dict_print(PyObject*object)
{
    PyDictObject*dictObject = (PyDictObject*)object;
    printf("(");
    map<long,PyObject*>::iterator it =(dictObject->dict).begin();
    map<long,PyObject*>::iterator end =(dictObject->dict).end();
    for(; it!=end; ++it)
    {
        printf("%ld: ",it->first);
        PyObject*value=it->second;
        (value->type)->print(value);
        printf(", ");
    }
    printf(")\n");
}


PyObject* GetObjectBySymbol(string &symbol)
{
    PyObject* key = PyStr_Create(symbol.c_str());
    PyObject *value = PyDict_GetItem((PyObject*)m_LocalEnvironment,key);
    if(value == NULL)
    {
        cout<<"[Error]: "<<symbol<<" is not defined!"<<endl;
        return NULL;
    }
    return value;
}
bool IsSourceAllDigit(string source)
{
    bool result =true;
    for(int i=0; i<source.size(); i++)
    {
        result = isdigit(source[i]);
        if(result == false)
            break;
    }
    return result;

}
void ExcuteAdd(string&target,string&source)
{	// 句法分析
    string::size_type pos;
    PyObject* strValue = NULL;
    PyObject* resultValue = NULL;
    if(IsSourceAllDigit(source))
    {
        PyObject* intValue = PyInt_Create(atoi(source.c_str()));
        PyObject* key = PyStr_Create(target.c_str());
        PyDict_SetItem((PyObject*)m_LocalEnvironment,key,intValue);
    }
    else if(source.find("\"") !=string::npos)
    {
        strValue = PyStr_Create(source.substr(1,source.size()-2).c_str());
        PyObject* key = PyStr_Create(target.c_str());
        PyDict_SetItem((PyObject*)m_LocalEnvironment,key,strValue);
    }
    else if((pos = source.find("+"))!=string::npos)
    {
        string left = source.substr(0,pos);
        string right = source.substr(pos+1);
        PyObject*leftObject = GetObjectBySymbol(left);
        PyObject*rightObject = GetObjectBySymbol(right);
        if(leftObject!=NULL&&rightObject!=NULL&&leftObject->type==rightObject->type)
        {
            resultValue = (leftObject->type)->add(leftObject,rightObject);
            PyObject*key = PyStr_Create(target.c_str());
            PyDict_SetItem((PyObject*)m_LocalEnvironment,key,resultValue);
        }
        //(m_LocalEnvironment->type)->print((PyObject*)m_LocalEnvironment);
    }
}
void ExcutePrint(string symbol)
{
    PyObject* object = GetObjectBySymbol(symbol);
    if(object!=NULL)
    {
        PyTypeObject* type = object->type;
        type->print(object);
    }
}
void ExcuteCommand(string&command)
{	// 根据 命令 执行 相应操作： print =
    string::size_type pos = 0;
    if((pos = command.find("print "))!=string::npos)
    {
        ExcutePrint(command.substr(6));
    }
    else if((pos=command.find(" = "))!=string::npos)
    {
        string target = command.substr(0,pos);
        string source = command.substr(pos+3);
        ExcuteAdd(target,source);
    }
}





const char* info = "*********Python Research*********\n";
const char* prompt = ">>>";
string m_Command;
void Excute()
{
    cout<<info;
    cout<<prompt;
    while(getline(cin,m_Command))
    {
        if(m_Command.size()==0)
        {
            cout<<prompt;
            continue;
        }
        else if(m_Command == "exit")
        {
            return;
        }
        else
        {
            ExcuteCommand(m_Command);
        }
        cout<<prompt;
    }
}
int main()
{
    Excute();
    return 0;
}