#include "esd.h"
Esd::Esd()
{
connection = spd_open("elten", "test", NULL, SPD_MODE_THREADED);
}
void Esd::esd_disconnect()
{
spd_close(connection);
}
int Esd::esd_say(string txt)
{
return spd_say(connection, SPD_IMPORTANT, txt.c_str());
}
int Esd::esd_stop()
{
return spd_stop(connection);
}
int Esd::esd_stop_all()
{
return spd_stop_all(connection);
}
int Esd::esd_stop_uid(int uid)
{
return spd_stop_uid(connection, uid);
}
int Esd::esd_pause()
{
return spd_pause(connection);
}
int Esd::esd_pause_all()
{
return spd_pause_all(connection);
}
int Esd::esd_pause_uid(int uid)
{
return spd_pause_uid(connection, uid);
}
int Esd::esd_resume()
{
return spd_resume(connection);
}
int Esd::esd_resume_all()
{
return spd_resume_all(connection);
}
int Esd::esd_resume_uid(int uid)
{
return spd_resume_uid(connection, uid);
}
int Esd::esd_cancel()
{
return spd_cancel(connection);
}
int Esd::esd_cancel_all()
{
return spd_cancel_all(connection);
}
int Esd::esd_cancel_uid(int uid)
{
return spd_cancel_uid(connection, uid);
}
int Esd::esd_set_language(string lng)
{
return spd_set_language(connection, lng.c_str());
}
int Esd::esd_set_punctuation(int type)
{
if(type == 0)
{
return spd_set_punctuation(connection, SPD_PUNCT_NONE);
}
else if(type == 1)
{
return spd_set_punctuation(connection, SPD_PUNCT_SOME);
}
else if(type == 2)
{
return spd_set_punctuation(connection, SPD_PUNCT_ALL);
}
else
{
return -1;
}
}
int Esd::esd_set_rate(int rate)
{
return spd_set_voice_rate(connection, rate);
}
int Esd::esd_get_rate()
{
return spd_get_voice_rate(connection);
}
int Esd::esd_set_pitch(int pitch)
{
return spd_set_voice_pitch(connection, pitch);
}
int Esd::esd_get_pitch()
{
return spd_get_voice_pitch(connection);
}
int Esd::esd_set_volume(int v)
{
return spd_set_volume(connection, v);
}
int Esd::esd_get_volume()
{
return spd_get_volume(connection);
}
extern "C"
void Init_esd()
{
Data_Type<Esd> rb_cEsd = define_class<Esd>("Esd")
.define_constructor(Constructor<Esd>())
.define_method("disconnect", &Esd::esd_disconnect)
.define_method("say", &Esd::esd_say, (Arg("say")))
.define_method("stop", &Esd::esd_stop)
.define_method("stop_all", &Esd::esd_stop_all)
.define_method("stop_uid", &Esd::esd_stop_uid, (Arg("stop_uid")))
.define_method("pause", &Esd::esd_pause)
.define_method("pause_all", &Esd::esd_pause_all)
.define_method("pause_uid", &Esd::esd_pause_uid, (Arg("pause_uid")))
.define_method("resume", &Esd::esd_resume)
.define_method("resume_all", &Esd::esd_resume_all)
.define_method("resume_uid", &Esd::esd_resume_uid, (Arg("resume_uid")))
.define_method("cancel", &Esd::esd_cancel)
.define_method("cancel_all", &Esd::esd_cancel_all)
.define_method("cancel_uid", &Esd::esd_cancel_uid, (Arg("cancel_uid")))
.define_method("set_language", &Esd::esd_set_language, (Arg("set_language")))
.define_method("set_punctuation", &Esd::esd_set_punctuation, (Arg("set_punctuation")))
.define_method("set_rate", &Esd::esd_set_rate, (Arg("set_rate")))
.define_method("get_rate", &Esd::esd_get_rate)
.define_method("set_pitch", &Esd::esd_set_pitch, (Arg("set_pitch")))
.define_method("get_pitch", &Esd::esd_get_pitch)
.define_method("set_volume", &Esd::esd_set_volume, (Arg("set_volume")))
.define_method("get_volume", &Esd::esd_get_volume);
}

/* 2016 Arkadiusz Kozioł*/
