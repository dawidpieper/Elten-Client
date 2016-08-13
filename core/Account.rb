#Elten Code
#Copyright (C) 2014-2016 Dawid Pieper
#All rights reserved.


#Open Public License is used to licensing this app!

class Scene_Account_Password
  def main
  oldpassword = ""
  password = ""
  repeatpassword = ""
  while oldpassword == ""
    oldpassword = input_text("Podaj stare hasło","password|ACCEPTESCAPE")
  end
  if oldpassword == "\004ESCAPE\004"
    $scene = Scene_Main.new
    return
  end
    while password == ""
    password = input_text("Podaj nowe hasło","password|ACCEPTESCAPE")
  end
  if oldpassword == "\004ESCAPE\004"
    $scene = Scene_Main.new
    return
  end
    while repeatpassword == ""
    repeatpassword = input_text("Powtórz nowe hasło","password|ACCEPTESCAPE")
  end
  if repeatpassword == "\004ESCAPE\004"
    $scene = Scene_Main.new
    return
  end
  if password != repeatpassword
    speech("Pola: Nowe Hasło i Powtórz Nowe Hasło mają różne wartości.")
    speech_wait
    main
  end
    act = srvproc("account_mod","changepassword=1\&name=#{$name}\&token=#{$token}\&oldpassword=#{oldpassword}\&password=#{password}")
    err = act[0].to_i
  case err
  when 0
    speech("Hasło zostało zmienione.")
    speech_wait
    Win32API.new("kernel32","WritePrivateProfileString",'pppp','i').call("Login","AutoLogin","0",$configdata + "\\login.ini")
    $scene = Scene_Loading.new
    when -1
      speech("Błąd połączenia z bazą danych.")
      speech_wait
      $scene = Scene_Main.new
      when -2
        speech("Klucz sesji wygasł.")
        speech_wait
        $scene = Scene_Loading.new
        when -6
          speech("Podano błędne stare hasło.")
          speech_wait
          $scene = Scene_Main.new
  end
  end
end

class Scene_Account_Mail
  def main
  password = ""
  mail = ""
  while password == ""
    password = input_text("Podaj hasło","password|ACCEPTESCAPE")
  end
  if password == "\004ESCAPE\004"
    $scene = Scene_Main.new
    return
  end
    while mail == ""
    mail = input_text("Podaj nowy adres e-mail","ACCEPTESCAPE")
  end
  if mail == "\004ESCAPE\004"
    $scene = Scene_Main.new
    return
  end
    act = srvproc("account_mod","changemail=1\&name=#{$name}\&token=#{$token}\&oldpassword=#{password}\&mail=#{mail}")
    err = act[0].to_i
  case err
  when 0
    speech("Adres e-mail został zmieniony.")
    speech_wait
    $scene = Scene_Main.new
    when -1
      speech("Błąd połączenia z bazą danych.")
      speech_wait
      $scene = Scene_Main.new
      when -2
        speech("Klucz sesji wygasł.")
        speech_wait
        $scene = Scene_Loading.new
        when -6
          speech("Podano błędne stare hasło.")
          speech_wait
          $scene = Scene_Main.new
  end
  end
end

class Scene_Account_VisitingCard
  def main
            vc = srvproc("visitingcard","name=#{$name}\&token=#{$token}\&searchname=#{$name}")
        err = vc[0].to_i
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
      text = ""
      for i in 1..vc.size - 1
        text += vc[i]
      end
      speech("Zmień swoją wizytówkę.")
      speech_wait
      visitingcard = input_text("Twoja wizytówka:","MULTILINE|ACCEPTESCAPE",text)
      if visitingcard == "\004ESCAPE\004" or visitingcard == "\004TAB\004"
        $scene = Scene_Main.new
        return
      end
buf = buffer(visitingcard)
      vc = srvproc("visitingcard_mod","name=#{$name}\&token=#{$token}\&buffer=#{buf}"      )
err = vc[0].to_i
case err
when 0
  speech("Zapisano.")
  speech_wait
  $scene = Scene_Main.new
  when -1
    speech("Błąd połączenia się z bazą danych.")
    speech_wait
    $scene = Scene_Main.new
    when -2
      speech("Klucz sesji wygasł.")
      speech_wait
      $scene = Scene_Loading.new
end
    end
  end
  
  class Scene_Account_Status
    def main
      speech("Zmiana statusu")
      speech_wait
      text = ""
      while text == ""
      text = input_text("Podaj nowy status","ACCEPTESCAPE")
    end
    if text == "\004ESCAPE\004"
      $scene = Scene_Main.new
      return
    end
    ef = setstatus(text)
    if ef != 0
      speech("Błąd!")
    else
      speech("Status został zmieniony.")
    end
    speech_wait
    $scene = Scene_Main.new
    end
    end
#Copyright (C) 2014-2016 Dawid Pieper