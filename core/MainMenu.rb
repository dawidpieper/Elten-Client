#Elten Code
#Copyright (C) 2014-2016 Dawid Pieper
#All rights reserved.


#Open Public License is used to licensing this app!

class Scene_MainMenu  
def initialize
    $runprogram = nil
    play("menu_open")
    play("menu_background")
    speech("Menu")
    speech_wait
    Graphics.transition(5)
  end
  def main
        sel = ["Społeczność","Media","Pliki","Programy","Narzędzia","Ustawienia","Pomoc","Wyjście"]
        @sel = SelectLR.new(sel)
    loop do
loop_update
      @sel.update
      if $scene != self
        break
      end
      if enter or (Input.trigger?(Input::DOWN) and @sel.index != 1 and @sel.index != 2)
        index = @sel.index
        case @sel.index
        when 0
          community
          when 1
            $scene = Scene_Media.new
            close
            break
            when 2
            $scene = Scene_Files.new
            close
            break
            when 3
              programs
          when 4
            tools
            when 5
              settings
            when 6
              help
          when 7
            exit
          end
          if $scene == self
            loop_update
@sel = SelectLR.new(sel)
                  @sel.index = index
          speech(sel[@sel.index])
          end
          end
          if escape or alt
close
            end
          end
        end
        def programs
    Graphics.transition(10)
    @sel = SelectLR.new($app)
    loop do
loop_update
      @sel.update
      if $scene != self
        break
      end
      if Input.trigger?(Input::UP) or escape
                return
        end
      if enter
  $runprogram = @sel.index
close
break
          end
          if alt
close
            end
          end
        end
                  def help
    Graphics.transition(10)
    @sel = SelectLR.new(["Lista zmian","Wersja programu","Przeczytaj mnie","Lista skrótów klawiszowych","Zgłoś błąd"])
    loop do
loop_update
      @sel.update
      if $scene != self
        break
      end
      if Input.trigger?(Input::UP) or escape
                return
        end
      if enter
        case @sel.index
        when 0
          $scene = Scene_Changes.new
          close
          break
          when 1
            startmessage = "ELTEN: " + $version.to_s.sub("."," . ")
    startmessage += " BETA #{$beta.to_s}" if $isbeta == 1
    speech(startmessage)
            speech_wait
          close
          break
          when 2
            $scene = Scene_ReadMe.new
            close
            break
            when 3
              $scene = Scene_ShortKeys.new
              close
              break
            when 4
            $scene = Scene_Bug.new
            close
            break
            end
          end
          if alt
close
            end
          end
        end
          def settings
    Graphics.transition(10)
    @sel = SelectLR.new(["Ustawienia interfejsu","Ustawienia głosu","Tematy dźwiękowe","Zarządzanie językami"])
    loop do
loop_update
      @sel.update
      if $scene != self
        break
      end
      if Input.trigger?(Input::UP) or escape
                return
        end
      if enter
        case @sel.index
        when 0
          $scene = Scene_Interface.new
          close
          break
        when 1
          $scene = Scene_Voice.new
          close
          break
          when 2
            $scene = Scene_SoundThemes.new
            close 
            break
            when 3
              $scene = Scene_Languages.new
              close
              break
            end
          end
          if alt
