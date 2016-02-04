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







extern "C"
void Init_LinuxCPP()
{
Data_Type<LinuxCPP> rb_cLinuxCPP = define_class<LinuxCPP>("LinuxCPP")
.define_constructor(Constructor<LinuxCPP>())
.define_method("GetScreenWidth", &LinuxCPP::GetScreenWidth)
.define_method("GetScreenHeight", &LinuxCPP::GetScreenHeight)














;
}
