require 'inline'
class Esd
inline do |builder|
builder.include '<speech-dispatcher/libspeechd.h>'
builder.c 'SPDConnection* connection;'
builder.c 'SPDConnection* esd_connect()
 {
 connection = spd_open("elten", "test", NULL, SPD_MODE_THREADED);
 return connection;
 }'
builder.c 'void esd_disconnect()
{
spd_close(connection);
}'
builder.c 'int esd_say(string txt)
{
return spd_say(connection, SPD_IMPORTANT, txt.c_str());
}'
builder.c 'int esd_stop()
{
return spd_stop(connection);
}'
builder.c 'int esd_stop_all()
{
return spd_stop_all(connection);
}'
builder.c 'int esd_stop_uid(int uid)
{
return spd_stop_uid(connection, uid);
}'
builder.c 'int esd_pause()
{
return spd_pause(connection);
}'
builder.c 'int esd_pause_all()
{
return spd_pause_all(connection);
}'
builder.c 'int esd_pause_uid(int uid)
{
return spd_pause_uid(connection, uid);
}'
builder.c 'int esd_resume()
{
return spd_resume(connection);
}'
builder.c 'int esd_resume()
{
return spd_resume(connection);
}'
builder.c 'int esd_resume_all()
{
return spd_resume_all(connection);
}'
builder.c 'int esd_resume_uid(int uid)
{
return spd_resume_uid(connection, uid);
}'
builder.c 'int esd_set_language(string lng)
{
return spd_set_language(connection, lng.c_str());
}'
builder.c 'int esd_set_punctuation(SPDPunctuation type)
{
return spd_set_punctuation(connection, type);
}'
builder.c 'int esd_set_rate(int rate)
{
return spd_set_voice_rate(connection, rate);
}'
builder.c 'int esd_get_rate()
{
return spd_get_voice_rate(connection);
}'
builder.c 'int esd_set_pitch(int pitch)
{
return spd_set_voice_pitch(connection, pitch);
}'
builder.c 'int esd_get_pitch()
{
return spd_get_voice_pitch(connection);
}'
builder.c 'int esd_set_volume(int v)
{
return spd_set_volume(connection, v);
}'
builder.c 'int esd_get_volume()
{
return spd_get_volume(connection);
}'
end
end
Esd.new.esd_connect()
