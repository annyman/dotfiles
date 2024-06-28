function shut --wraps='sudo runit-init 0' --description 'alias shut=sudo runit-init 0'
  sudo runit-init 0 $argv
        
end
