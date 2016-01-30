require("win32api")
def loop_update
sleep(0.001)
end
  def futf8(text)
    mw = Win32API.new("kernel32", "MultiByteToWideChar", "ilpipi", "i")
    wm = Win32API.new("kernel32", "WideCharToMultiByte", "ilpipipp", "i")
    len = mw.call(0, 0, text, -1, nil, 0)
    buf = "\0" * (len*2)
    mw.call(0, 0, text, -1, buf, buf.bytesize/2)
    len = wm.call(65001, 0, buf, -1, nil, 0, nil, nil)
    ret = "\0" * len
    wm.call(65001, 0, buf, -1, ret, ret.bytesize, nil, nil)
    for i in 0..ret.bytesize - 1
      ret[i..i] = "\0" if ret[i] == 0
    end
    ret.delete!("\0")
    return ret
  end

def utf8(text)
  text = "" if text == nil or text == false
ext = "\0" if text == nil
to_char = Win32API.new("kernel32", "MultiByteToWideChar", 'ilpipi', 'i') 
to_byte = Win32API.new("kernel32", "WideCharToMultiByte", 'ilpipipp', 'i')
utf8 = 65001
w = to_char.call(utf8, 0, text.to_s, text.bytesize, nil, 0)
b = "\0" * (w*2)
w = to_char.call(utf8, 0, text.to_s, text.bytesize, b, b.bytesize/2)
w = to_byte.call(0, 0, b, b.bytesize/2, nil, 0, nil, nil)
b2 = "\0" * w
w = to_byte.call(0, 0, b, b.bytesize/2, b2, b2.bytesize, nil, nil)
return(b2)
  end
def download(source,destination)
  $downloadcount = 0 if $downloadcount == nil
  source.sub!("?","?eltc=#{$downloadcount.to_s(36)}\&")
  $downloadcount += 1
    ef = 0
  begin
  ef = Win32API.new("urlmon","URLDownloadToFile",'pppip','i').call(nil,source,destination,0,nil)
rescue Exception
  Graphics.update
  retry
end
  Win32API.new("wininet","DeleteUrlCacheEntry",'p','i').call(source)
  if FileTest.exist?(destination) == false
    writefile(destination,-4)
    end
return ef
    end
def readini(file,group,key,default="\0")
        r = "\0" * 16384
    Win32API.new("kernel32","GetPrivateProfileString",'pppplp','i').call(group,key,default,r,r.bytesize,file)
    r.delete!("\0")
    return r.to_s    
  end

def speech(text,method=1)
  text = text.to_s
    text = text.gsub("\004LINE\004") {"\r\n"}
  $trans1 = [] if $t1 == nil
  $trans2 = [] if $t2 == nil
  if $translation == true
    suc = false
    for i in 0..$trans1.bytesize - 1
      if $trans1[i] == text
        suc = true
        end
      end
      if suc == false
        std = $stdout
    $trans1.push(text)
    $trans2.push(text)
    std.reopen("trans","w")
    std.puts(text + "\003\004\005" + text)
    end
    end
  if text == " " and $password != true
    if $interface_soundthemeactivation != 0
  else
    speech("Spacja")
    end
    return
  end
  if text == "\n"
    return
  end
  if text.bytesize == 1
    if text[0] <= 90 and text[0] >= 65
      end
    end
  if $password == true
    speech_stop
    return
    end
  if text != ""
  text = char_dict(text)
  text = dict(text) if $language != "PL_PL" and $language != nil
  text = text.sub("_"," ")
  text.gsub!("\004NEW\004") {
  ""
  }
polecenie = "sapiSayString"
polecenie = "sayString" if $voice == -1
text_d = text
text_d = utf8(text) if $speech_to_utf == true
$speech_lasttext = text_d
Win32API.new("screenreaderapi",polecenie,'pi','i').call(text_d,method) if $password != true
end
text_d = text if text_d == nil
return text_d
end

def speech_actived
  polecenie = "sapiIsSpeaking"
  if $voice != -1
  if Win32API.new("screenreaderapi",polecenie,'v','i').call() == 0
    return(false)
  else
    return(true)
  end
else
  i = 0
  loop do
    i += 1
   Graphics.update
   Input.update
   key_update
   break if $key[0x11] or i > $speech_lasttext.bytesize * 10
 end
 return false
  end
  end
  
  def speech_stop
    polecenie = "sapiStopSpeech"
    polecenie = "stopSpeech" if $voice == -1
    Win32API.new("screenreaderapi",polecenie,'v','i').call()
    end

def speech_actived
  polecenie = "sapiIsSpeaking"
  if $voice != -1
  if Win32API.new("screenreaderapi",polecenie,'v','i').call() == 0
    return(false)
  else
    return(true)
  end
else
  i = 0
  loop do
    i += 1
   Graphics.update
   Input.update
   key_update
   break if $key[0x11] or i > $speech_lasttext.bytesize * 10
 end
 return false
  end
  end
  
  def speech_stop
    polecenie = "sapiStopSpeech"
    polecenie = "stopSpeech" if $voice == -1
    Win32API.new("screenreaderapi",polecenie,'v','i').call()
    end

def speech_wait
  while speech_actived == true
loop_update
  end
  return
end

