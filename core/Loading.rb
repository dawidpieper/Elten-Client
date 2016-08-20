#Elten Code
#Copyright (C) 2014-2016 Dawid Pieper
#All rights reserved.


#Open Public License is used to licensing this app!

class Scene_Loading
  def main
    $preinitialized = false
    $eltenlib = "eltenvc"
    begin
    $winver = Win32API.new($eltenlib,"WindowsVersion",'v','i')
  rescue Exception
    $eltenlib = "elten"
    retry
    end
    $scenes = []
    $volume = 100
    $speech_to_utf = true
    $instance = Win32API.new("kernel32","GetModuleHandle",'i','i').call(0)
    $wnd = Win32API.new("user32","FindWindow",'pp','i').call("RGSS Player",nil)
    $cwnd = Win32API.new("user32","GetActiveWindow",'v','i').call
    if $cwnd != $wnd
      $ccwnd = Win32API.new("user32","GetForegroundWindow",'v','i').call
      if $ccwnd == $wnd
        $wnd = $ccwnd
      elsif $cwnd == $wnd
        $wnd = $cwnd
      elsif $ccwnd == $cwnd
        $wnd = $cwnd
        end
      end
      writefile("hwnd",$wnd.to_s)
    $sprite = Sprite.new
    $sprite.bitmap = Bitmap.new("elten.jpg")
    Graphics.freeze
    Graphics.transition(0)
    $name = ""
    $token = ""
    $url = "https://elten-net.eu/"
    $srv = "elten-net.eu"
Graphics.frame_rate = 120
              $appdata = getdirectory(26)
$userprofile = getdirectory(40)
$eltendata = $appdata + "\\elten"
$configdata = $eltendata + "\\config"
$bindata = $eltendata + "\\bin"
$appsdata = $eltendata + "\\apps"
$soundthemesdata = $eltendata + "\\soundthemes"
$langdata = $eltendata + "\\lng"
Win32API.new("kernel32","CreateDirectory",'pp','i').call($eltendata,nil)
Win32API.new("kernel32","CreateDirectory",'pp','i').call($configdata,nil)
Win32API.new("kernel32","CreateDirectory",'pp','i').call($bindata,nil)
Win32API.new("kernel32","CreateDirectory",'pp','i').call($appsdata,nil)
Win32API.new("kernel32","CreateDirectory",'pp','i').call($appsdata + "\\inis",nil)
Win32API.new("kernel32","CreateDirectory",'pp','i').call($soundthemesdata,nil)
Win32API.new("kernel32","CreateDirectory",'pp','i').call($soundthemesdata + "\\inis",nil)
Win32API.new("kernel32","CreateDirectory",'pp','i').call($langdata,nil)
$LOAD_PATH << $appsdata
  $interface_listtype = readini($configdata + "\\interface.ini","Interface","ListType","0").to_i
$interface_keyms = readini($configdata + "\\interface.ini","Interface","KeyUpdateTime","75").to_i
$interface_ackeyms = $interface_keyms * 3
$interface_soundthemeactivation = readini($configdata + "\\interface.ini","Interface","SoundThemeActivation","1").to_i
$interface_typingecho = readini($configdata + "\\interface.ini","Interface","TypingEcho","0").to_i  
$interface_fullscreen = readini($configdata + "\\interface.ini","Interface","FullScreen","0").to_i
$interface_hexspecial = readini($configdata + "\\interface.ini","Interface","HexSpecial","1").to_i
        if download($url + "bin/elten.ini",$bindata + "\\newest.ini") != 0
      File.delete("testtemp") if FileTest.exists?("testtemp")
      $neterror = true
      end
      if $neterror == true
      download($url + "redirect","redirect")
    if FileTest.exist?("redirect")
      $neterror = false
      rdr = IO.readlines("redirect")
      File.delete("redirect") if $DEBUG != true and FileTest.exists?
      ("redirect") if $DEBUG != true
      if rdr.size > 0
          if rdr[0].size > 0
            $url = rdr[0].delete("\r\n")
            end
        end
