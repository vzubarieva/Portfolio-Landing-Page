#! /bin/bash

# Don't change anything in here! 

check_commit_history() {
  printf "### Commit History:\n"

  printf "#### Total Commits: "
  git rev-list --count main | tail -1
  printf "\n"

  git log | grep --line-buffered "Date"

  
}

readme_exists() {
  if [ ! -f README.md ]; then
    printf "There is no README!"
  else
    printf " - Readme present! (Check that it contains all the things we ask for)"
  fi
  printf "\n"
}

check_ghpages() {
  val=$(git branch -r)
  ghpages="origin/gh-pages"

  if [[ "$val" == *"$ghpages"* ]]; then
    printf " - PASS: There is a gh-pages branch! Great! Please go to the url and check that it works"
  else
    printf "FAIL - no gh-pages yet"
  fi
  printf "\n"
}

check_css() {
  if [ -f css/styles.css ]; then
    printf " - ✅ Stylesheet included in correct place"
    printf "\n"
    styles=( 'float' 'padding' 'margin' 'border' )
    not_in_sheet=""
    for rule in "${styles[@]}"
    do
      if ! grep -q "^\s*[^/]$rule" css/styles.css
      then
        not_in_sheet+="$rule  "
      fi
    done
    if [ "$not_in_sheet" ]; then
      printf " - ❌ These properties are missing from the stylesheet: $not_in_sheet"
    else
      printf " - ✅ Using all requested css properties: floats, padding, margin, border."
    fi
  else
    printf " - ❌ No stylesheet found. Looking for a file named styles.css in the css folder"
  fi
  printf "\n"
}

check_html_tags() {
  if [ "$(uname)" == "Darwin" ] || [ "$(uname)" == "Linux" ]; then
    tidy -quiet -asxml -indent -wrap 0 --force-output true --hide-comments 1 *.html > backup.html
  else
    --hide-comments 1 *.html > backup.html
  fi

  elements=( 'p' 'h[1-6]' 'ul' 'ol' 'li' 'em' 'strong' 'a' 'img' 'div' 'span' )
  not_included=""
  for element in "${elements[@]}"
  do
    if ! grep -q "<$element" backup.html
    then
      not_included+="$element  "
    fi
  done
  if [ "$not_included" ]; then
    printf " - ❌ The following HTML tags are missing: $not_included"
  else
    printf " - ✅ All requested HTML tags are used."
  fi
  rm backup.html
  printf "\n"
}

run_htmlhint() {
  printf "### HTML File Check \n"

  printf "**Description:** htmlhint checks all html files in your project and outputs any errors below. \n"
  printf "Each possible error is printed on a new line. \n"
  printf "You may need to turn off word wrap (alt-z or View -> Word Wrap) for better readability. \n"
  printf "If curious, here is more info on what errors this script checks for. \n\n"

  printf "#### HTML Errors: \n"
  npx htmlhint "**/*.html" -f compact
  printf "If empty then no errors found. \n"
  printf "**Be sure to resolve all warnings in your terminal as well.** \n"
  printf "These warnings are likely html formatting issues such as missing or misplaced tags, or improper indentation. \n"
  printf "Nothing in terminal means no warnings. \n\n"

}

  REVIEWOUTPUT=./review.md
  if [ -f "$REVIEWOUTPUT" ]; then
  rm review.md
  fi

  date=$(date +'%m/%d/%Y')
  time=$(date +'%r')

  printf "$date \n" >> "$REVIEWOUTPUT"
  printf "$time \n\n" >>  "$REVIEWOUTPUT"

  printf "## Intro to Programming - Git, HTML & CSS \n\n" >> "$REVIEWOUTPUT"
  
  printf "### Objectives Check \n" >> "$REVIEWOUTPUT"
  check_html_tags >> "$REVIEWOUTPUT"
  check_css >> "$REVIEWOUTPUT"
  readme_exists >> "$REVIEWOUTPUT"
  check_ghpages >> "$REVIEWOUTPUT"

  run_htmlhint >> "$REVIEWOUTPUT"

  check_commit_history >> "$REVIEWOUTPUT"
  printf "\n" >> "$REVIEWOUTPUT"