def char_dict(text)
  r=""
  case text
  when "."
    r="kropka"
    when ","
      r="przecinek"
      when "/"
        r="ukośnik"
        when ";"
          r="średnik"
          when "'"
            r="apostrof"
            when "["
              r="lewy kwadratowy"\
              when "]"
                r="prawy kwadratowy"
                when "\\"
                  r="bekslesz"
                  when "-"
                    r="minus"
                    when "="
                      r="równe"
                      when "`"
                        r="akcent"
                        when "<"
                          r="mniejsze"
                          when ">"
                            r="większe"
                            when "?"
                              r="pytajnik"
                              when ":"
                                r="dwukropek"
                                when "\""
                                  r="cudzysłów"
                                  when "{"
                                    r="lewa klamra"
                                    when "}"
                                      r="prawa klamra"
                                      when "|"
                                        r="kreska pionowa"
                                        when "_"
                                          r="podkreślnik"
                                          when "+"
                                            r="plus"
                                            when "!"
                                              r="wykrzyknik"
                                              when "@"
                                                r="małpa"
                                                when "#"
                                                  r="krzyżyk"
                                                  when "$"
                                                    r="dolar"
                                                    when "%"
                                                      r="procent"
                                                      when "^"
                                                        r="daszek"
                                                        when "\&"
                                                          r="ampersant"
                                                          when "*"
                                                            r="gwiazdka"
                                                            when "("
                                                              r="lewy nawias"
                                                              when ")"
                                                                r="prawy nawias"
                      end
                      if r==""
                        return(text)
                      else
                        return(r)
                        end
                      end

def dict(text)
  text = "" if text == nil
  if $lang_src != nil and $lang_dst != nil
for i in 3..$lang_src.bytesize - 1
  if $lang_src[i] == text
    r = $lang_dst[i]
    return(r)
    end
  end
end
for i in 3..$lang_dst.bytesize - 1
  suc = false
    $lang_dst[i].gsub("%%") {
  suc = true
  ""
  }
  if suc == true
    dst = $lang_dst[i].gsub("%","")
    src = $lang_src[i].gsub("%","")
  text.sub!(src,dst)
  end
end
text.gsub!("\r\r","  ")
  return(text)
end

class Reset < Exception

end

begin
$speech_to_utf = true
    $appdata = "\0" * 16384
Win32API.new("kernel32","GetEnvironmentVariable",'ppi','i').call("appdata",$appdata,$appdata.bytesize)
for i in 0..$appdata.bytesize - 1
$appdata = $appdata.sub("\0","")
end
$eltendata = $appdata + "\\elten"
$configdata = $eltendata + "\\config"
$bindata = $eltendata + "\\bin"
$langdata = $eltendata + "\\lng"
$language = "\0" * 16
    Win32API.new("kernel32","GetPrivateProfileString",'pppplp','i').call("Language","Language","PL_PL",$language,$language.bytesize,$configdata + "\\language.ini")
    $language.delete!("\0")
          $lang_src = []
      $lang_dst = []
    if $language != "PL_PL"
      $langwords = readlines($langdata + "\\" + $language + ".elg")
                          for i in 0..$langwords.bytesize - 1
        $langwords[i].delete!("\n")
        $langwords[i].gsub!('\r\n',"\r\n")
        s = false
        $lang_src[i] = ""
        $lang_dst[i] = ""
        for j in 0..$langwords[i].bytesize - 1
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
cmd = $*.to_s
cmd.gsub("/wait") do
sleep(3)
end
$url = "https://elten-net.eu/"
Win32API.new("urlmon","URLDownloadToFile",'ppplp','i').call(nil,$url + "redirect","redirect",0,nil)
Win32API.new("wininet","DeleteUrlCacheEntry",'p','i').call($url + "redirect")
    if FileTest.exists?("redirect")
      rdr = IO.readlines("redirect")
      File.delete("redirect") if $DEBUG != true
      if rdr.size > 0
          if rdr[0].bytesize > 0
            $url = rdr[0].delete("\r\n")
            end
        end
      end
loop do
if FileTest.exists?("agent.tmp") == false and $omitinit != true
Win32API.new("user32","MessageBox",'ippi','i').call(0,"Cannot load Elten Agent Temporary File...","Fatal Error",16)
break
else
if $omitinit != true
agenttemp = IO.readlines("agent.tmp")
File.delete("agent.tmp")
$name = agenttemp[0].delete("\r\n")
$token = agenttemp[1].delete("\r\n")
$hwnd = agenttemp[2].delete("\r\n").to_i
$mes = 0
$pst = 0
end
$omitinit = false
loop do
$voice = readini($configdata + "\\sapi.ini","Sapi","Voice","0").to_i
Win32API.new("screenreaderapi","sapiSetVoice",'i','i').call($voice)
$rate = readini($configdata + "\\sapi.ini","Sapi","Rate","50").to_i
Win32API.new("screenreaderapi","sapiSetRate",'i','i').call($rate)
url = $url + "active.php?name=#{$name}\&token=#{$token}"
download(url,"agentacttemp")
File.delete("agentacttemp")
url = $url + "whatsnew.php?name=#{$name}\&token=#{$token}\&get=1"
download(url,"agentwntemp")
wntemp = IO.readlines("agentwntemp")
File.delete("agentwntemp")
if wntemp.size > 1
if wntemp[1].to_i > $mes
speech("Otrzymałeś nową wiadomość.")
end
if wntemp[2].to_i > $pst
speech("W śledzonym wątku pojawił się nowy wpis.")
end
$mes = wntemp[1].to_i
$pst = wntemp[2].to_i
end
sleep(1)
if FileTest.exists?("agent_exit.tmp") or Win32API.new("user32","IsWindow",'i','i').call($hwnd) == 0
File.delete("agent_exit.tmp")
$break = true
break
end
break if FileTest.exists?("agent.tmp")
end
end
if $break == true
break
end
end
rescue LoadError
retry
rescue RuntimeError
retry
end