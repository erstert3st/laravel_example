# Dateien vorher leeren
> pacman.txt
> paru.txt

while read -r pkg; do
  # check if pacman has package available from all_packages.txt
  [[ -z "$pkg" || "$pkg" =~ ^# ]] && continue

  if grep -qxF "$pkg" all_packages.txt; then
    echo "$pkg" >> pacman.txt
  else
    echo "$pkg" >> paru.txt
  fi
done < packages.txt