close
            end
          end
        end
  def community
    Graphics.transition(10)
    @sel = SelectLR.new(sel = ["Wiadomości","Blogi","Forum","Moje kontakty","Użytkownicy, którzy dodali mnie do swoich kontaktów","Chat","Kto jest zalogowany?","Lista użytkowników","Co nowego?","Moje uprawnienia","Rada starszych","Moje Konto"])
    loop do
      loop_update
      @sel.update
      if $scene != self
        break
      end
      if Input.trigger?(Input::UP) or escape
                return
        end
      if enter
        case @sel.index
        when 0
          $scene = Scene_Messages.new
          close
          break
          when 1
            $scene = Scene_Blog.new
            close
            break
        when 2
          $scene = Scene_Forum.new
          close
          break
          when 3
            $scene = Scene_Contacts.new
            close
            break
            when 4
              $scene = Scene_Users_AddedMeToContacts.new
              close
              break
            when 5
              $scene = Scene_Chat.new
              close
              break
          when 6
            $scene = Scene_Online.new
            close
            break
            when 7
              $scene = Scene_Users.new
              close
              break
            when 8
              whatsnew
              close
              break
            when 9
              $scene = Scene_MyPermissions.new
              close
              break
              when 10
                $scene = Scene_Admins.new
                close
                break
                when 11
                index = @sel.index
                myaccount
                if $scene == self
               loop_update
                  @sel = SelectLR.new(sel)
                @sel.index = index
                            speech(sel[@sel.index])
                            end
            end
          end
          if Input.trigger?(Input::DOWN) and @sel.index == 11
            index = @sel.index
            myaccount
            @sel = SelectLR.new(sel)
            @sel.index = index
            speech(sel[@sel.index])
                       end
          if alt
close
            end
          end
        end
          def myaccount
    Graphics.transition(10)
    @sel = SelectLR.new(["Zmień Hasło","Zmień adres e-mail","Moja Wizytówka","Zmiana statusu"])
    loop do
loop_update
      @sel.update
      if $scene != self
        break
      end
      if Input.trigger?(Input::UP) or escape
                return
        end
      if enter
        case @sel.index
        when 0
          $scene = Scene_Account_Password.new
          close
          break
        when 1
          $scene = Scene_Account_Mail.new
          close
          break
          when 2
            $scene = Scene_Account_VisitingCard.new
            close
            break
            when 3
              $scene = Scene_Account_Status.new
              close
              break
            end
          end
          if alt
close
            end
          end
        end
                  def tools
    Graphics.transition(10)
    @sel = SelectLR.new(["Generator tematów dźwiękowych","Test prędkości łącza","Aktualizator","Konsola","Kompilator ELTENAPI"])
        loop do
loop_update
      @sel.update
      if $scene != self
        break
      end
      if enter
        case @sel.index
        when 0
  $scene = Scene_SoundThemesGenerator.new
  close
  break
  when 1
   speedtest
   close
   break
  when 2
    versioninfo   
    close
   break
   when 3
     $scene = Scene_Console.new
     close
     break
     when 4
       $scene = Scene_Compiler.new
       close
       break
               end
          end
          if Input.trigger?(Input::UP) or escape
                        return
            end
          if alt
            close
            end
          end
        end  
        def exit
    Graphics.transition(10)
    @sel = SelectLR.new(["Ukryj program w zasobniku systemowym","Wyloguj się","Wyjście","Restart"])
    loop do
loop_update
      @sel.update
      if $scene != self
        break
      end
      if enter
        case @sel.index
        when 0
  $scene = Scene_Tray.new
  close
  break
          when 1
            Win32API.new("kernel32","WritePrivateProfileString",'pppp','i').call("Login","AutoLogin","0",$configdata + "\\login.ini")
                        play("logout")
            $scene = Scene_Loading.new
            close
            break
            when 2
                            $scene = nil
              close
              break
              when 3
                              play("logout")
              Graphics.transition(120)
              $scene = Scene_Loading.new
              close
              break
            end
          end
          if Input.trigger?(Input::UP) or escape
                        return
            end
          if alt
            close
            end
          end
        end
  def close
    play("menu_close")
Audio.bgs_fade(2000)
for i in 1..Graphics.frame_rate * 2
  Graphics.update
  end
    $scene = Scene_Main.new if $scene == self
              if $runprogram != nil
                                            if $appstart[$runprogram] != nil
                $scene = $appstart[$runprogram].new
                              else
                speech("Błąd")
                speech_wait
                                end
                end
    end
  end
#Copyright (C) 2014-2016 Dawid Pieper