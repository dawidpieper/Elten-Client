#Elten Code
#Copyright (C) 2014-2016 Dawid Pieper
#All rights reserved.

#Open Public License is used to licensing this app!


#==============================================================================
# ** Main
#------------------------------------------------------------------------------
#  After defining each class, actual processing begins here.
#==============================================================================

      begin
$mainthread = Thread::current
$stopmainthread         = false
#main
    # Prepare for transition
  Graphics.freeze
  Graphics.update
  $LOAD_PATH << "."
  # Make scene object (title screen)
  if $toscene != true
    $scene = Scene_Loading.new if $tomain == nil and $updating != true and $downloading != true and $beta_downloading != true
  $scene = Scene_Main.new if $tomain == true
  $scene = Scene_Update.new if $updating == true
  $scene = $scene if $downloading == true
  $scene = Scene_Beta_Downloaded.new if $beta_downloading == true
end
$toscene = false
  # Call main method as long as $scene is effective
  $dialogopened = false
  loop do
  if $scene != nil
    $scene.main
  else
    break
    end
  end
  play("logout")
  speech_wait
  $playlist = [] if $playlist == nil
  if $playlist.size > 0
    $playlistpaused = true
    $playlistbuffer.pause
    if FileTest.exists?("#{$eltendata}\\playlist.eps")
      pls = load_data("#{$eltendata}\\playlist.eps")
      if pls != $playlist
        if simplequestion("Twoja playlista została zmieniona. Zapisać zmiany?") == 1
save_data($playlist,"#{$eltendata}\\playlist.eps")
          end
        end
      else
        if simplequestion("Czy chcesz zapisać swoją playlistę?") == 1
          save_data($playlist,"#{$eltendata}\\playlist.eps")
          end
        end
        else
    if FileTest.exists?("#{$eltendata}\\playlist.eps")
      if simplequestion("Czy chcesz usunąć zapisaną playlistę?") == 1
        File.delete("#{$eltendata}\\playlist.eps")
        end
            end
  end
            delay(1)
  # Fade out
  Graphics.transition(120)
  $exit = true
    exit
rescue Hangup
  Graphics.update
  $toscene = true
  retry
rescue Errno::ENOENT
  # Supplement Errno::ENOENT exception
  # If unable to open file, display message and end
  filename = $!.message.sub("No such file or directory - ", "")
  print("Unable to find file #{filename}.")
  retry
rescue Reset
retry
rescue RuntimeError
  $ruer = 0 if $ruer == nil
  $ruer += 1
  if $ruer <= 10 and $DEBUG != true
    Win32API.new("kernel32","Beep",'ii','i').call(440,100)
    Graphics.update
    retry
  else
    speech("Wystąpił krytyczny błąd. Opis błędu: #{$!.message}")
    speech_wait
    sleep(0.5)
    speech("Program musi zostać zamknięty. Czy chcesz jednak wysłać raport tego błędu do twórców programu?")
    speech_wait
    @sel = SelectLR.new(["Nie","Tak"])
    loop do
      loop_update
      @sel.update
      break if enter
    end
    if @sel.index == 1
      sleep(0.15)
      bug
    end
    speech_wait
        fail
  end
rescue SystemExit
  play("list_focus")
  $toscene = true
  retry if $exit == nil
  rescue Exception
  if $consoleused == true
    print $!.message.to_s + "   |   " + $@.to_s if $DEBUG
    speech("Wystąpił błąd podczas przetwarzania polecenia.")
        speech_wait
    $console_used = false
    $tomain = true
    retry
  elsif $updating != true and $beta_downloading != true and $start != nil
    puts     $!
    puts $@
    speech("Wystąpił krytyczny błąd. Opis błędu: #{$!.message}")
    speech_wait
    sleep(0.5)
    speech("Program musi zostać zamknięty. Czy chcesz jednak wysłać raport tego błędu do twórców programu?")
    speech_wait
    if simplequestion == 1
      sleep(0.15)
      bug
    end
speech("Co chcesz zrobić?")
speech_wait
sel = SelectLR.new(["Restart","Spróbuj ponownie","Uruchom tryb awaryjny","Przerwij działanie aplikacji"])
loop do
  loop_update
  sel.update
  if enter
    break
  end
  end
    case sel.index
    when 0
      $toscene = false
      retry
      when 1
        $toscene = true
        retry
    when 2
      speech("Tryb awaryjny")
      speech_wait
      @sels = ["Wyjście","Zainstaluj program ponownie"]
      @sels += ["Podejmij próbę otwarcia forum","Podejmij próbę otwarcia wiadomości"] if $name != nil and $name != ""
      @sel = SelectLR.new(@sels)
      loop do
        loop_update
        @sel.update
        if enter
          break
        end
      end
      case @sel.index
      when 0
              fail
        when 1
        $scene = Scene_Update.new
        $toscene = true
        retry
        when 2
          $scenes.insert(0,$scene) if $scenes != nil
          $scene = Scene_Forum.new
                    $toscene = true
                    retry
          when 3
            $scenes.insert(0,$scene) if $scenes != nil
            $scene = Scene_Messages.new
            $toscene = true      
            retry
      end
        when 3
    fail if $DEBUG == true
  end
  end
  if $updating == true
    retry
  end
  if $beta_downloading == true
    retry
  end
  if $start == nil
    retry
    end
end

#Copyright (C) 2014-2016 Dawid Pieper