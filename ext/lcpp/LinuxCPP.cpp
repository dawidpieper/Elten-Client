#include "LinuxCPP.h"
LinuxCPP::LinuxCPP()
{
}
int LinuxCPP::GetScreenWidth()
{
Display* display;
display = XOpenDisplay(0);
if(display == NULL) return -1;
int w = DisplayWidth(display, DefaultScreen(display));
XCloseDisplay(display);
return w;
}
int LinuxCPP::GetScreenHeight()
{
Display* display;
display = XOpenDisplay(0);
if(display == NULL) return -1;
int h = DisplayHeight(display, DefaultScreen(display));
XCloseDisplay(display);
return h;
}
int LinuxCPP::MakeDir(string directory)
{
mkdir(directory.c_str(), 0777);
return 0;
}
string LinuxCPP::ReadCfgStr(string file, string section, string key)
{
minIni ini(file);
string str = ini.gets(section, key, "aap");
return str;
}
int LinuxCPP::ReadCfgNum(string file, string section, string key)
{
minIni ini(file);
int n = ini.getl(section, key, -1);
return n;
}
int LinuxCPP::GetKey(int key)
{
if(getchar() == key) return 0;
}
int LinuxCPP::WriteCfg(string file, string section, string key, string value)
{
minIni ini(file);
int b = ini.put(section, key, value);
return b;
}
int LinuxCPP::DelCfgKey(string file, string section, string key)
{
minIni ini(file);
int b = ini.del(section, key);
return b;
}



extern "C"
void Init_LinuxCPP()
{
Data_Type<LinuxCPP> rb_cLinuxCPP = define_class<LinuxCPP>("LinuxCPP")
.define_constructor(Constructor<LinuxCPP>())
.define_method("GetScreenWidth", &LinuxCPP::GetScreenWidth)
.define_method("GetScreenHeight", &LinuxCPP::GetScreenHeight)
.define_method("MakeDir", &LinuxCPP::MakeDir, (Arg("directory")))
.define_method("ReadCfgStr", &LinuxCPP::ReadCfgStr, (Arg("file"), Arg("section"), Arg("key")))
.define_method("ReadCfgNum", &LinuxCPP::ReadCfgNum, (Arg("file"), Arg("section"), Arg("key")))
.define_method("WriteCfg", &LinuxCPP::WriteCfg, (Arg("file"), Arg("section"), Arg("key"), Arg("value")))
.define_method("DelCfgKey", &LinuxCPP::DelCfgKey, (Arg("file"), Arg("section"), Arg("key")))
.define_method("GetKey", &LinuxCPP::GetKey, (Arg("key")))











;
}
