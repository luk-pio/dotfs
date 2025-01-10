#!/usr/bin/env zsh

if [ -z "$1" ]; then
    echo "Usage: $0 <description>"
    exit 1
fi

gd=$(git diff mainline)

prompt=$(cat << END
<description>
$1
</description>

<git-diff>
$gd
</git-diff>

Given the description and git diff context above write a code review description according to the template below. Follow the guidelines provided. Remain concise and make sure the output follows the template markdown formatting.

<template>
## Title 🪲|🚀|📚|☎️|❓ 🐭|🐯|🐘 (short, clear title)

### Overview
<one sentence overview>

### Changes
- A list of changes made

### Checklist
- ✅ Performed a self-review  
- 🟥 Unit tests  
- 🟥 Integration tests (specify the command you ran to test)  
- 🟥 Documentation (specify any additional documentation)  

### Additional Notes / Reproduction Steps (Optional)
<Add any additional information which you think could be useful>
</template>

Appendix for symbols
- 🪲 Bug
- 🚀 Feature Request
- 📚 Construct Library Gap
-  ☎️ Security Issue 
- ❓ Support Request

- 🐭 Small CR
- 🐯 Medium CR
- 🐘 Large CR

Given the description, re-write it according to the template. Be readable and clear. Correct grammatical mistakes. Use general writing guidelines. Try to remain concise and make sure the output follows the input formatting. 
Be concise, do not use unnecessary qualifiers. Avoid using prepositional phrases. Use the active voice. Use simple words and be specific. Use direct language. 
END
)

escaped=$(printf '%q' "$prompt")

# echo $escaped
q chat "$escaped"
