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
    printf " - BEST PART! Stylesheet included in correct place (tidy organized)"
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
      printf " - These properties are missing from the stylesheet: $not_in_sheet"
    else
      printf " - PASS: All rules for floats and box models are included. (Verify that floats/box model work in browser.)"
    fi
  else
    printf " - FAIL: No stylesheet named styles.css included (might be called different name)."
  fi
  printf "\n"
}

check_html_tags() {
  # Strips all comments from html and saves to backup.html. This ensures that html_tags aren't in comments.
  # MAC and LINUX users - use this line only:
  tidy -quiet -asxml -indent -wrap 0 --force-output true --hide-comments 1 *.html > backup.html
  # PC users - use this line only:
  # sed '/-->$/d' *.html > backup.html

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
    printf " - The following HTML tags are missing: $not_included"
  else
    printf " - PASS: All required HTML tags are included."
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
  printf "**Be sure to resolve all warnings in your terminal as well.** \n"
  printf "These warnings are likely html formatting issues such as missing or misplaced tags, or improper indentation. \n"
  printf "Nothing in your terminal means there are no warnings. \n\n"

  printf "#### HTML Errors: \n"
  npx htmlhint "**/*.html" -f compact
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
  
  check_commit_history >> "$REVIEWOUTPUT"
  printf "\n" >> "$REVIEWOUTPUT"

  check_html_tags >> "$REVIEWOUTPUT"
  check_css >> "$REVIEWOUTPUT"
  readme_exists >> "$REVIEWOUTPUT"
  check_ghpages >> "$REVIEWOUTPUT"
  run_htmlhint >> "$REVIEWOUTPUT"


