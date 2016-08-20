#Elten Code
#Copyright (C) 2014-2016 Dawid Pieper
#All rights reserved.


#Open Public License is used to licensing this app!

class Scene_Contacts
  def initialize
        ct = srvproc("contacts","name=#{$name}\&token=#{$token}")
        err = ct[0].to_i
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
      $contact = []
      for i in 1..ct.size - 1
        ct[i].delete!("\n")
      end
      Graphics.update
      for i in 1..ct.size - 1
        $contact.push(ct[i]) if ct[i].size > 1
      end
      if $contact.size < 1
        speech("Pusta Lista")
              end
      selt = []
      for i in 0..$contact.size - 1
        selt[i] = $contact[i] + ". " + getstatus($contact[i])
        end
      @sel = Select.new(selt,true,0,"Kontakty",true)
      speech_stop
    end
    def main
                  @sel.focus
      loop do
loop_update
        @sel.update if $contact.size > 0
        update
        if $scene != self
          break
          end
                  end
      end
      def update
        if escape
          $scene = Scene_Main.new
        end
        if alt
                    if $contact.size < 1
          menu_blank
        else
          menu
          end
        end
        if enter and $contact.size > 0
                    usermenu($contact[@sel.index],false)
          end
        end
        def menu_blank
          play("menu_open")
          play("menu_background")
          @menu = SelectLR.new(["Nowy Kontakt","Anuluj"])
          loop do
loop_update
            @menu.update
            if $scene != self
              break
            end
            if alt or escape
                            break
              end
            if enter
              case @menu.index
              when 0
                $scene = Scene_Contacts_Insert.new
                when 1
                  $scene = Scene_Main.new
            end
            end
            end
          play("menu_close")
          Audio.bgs_stop
          Graphics.transition(5)
          return
        end
                def menu
          play("menu_open")
          play("menu_background")
          @menu = SelectLR.new(sel = [$contact[@sel.index],"Nowy Kontakt","Anuluj"])
          loop do
loop_update
            @menu.update
            if $scene != self
              break
            end
            if alt or escape
                            break
              end
            if enter or (Input.trigger?(Input::DOWN) and @menu.index == 0)
              case @menu.index
when 0
if usermenu($contact[@sel.index],true) != "ALT"
@menu = SelectLR.new(sel)
else
break
end
              when 1
                $scene = Scene_Contacts_Insert.new
                when 2
                  $scene = Scene_Main.new
            end
            end
            end
          play("menu_close")
          Audio.bgs_stop
          Graphics.transition(5)
          return
          end
        end
        
        class Scene_Contacts_Insert
          def initialize(user="",scene=nil)
            @user = user
            @scene = scene
          end
          def main
            user = @user
            while user==""
              user = input_text("Podaj nazwę użytkownika, którego chcesz dodać do swoich kontaktów.")
            end
                        ct = srvproc("contacts_mod","name=#{$name}\&token=#{$token}\&searchname=#{user}\&insert=1")
                        err = ct[0].to_i
            case err
            when 0
              speech("Kontakt został dodany.")
              speech_wait
              $scene = @scene
              when -1
                speech("Błąd połączenia się z bazą danych.")
                speech_wait
                $scene = Scene_Main.new
                when -2
                  speech("Klucz sesji wygasł.")
                  speech_wait
                  $scene = Scene_Loading.new
                  when -3
                    speech("Ten użytkownik jest już dodany do twoich kontaktów.")
                    speech_wait
                    $scene = @scene
                    when -5
                      speech("Użytkownik o podanej nazwie nie istnieje.")
                      speech_wait
                      $scene = Scene_Contacts.new
                    end
                    $scene = Scene_Contacts.new if $scene == nil
            end
          end
          
                  class Scene_Contacts_Delete
          def initialize(user="",scene=nil)
            @user = user
            @scene = scene
          end
          def main
            user = @user
            while user==""
              user = input_text("Podaj nazwę użytkownika, którego chcesz usunąć ze swoich kontaktów.")
            end
                        ct = srvproc("contacts_mod","name=#{$name}\&token=#{$token}\&searchname=#{user}\&delete=1")
                        err = ct[0].to_i
            case err
            when 0
              speech("Kontakt został usunięty.")
              speech_wait
              $scene = @scene
              when -1
                speech("Błąd połączenia się z bazą danych.")
                speech_wait
                $scene = Scene_Main.new
                when -2
                  speech("Klucz sesji wygasł.")
                  speech_wait
                  $scene = Scene_Loading.new
                  when -3
                    speech("Ten użytkownik nie jest dodany do twoich kontaktów.")
                    speech_wait
                    $scene = @scene
                    when -5
                      speech("Użytkownik o podanej nazwie nie istnieje.")
                      speech_wait
                      $scene = Scene_Contacts.new
                    end
                    $scene = Scene_Contacts.new if $scene == nil
            end
          end
#Copyright (C) 2014-2016 Dawid Pieper