if download($url + "bin/elten.ini",$bindata + "\\newest.ini") != 0
$neterror = true
end
        end
      end  
      version = "\0" * 16
    Win32API.new("kernel32","GetPrivateProfileString",'pppplp','i').call("Elten","Version","0",version,version.size,".\\elten.ini")
    version.delete!("\0")
    version = version.to_f
            beta = "\0" * 16
    Win32API.new("kernel32","GetPrivateProfileString",'pppplp','i').call("Elten","Beta","0",beta,beta.size,".\\elten.ini")
    beta.delete!("\0")
    beta = beta.to_i
  isbeta = "\0" * 16
    Win32API.new("kernel32","GetPrivateProfileString",'pppplp','i').call("Elten","IsBeta","0",isbeta,isbeta.size,".\\elten.ini")
    isbeta.delete!("\0")
    isbeta = isbeta.to_i
            nversion = "\0" * 16
    Win32API.new("kernel32","GetPrivateProfileString",'pppplp','i').call("Elten","Version","0",nversion,nversion.size,$bindata + "\\newest.ini")
    nversion.delete!("\0")
    nversion = nversion.to_f
            nbeta = "\0" * 16
    Win32API.new("kernel32","GetPrivateProfileString",'pppplp','i').call("Elten","Beta","0",nbeta,nbeta.size,$bindata + "\\newest.ini")
    nbeta.delete!("\0")
    nbeta = nbeta.to_i
    $beta = beta
    $version = version
    $isbeta = isbeta
    $nbeta = nbeta
    $nversion = nversion
        if $showm == nil and $interface_fullscreen == 1
    $showm = Win32API.new 'user32', 'keybd_event', %w(l l l l), ''
$showm.call(18,0,0,0)
$showm.call(13,0,0,0)
$showm.call(13,0,2,0)
$showm.call(18,0,2,0)
    Graphics.update
    end
    speech_stop
    startmessage = "ELTEN: " + $version.to_s.sub("."," . ")
    startmessage += " BETA #{$beta.to_s}" if $isbeta == 1
$voice = 0
            $playlist = []
$playlistindex = 0
$start = Time.now.to_i
                                if $thr1 == nil
              $thr1 = Thread.new do
                begin
                loop do
                  if Win32API.new($eltenlib,"KeyState",'i','i').call(0x11) > 0 and $speech_wait == true
                    speech_stop
                    $speech_wait = false
                    end
                  if Win32API.new($eltenlib,"KeyState",'i','i').call(0x77) > 0
                    time = ""
                    if Win32API.new($eltenlib,"KeyState",'i','i').call(0x10) > 0
time = srvproc("time","dateformat=Y-m-d")
else
  time = srvproc("time","dateformat=H:i:s")
  end
speech(time[0])
end
if Win32API.new($eltenlib,"KeyState",'i','i').call(0x75) > 0 and $volume < 100
  $volume += 5 if $volume < 100
  play("list_focus")
  sleep(0.1)
end
if Win32API.new($eltenlib,"KeyState",'i','i').call(0x74) > 0 and $volume > 1
  $volume -= 5 if $volume > 1
  play("list_focus")
  sleep(0.1)
end
if Win32API.new($eltenlib,"KeyState",'i','i').call(0x72) > 0
  run("bin\\elten_tray.bin")
  Win32API.new("user32","SetFocus",'i','i').call($wnd)
  Win32API.new("user32","ShowWindow",'ii','i').call($wnd,0)
  Graphics.update  
  Graphics.update
  play("login")
  speech("ELTEN")
