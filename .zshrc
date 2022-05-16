for f in $HOME/.local/zshrc/* ; do
  if [[ -x "$f" ]]; then
    source "$f"
  fi
done
