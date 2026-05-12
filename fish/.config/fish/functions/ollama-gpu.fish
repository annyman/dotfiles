function ollama-gpu --wraps='HSA_OVERRIDE_GFX_VERSION=10.3.0 HIP_VISIBLE_DEVICES=0 ollama serve & disown' --description 'alias ollama-gpu=HSA_OVERRIDE_GFX_VERSION=10.3.0 HIP_VISIBLE_DEVICES=0 ollama serve & disown'
    HSA_OVERRIDE_GFX_VERSION=10.3.0 HIP_VISIBLE_DEVICES=0 ollama serve & disown $argv
end