end
if $name != "" and $name != nil and $token != nil and $token != ""
  if Win32API.new($eltenlib,"KeyState",'i','i').call(0x78) > 0
    if Win32API.new($eltenlib,"KeyState",'i','i').call(0x10) <= 0 and $scene.is_a?(Scene_Contacts) == false
    $scenes.insert(0,Scene_Contacts.new)
      elsif $scene.is_a?(Scene_Online) == false and Win32API.new("user32","GetAsyncKeyState",'i','i').call(0x10) > 0
        $scenes.insert(0,Scene_Online.new)
  end
  sleep(0.1)
  end
        if Win32API.new($eltenlib,"KeyState",'i','i').call(0x79) > 0 and $scene.is_a?(Scene_WhatsNew) == false
    $scenes.insert(0,Scene_WhatsNew.new)
    sleep(0.1)
    end
  end
  sleep(0.1)
end
rescue Exception
  print $!.message
  retry
                end
                  end
              end
        if $thr2 == nil
          $thr2 = Thread.new do
          loop do
            begin
            if $voice != -1
              sleep(0.01)
            Win32API.new("screenreaderapi","nvdaStopSpeech",'v','i').call
            Win32API.new("screenreaderapi","jfwStopSpeech",'v','i').call
            Win32API.new("screenreaderapi","weStopSpeech",'v','i').call
                      end
              rescue Exception
        fail
      end
      end
          end
          end    
          if $thr3 == nil
            $thr3 = Thread.new do
              $playlistlastindex = 0
              position = -1
              loop do
                sleep(0.1)
                if $playlist != nil
              if $playlist.size > 0
                if $playlistindex != nil
if $playlistbuffer == nil
                  volume = 80
                  volume = (volume.to_f / $volume.to_f * 100.0)
                                                                                                                        $playlistbuffer = nil
                                                                            begin
                          $playlistbuffer = AudioFile.new($playlist[$playlistindex])
                        rescue Exception
                          $playlist.delete_at($playlistindex)
                          $playlistindex = 0
                          retry
                        end
                        if $playlistbuffer != nil
                                                                                                                          $playlistbuffer.play
                                                $playlistbuffer.volume = volume
                                              end                                
                                              $playlistlastindex = $playlistindex                                                             
                                              else
                                                                                                                             if $playlistbuffer.position == position
                                                                                                                               if $playlistpaused != true
                                                                                                                                                                                                                                                                   $playlistbuffer = nil 
                                                                 position = -1
                                                                 if $playlistindex == $playlistlastindex
                                                                 $playlistindex += 1
                                              $playlistindex = 0 if $playlistindex >= $playlist.size                                              
                                            end
                                          else
                                            position += 150
                                            end
                                                                                                                                                                                                   elsif position < $playlistbuffer.position
                                                               position = $playlistbuffer.position                                                               
                                                               end
                                                                 end
                             end
              end
              end
            end
                        end
            end
            if $thr4 == nil                              
              $thr4 = Thread.new do
                loop do
                  sc = $scene
                  if $scenes.size > 0
                                        $subthread = Thread.new do
                                          sleep(0.1)
                      $scene = $scenes[0]
                      $scenes.delete_at(0)
                      while $scene != nil
                        $scene.main
                        end
                    end
                                        $stopmainthread = true
                    $subthread.value
                    $stopmainthread = false
