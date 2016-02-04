#Elten Code
#Copyright (C) 2014-2016 Dawid Pieper
#All rights reserved.

#Open Public License is used to licensing this app!


class Scene_Update_Confirmation
  def main
    speech("Dostępna jest nowa wersja programu. Czy chcesz ją pobrać i zainstalować?")
    speech_wait
        case simplequestion
        when 0
          if $preinitialized != true
          $denyupdate = true
          $scene = Scene_Loading.new
        else
          $scene = Scene_Main.new
          end
          when 1
            $scene = Scene_Update.new
        end
      end
  end

class Scene_Update
  def main
        $updating = true
        speech("Proszę czekać, trwa pobieranie plików")
        if $downloadstarted != true
        $downloadstarted = true
    Graphics.update
  end
  speech_wait
    langtemp = srvproc("languages","name=#{$name}\&token=#{$token}","langtemp")
    err = langtemp[0].to_i
  case err
  when -1
    speech("Błąd połączenia się z bazą danych.")
    speech_wait
    $scene = Scene_Main.new
    return
    when -2
      speech("Klucz sesji wygasł.")
      speech_wait
      $scene = Scene_Loading.new
      return
    end
    langs = []
for i in 1..langtemp.size - 1    
  langtemp[i].delete!("\n")
  langs.push(langtemp[i]) if langtemp[i].size > 0
end
for i in 0..langs.size - 1
  download($url + "lng/" + langs[i].to_s + ".elg",$langdata + "\\" + langs[i].to_s + ".elg")
end
  speech("Aktualizacja zostanie teraz zainstalowana. Program zostanie uruchomiony ponownie.")
  speech_wait
  download($url + "bin/download_elten.exe",$bindata + "\\download_elten.exe")
  run($bindata + "\\download_elten.exe /wait")
  exit!
    end
  end

#Copyright (C) 2014-2016 Dawid Pieper