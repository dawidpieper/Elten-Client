#Elten Code
#Copyright (C) 2014-2016 Dawid Pieper
#All rights reserved.

#Open Public License is used to licensing this app!


class Scene_Voice
  def main
    speech("Ustawienia mowy")
    speech_wait
    sel = ["Zmień syntezator","Zmień szybkość syntezatora","Używaj głosu aktywnego czytnika ekranowego lub domyślnego głosu systemu"]
    @sel = Select.new(sel)
    loop do
loop_update
     @sel.update
     update
     if $scene != self
       break
     end
     end
   end
   def update
     if escape
       delay
       speech_stop
       $scene = Scene_Main.new
     end
     if enter
       delay
       case @sel.index
       when 0
       $scene = Scene_Voice_Voice.new(1)
       when 1
         $scene = Scene_Voice_Rate.new
         when 2
           $voice = -1
                           iniw = Win32API.new('kernel32','WritePrivateProfileString','pppp','i')
                iniw.call('Sapi','Voice',-1.to_s,$configdata + "\\sapi.ini")
                speech("Wybrano obsługę czytnika ekranowego.")
       end
       end
     end
  end

class Scene_Voice_Voice
  def initialize(settings=0)
    @settings = settings
    end
    def main
      $selectedvoice = false
      nv = Win32API.new("screenreaderapi", "sapiGetNumVoices", 'v', 'i')
      $numvoice = nv.call() - 1
      $setvoice = Win32API.new("screenreaderapi", "sapiSetVoice", 'i', 'i')
      $setvoice.call(0)
      $voicename = Win32API.new("screenreaderapi", "sapiGetVoiceName", 'i', 'p')
            speech($voicename.call(0))
      $curnum = 0
      loop do
loop_update
    update
    if $scene != self
      break
    end
    end
                  end
    def update
      if Input.trigger?(Input::DOWN)
        speech_stop
        if $curnum + 1 <= $numvoice
          $curnum = $curnum + 1
        else
          $curnum = 0
        end
        $setvoice.call($curnum)
        speech($voicename.call($curnum))
      end
            if Input.trigger?(Input::UP)
        speech_stop
        if $curnum - 1 >= 0
          $curnum = $curnum - 1
        else
          $curnum = $numvoice
        end
        $setvoice.call($curnum)
        speech($voicename.call($curnum))
      end
      if alt
        delay
        menu
        end
      if enter or $selectedvoice == true
                iniw = Win32API.new('kernel32','WritePrivateProfileString','pppp','i')
                iniw.call('Sapi','Voice',$curnum.to_s,$configdata + "\\sapi.ini")
                $voice = $curnum.to_i
                                      mow = utf8("Wybrany głos: ") + $voicename.call($curnum)
        speech(mow)
speech_wait
if @settings == 0
$scene = Scene_Loading.new
else
  $scene = Scene_Voice.new
  end
end
if escape and @settings != 0
  $scene = Scene_Voice.new
  end
      end
          def menu
play("menu_open")
play("menu_background")
sel = ["Wybierz"]
sel.push("Anuluj") if @settings != 0
@menu = SelectLR.new(sel)
loop do
loop_update
@menu.update
if enter
  case @menu.index
  when 0
$selectedvoice = true
break
when 1
  if @settings != 0
    $scene = Scene_Voice.new
    break
    end
end
end
if alt or escape
break
end
end
Audio.bgs_stop
play("menu_close")
Graphics.transition(10)
delay
return
end
end

class Scene_Voice_Rate
  def main
    speech("Wybierz szybkość głosu.")
    speech_wait
    sel = []
    for i in 1..100
      sel.push(i.to_s)
    end
    Graphics.update
    @rate = Win32API.new("screenreaderapi","sapiGetRate",'v','i').call
    @startrate = @rate
    @sel = Select.new(sel)
    @sel.index = @rate - 1
    speech(@rate.to_s)
    loop do
loop_update
      @sel.update
      update
      if $scene != self
        break
        end
      end
    end
    def update
if @rate - 1 != @sel.index
  @rate = @sel.index + 1
  Win32API.new("screenreaderapi","sapiSetRate",'i','i').call(@rate)
  end
      @rate = @sel.index + 1
      if escape
        delay
        @rate = @startrate
        Win32API.new("screenreaderapi","sapiSetRate",'i','i').call(@rate)
        $scene = Scene_Voice.new
      end
      if enter
                     iniw = Win32API.new('kernel32','WritePrivateProfileString','pppp','i')
                iniw.call('Sapi','Rate',@rate.to_s,$configdata + "\\sapi.ini")   
     speech("Zapisano.")
     speech_wait
     $scene = Scene_Voice.new
        end
      end
  end

#Copyright (C) 2014-2016 Dawid Pieper