$scene = sc
$focus = true if $scene.is_a?(Scene_Main) == false                    
$scene = Scene_Main.new if $scene.is_a?(Scene_Main)
loop_update
                    $mainthread.wakeup
                                        end
                  end
                end
              end
            $voice = "\0" * 16
    Win32API.new("kernel32","GetPrivateProfileString",'pppplp','i').call("Sapi","Voice","-2",$voice,$voice.size,$configdata + "\\sapi.ini")
    $voice.delete!("\0")
    $voice = $voice.to_i
    if $voice == -2
      print("Nie wybrano głosu programu.\r\nPo potwierdzeniu tego komunikatu użyj strzałek góra-duł, aby wybrać głos.")
      $scene = Scene_Voice_Voice.new
      return
    else
      Win32API.new("screenreaderapi","sapiSetVoice",'i','i').call($voice)
              $rate = "\0" * 4
    Win32API.new("kernel32","GetPrivateProfileString",'pppplp','i').call("Sapi","Rate","50",$rate,$rate.size,$configdata + "\\sapi.ini")
    $rate.delete!("\0")
    $rate = $rate.to_i
    Win32API.new("screenreaderapi","sapiSetRate",'i','i').call($rate)
  end
          $soundthemespath = "\0" * 64
    Win32API.new("kernel32","GetPrivateProfileString",'pppplp','i').call("SoundTheme","Path","",$soundthemespath,$soundthemespath.size,$configdata + "\\soundtheme.ini")
    $soundthemespath.delete!("\0")
    if $soundthemespath.size > 0
    $soundthemepath = $soundthemesdata + "\\" + $soundthemespath
  else
    $soundthemepath = "Audio"
    end
                    $language = "\0" * 16
    Win32API.new("kernel32","GetPrivateProfileString",'pppplp','i').call("Language","Language","PL_PL",$language,$language.size,$configdata + "\\language.ini")
    $language.delete!("\0")
          $lang_src = []
      $lang_dst = []
    if $language != "PL_PL"
      $langwords = readlines($langdata + "\\" + $language + ".elg")
                          for i in 0..$langwords.size - 1
        $langwords[i].delete!("\n")
        $langwords[i].gsub!('\r\n',"\r\n")
        s = false
        $lang_src[i] = ""
        $lang_dst[i] = ""
        for j in 0..$langwords[i].size - 1
          if s == false
            if $langwords[i][j..j] != "|" and $langwords[i][j..j] != "\\"
            $lang_src[i] += $langwords[i][j..j]
          else
            s = true
          end
        else
          if $langwords[i][j..j] != "|" and $langwords[i][j..j] != "\\"
            $lang_dst[i] += $langwords[i][j..j]
            end
            end
          end
      end
end
speech(startmessage)
if download($url + "bin/elten.ini",$bindata + "\\newest.ini") != 0
      File.delete("testtemp")
      $neterror = true
      end
      if $neterror == true
      download($url + "redirect","redirect")
    if FileTest.exist?("redirect")
      $neterror = false
      rdr = IO.readlines("redirect")
      File.delete("redirect") if $DEBUG != true
      if rdr.size > 0
          if rdr[0].size > 0
            $url = rdr[0].delete("\r\n")
            end
        end
if download($url + "bin/elten.ini",$bindata + "\\newest.ini") != 0
$neterror = true
end
        end
      end  
loop_update
      $speech_wait = true
        if (nversion > version) and $denyupdate != true
      $scene = Scene_Update_Confirmation.new
      return
    end
    if $neterror = true
      if download($url,"testtemp") == 0
        File.delete("testtemp")
        $neterror = false
      else
        speech("Błąd. Nie mogę połączyć się z serwerem. Upewnij się, że komputer ma dostęp do Internetu i spróbuj jeszcze raz.")
        speech_wait
        $scene = nil
        return
      end
      end
        autologin = "\0" * 16
    Win32API.new("kernel32","GetPrivateProfileString",'pppplp','i').call("Login","AutoLogin","0",autologin,autologin.size,$configdata + "\\login.ini")
    autologin.delete!("\0")
    if autologin.to_i > 0
            $scene = Scene_Login.new
      return
    end
    $cw = Select.new(["Zaloguj Się","Rejestracja","Ustawienia interfejsu","Język / language","Wymuś aktualizację lub reinstalację z serwera","Wyjście"])
    loop do
loop_update
      $cw.update
      update
      if $scene != self
        break
      end
      end
    end
    def update
      if enter
        case $cw.index
        when 0
          $scene = Scene_Login.new
          when 1
            $scene = Scene_Registration.new
            when 2
              $scene = Scene_Interface.new
              when 3
                $scene = Scene_Languages.new
                when 4
                  $scene = Scene_Update.new
              when 5
                $scene = nil
        end
        end
      end
  end
#Copyright (C) 2014-2016 Dawid Pieper