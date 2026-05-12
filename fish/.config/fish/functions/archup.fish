function archup --wraps='yes | paru' --wraps='yes | paru -Syu --noconfirm' --description 'alias archup=yes | paru -Syu --noconfirm'
  yes | paru -Syu --noconfirm $argv
        
end
