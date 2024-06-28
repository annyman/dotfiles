function hiber --wraps='systemctl suspend' --description 'alias hiber=systemctl suspend'
  systemctl suspend $argv
        
end
