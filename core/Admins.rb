#Elten Code
#Copyright (C) 2014-2016 Dawid Pieper
#All rights reserved.

#Open Public License is used to licensing this app!


class Scene_Admins
  def initialize
        Graphics.transition(10)
    @admins = srvproc("admins","name=#{$name}\&token=#{$token}")
            for i in 0..@admins.size - 1
      @admins[i].delete!("\r")
      @admins[i].delete!("\n")
    end
    Graphics.update
    adm = []
    for i in 1..@admins.size - 1
      adm.push(@admins[i]) if @admins[i].size > 0
    end
    Graphics.update
    selt = []
    for i in 0..adm.size - 1
      selt[i] = adm[i] + "." + " " + getstatus(adm[i])
      end
    @sel = Select.new(selt,true,0,"",true)
    speech_stop
    @adm = adm
    end
    def main
      speech("Rada starszych")
      speech_wait
      delay
      @sel.focus
    loop do
loop_update
      @sel.update
      if escape
        $scene = Scene_Main.new
        break
      end
      if alt
        delay
        menu
        delay
      end
      if enter
        delay
        usermenu(@adm[@sel.index],false)
        end
      break if $scene != self
      end
    end
    def menu
play("menu_open")
play("menu_background")
@menu = SelectLR.new(sel = [@adm[@sel.index],"Odświerz","Anuluj"])
loop do
loop_update
@menu.update
break if $scene != self
if enter
  case @menu.index
  when 0
    if usermenu(@adm[@sel.index],true) != "ALT"
          @menu = SelectLR.new(sel)
        else
          break
        end
        when 1
          @main = true
  when 2
$scene = Scene_Main.new
end
break
end
if Input.trigger?(Input::DOWN) and @menu.index == 0
  delay
  Input.update
  if usermenu(@adm[@sel.index],true) != "ALT"
    @menu = SelectLR.new(sel)
  else
    break
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
if @main == true
  initialize
  main
  end
return
end
end

#Copyright (C) 2014-2016 Dawid Pieper