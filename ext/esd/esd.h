#include "rice/Data_Type.hpp"
#include "rice/Constructor.hpp"
#include <string>
#include <speech-dispatcher/libspeechd.h>
using namespace Rice;
using namespace std;
class Esd
{
public:
Esd();
void esd_disconnect(void);
int esd_say(string txt);
int esd_stop();
  int esd_stop_all();
int esd_stop_uid(int uid);
int esd_pause();
int esd_pause_all();
int esd_pause_uid(int uid);
int esd_resume();
int esd_resume_all();
int esd_resume_uid(int uid);
int esd_cancel();
int esd_cancel_all();
int esd_cancel_uid(int uid);
  int esd_set_language(string lng);
int esd_set_punctuation(int type);
int esd_set_rate(int rate);
int esd_get_rate();
int esd_set_pitch(int pitch);
int esd_get_pitch();
int esd_set_volume(int v);
int esd_get_volume();
private:
SPDConnection* connection;
};
