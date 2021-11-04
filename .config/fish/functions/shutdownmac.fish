function shutdownmac
  # Shuts MacOS down as if requested from the menu options
  # cf. http://apple.stackexchange.com/a/103633
  osascript -e 'tell app "System Events" to shut down'
end
