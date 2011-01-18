/**
 * @brief: merge the line of NEWFILE which not in OLDFLIE into the OLDFILE.
 * @author Denny,
 * @date 2010-4-30
 */

#include <iostream>
#include <fstream>
#include <string>
#include <map>
#include <errno.h>
#include <string.h>
#include <assert.h>

#define     OLDFILE "stocks.txt"
#define     NEWFILE "recordstock.txt"
#define     MERGEFILE "stocks.new"

using namespace std;
using std::string;

typedef  map<string, string>StockMap;
// newmap store new info
StockMap newmap;
StockMap oldmap;
//Note: unNeed newaddmap, just for debug
StockMap newaddmap;

int process_stock_old(const char* filename);
int process_stock_new(const char* filename);
int merge_file();

int main()
{
    while (1) {
        assert (!process_stock_old(OLDFILE));
        assert (!process_stock_new(NEWFILE));
        assert (!merge_file());
        newaddmap.clear();
        oldmap.clear();
        newmap.clear();
        //set sleep time by your choose
        sleep( 6);
    }
    return 0;
}

int process_stock_old(const char* filename)
{
    string str1, src;
    std::ifstream ifs( filename );
    if ( ! ifs ) {
        cout << filename << " : " <<strerror(errno) <<endl;
        return -1;
    }
    while ( getline(ifs,src) ) {
        str1.assign(src, 17, 6);
        //get stock id
        oldmap.insert( make_pair(str1, src) );
    }
    cout << "oldmap size = " <<oldmap.size() << endl;
    // no necessary
    ifs.close();
    return 0;
}

int process_stock_new(const char* filename)
{
    string str1, src, oldsrc, newstr, strname;
    std::ifstream ifs( filename );
    if ( ! ifs ) {
        cout << filename << " : " <<strerror(errno) <<endl;
        return -1;
    }
    while ( getline(ifs,src) ) {
        //get stock id
        str1.assign(src, 0, 6);
        map<string,string>::iterator iter = oldmap.find(str1);
        if ( iter != oldmap.end() ) {
            oldsrc = iter->second;
            newmap.insert( make_pair(str1, oldsrc) );
        }
        else
        { //newstr generate
            newstr="type:s(¹ÉÆ±);sno:";
            newstr+=str1;
            newstr+=";sname:";
            //add new stock name
            int pos = src.find_last_of('|');
            strname.assign(src, pos+1, src.size());
            newstr+=strname;
            newmap.insert( make_pair(str1, newstr) );
            newaddmap.insert( make_pair(str1, newstr) );
        }
    }
    cout << "newmap size = " <<newmap.size() << endl;
    // no necessary
    ifs.close();
    return 0;
}
int merge_file()
{
    ofstream fout(MERGEFILE, ios::out);
    if (!fout)
    {
        std::cerr << "Open Out file failed!" <<std::endl;
        return -1;
    }

    map<string, string>::iterator iter;
    for ( iter = newmap.begin(); iter != newmap.end(); ++iter ) {
        //cout << iter->second << endl;
        fout << iter->second << endl;
    }
    cout << "new total size = " << newmap.size() <<endl;

    //system("pause");
    cout << "===========================================" <<endl;
    for ( iter = newaddmap.begin(); iter != newaddmap.end(); ++iter ) {
        cout << iter->second << endl;
        fout << iter->second << endl;
    }
    cout << "new add size =" << newaddmap.size() << endl;
    fout.close();
    return 0;
}
