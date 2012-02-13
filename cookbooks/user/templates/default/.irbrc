require 'irb/completion'
ARGV.concat [ "--readline", "--prompt-mode", "simple" ]
IRB.conf[:HISTORY_FILE] = "/home/joe/.irb-history"
IRB.conf[:SAVE_HISTORY] = 100
# IRB.conf[:LOAD_MODULES] = ['irb/completion', 'irb/ext/save-history']
# IRB.conf[:LOAD_MODULES] = ['irb/completion']
IRB.conf[:PROMPT_MODE] = :SIMPLE


