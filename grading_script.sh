#! /bin/bash

fork="v1.2"

check_commit_count() {
  printf "### Total Commits: "
  git rev-list --count HEAD ^$fork | tail -1
  printf "\n"
}

check_commit_ts_diff() {
  printf "### Time between each commit: \n"
  printf "Commit --> Previous Commit \n"
  printf "date hour:minute:second --> date hour:minute:second  min:sec=  minutes:seconds \n\n"
  printf "(ignore time difference in the first listed item after your very first commit - it's wonky)"

  for ix in `git rev-list HEAD ^$fork`; do 
    thists=`git log $ix -n 1 --format=%ct`; 
    prevts=`git log $ix~1 -n 1 --format=%ct 2>/dev/null`; 
    if [ ! -z "$prevts" ] ; then
      thisd=`date -d @$thists +'%d'`
      prevd=`date -d @$prevts +'%d'`
      if (("$thisd" > "$prevd")) ; then
        echo "DIFFERENT DAY"
      else
        delta=$(( $thists - $prevts )); 
        echo `date -d @$thists +'%Y-%m-%d %H:%M:%S'` "-->"  \
            `date -d @$prevts +'%Y-%m-%d %H:%M:%S'` " min:sec= " \
            `date -d @$delta +'%M:%S'`;
      fi;
    fi; 
  done
  printf "\n"
}

check_commit_history() {
  printf "### Commit History:\n"
  git log HEAD ^$fork|grep --line-buffered "Date"
}

check_main_exists() {
  val=$(git branch)
  if [ "$val" == "master" ] ; then
    print "Your default branch should be called main. Instead found master."
  else
    check_commit_count
    check_commit_ts_diff
    check_commit_history
  fi;
}

readme_exists() {
  if [ -f README.md ]; then
    printf " - ✅ Readme present! \n"
    README=./README.md
    HeaderList=("Technologies Used" "Description" "Setup/Installation Requirements" "Known Bugs" "License")
    not_in_readme=""
    for header in "${HeaderList[@]}"
    do
      if ! grep -q "$header" "$README"
      then
        not_in_readme+="$header  "
      fi
    done
      if [ "$not_in_readme" ]; then
        printf " - ❌ These sections are missing from your README (This is an exact match check): $not_in_readme"
      else
        printf " - ✅ README has all required sections based on header title. Please make sure that each section has information and you have removed all placeholder information. (make sure you have a link to your GitHub Pages)"
      fi
  else
    printf " - ❌ No README.md file in the root directory found!"
  fi
  printf "\n"
}

check_ghpages() {
  val=$(git branch -r)
  ghpages="origin/gh-pages"
  if [[ "$val" == *"$ghpages"* ]]; then
    printf " - ✅ gh-pages branch found. Please check the url to make sure it works. Add url to README."
  else
    printf " - ❌ no gh-pages branch found"
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
    sed '/-->$/d' *.html > backup.html
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
  printf "You may need to turn off word wrap (alt-z or View -> Word Wrap) for better readability. \n\n"

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

  printf "\n" >> "$REVIEWOUTPUT"
  run_htmlhint >> "$REVIEWOUTPUT"

  check_main_exists >> "$REVIEWOUTPUT"
  printf "\n" >> "$REVIEWOUTPUT"


