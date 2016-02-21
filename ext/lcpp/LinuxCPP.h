#include "rice/Data_Type.hpp"
#include "rice/Constructor.hpp"
#include <string>
#include <math.h>
#include <cstdio>
#include <sys/stat.h>
#include <sys/types.h>
using namespace std;
#include "minIni.h"
#include <X11/Xlib.h>
using namespace Rice;
class LinuxCPP
{
public:
LinuxCPP();
int GetScreenWidth();
int GetScreenHeight();
int MakeDir(string directory);
string ReadCfgStr(string file, string section, string key);
int ReadCfgNum(string file, string section, string key);
int GetKey(int key);
int WriteCfg(string file,             string section, string key, string value);
int DelCfgKey(string file, string section, string key);

};
