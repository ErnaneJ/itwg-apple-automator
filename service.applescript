on run {input, parameters}
  set selectedText to input as string
set prompt to "Aprimore a escrita, ortografia e formalidade do seguinte do texto a seguir. Seu retorno deve ser SOMENTE o texto ajustado sem conteúdo antes ou depois.\n"
 
  set apiKey to "<YOUR-GEMINI-API-KEY-HERE>"
  set curlCommand to "curl -s 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=" & apiKey & "' -H 'Content-Type: application/json' -X POST -d '{\"contents\": [{\"parts\": [{\"text\": \""& prompt &" "& selectedText & "\"}]}]}' | /opt/homebrew/bin/jq .candidates[0].content.parts[0].text"
  
  set jsonResponse to do shell script curlCommand
  
  set textResponse to do shell script "echo " & quoted form of jsonResponse & " | sed 's/^\\\"//; s/\\\"$//; s/\\\\n/\\n/g'"
  
  set creditMessage to "🛠️ Developed by https://github.com/ErnaneJ"
  set fullMessage to textResponse & return & return & creditMessage
  
  set dialogResponse to display dialog fullMessage buttons {"Copy", "Close"} default button "Close" with title "🤖 Result - Gemini (1.5 flash)"
  
  if button returned of dialogResponse is "Copy" then
    set the clipboard to textResponse
    display notification "Text copied to clipboard" with title "Copy"
  end if
  
  return textResponse
end run
