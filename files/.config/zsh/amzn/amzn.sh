export PERSONAL_BINDLE_ID=amzn1.bindle.resource.35vyrjejyo4i6yyo3dsz2kcfq
export PERSONAL_AWS_ACCOUNT_ID=590183662907
export TEAM_ID=eurme-ae-ais
export AWS_DEFAULT_REGION=eu-west-1
export CDK_DEFAULT_ACCOUNT=590183662907
export CDK_DEFAULT_REGION=eu-west-2
export dsk=dev-dsk-lpiotrak-1b-4cf1049d.eu-west-1.amazon.com

alias b=brazil
alias bb='brazil-build'
alias bbr='brazil-recursive-cmd'

adir=~/.config/zsh

crm() {
  cr --destination-branch mainline | tee /dev/tty | grep CR- >> "$adir/cr-ids.txt"
}

crmu() {
  cr --destination-branch mainline -r $(tail -n 1 "$adir/cr-ids.txt")
}

crmd() {
  if [ $# -ne 1 ]; then
    echo "Usage: crmd 'summary'"
    return 1
  fi

  local summary=$1

  cp $adir/cr-description.md $adir/cr-description-temp.md && vim $adir/cr-description-temp.md && cr --destination-branch mainline --summary $summary --description "$(cat $adir/cr-description-temp.md)" --new-review | grep CR- >> $adir/cr-ids.txt
}

source /Users/lpiotrak/.brazil_completion/zsh_completion
