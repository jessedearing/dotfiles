storedocument() {
  ocrmypdf "$1" "$HOME/Google Drive/My Drive/Scanned Documents/$1"
  echo -n "Delete original $1?"
  read __resp
  if [[ "$__resp" =~ "^(y|yes)$" ]]; then
    rm "$1"
  fi
}
