require './LinuxCPP.so'
require './mainwindow'
l = LinuxCPP.new
MakeWin(l.GetScreenWidth, l.GetScreenHeight, "elten")
l.WriteCfg("./test.ini", "screen", "width", l.GetScreenWidth.to_s)
l.WriteCfg("./test.ini", "screen", "height", l.GetScreenHeight.to_s)
l.WriteCfg("./test.ini", "window", "title", "elten")
l.DelCfgKey("./test.ini", "sect", "string")
