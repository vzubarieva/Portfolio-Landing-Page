# Epicodus

---

## Code Review: Git, HTML & CSS
updated: March 23rd, 2022 <br>
v1.2

---

### Requirements: 
- Node v12 or higher (check with `node -v` in terminal)
- npm v6 or higher (check with `npm -v` in terminal)

---

### Instructions to get Repo:

1. **fork [this repo](https://github.com/epicodus-lessons/1_code_review)**<br>
how: Click the button named `Fork` in the upper right of the repo. Select your GitHub profile when asked where should the repo be forked to. You now have a forked copy of our repo in your GitHub repositories.

2. **rename the repo now in your GitHub account**<br>
how: In your repo, go to Settings. The option to change the repo's name should be the first option you see under General.

3. **clone your repo to start work on the code review**

---

### Getting Started after Cloning: 

After you clone your repo, you'll have these files already in your project:
- `.gitignore`
- `.htmlhintrc`
- `grading_script.sh`
- `package-lock.json`
- `package.json`

**These files are not a part of your project. Don't edit anything in them.** These files are here to make the grading scripts work so you can get more immediate feedback on your project. We'll learn more about some of them later in the program!

Follow these steps:

1. In your terminal, navigate to the top level directory of the project and type `npm install` (just once, you don't need to repeat this step again). This creates a directory called `node_modules`. You don't need to edit anything in this directory - treat it the same as the files listed above.

2. In the top level directory, create a file called `index.html`. You may choose to have more .html files but you must one .html file called index.

3. In the top level directory, create a directory called `css`. In that css directory, create a file called `styles.css`. You may choose to have more .css files but you must have one .css file called styles.

4. (Optional) Install boostrap if you want.

5. You're ready to start the project prompt! You can find it in [Epicenter](https://epicenter.epicodus.com/). Use the `main` branch for your final project. You can create other branches as needed.

Your project should look like this (not including boostrap):

```bash
├── css
│   └── styles.css
├── node_modules
│   ├── (Don't think about what's in here)
├── grading_script.sh
├── .htmlhintrc
├── index.html
├── package.json
├── package-lock.json
├── README.md

```
Note: After running the steps above, git may track changes in package.json and in package-lock.json. That's okay. Make a git commit as usual. 

---

### Using the Grading Script

To run the grading script: 

1. In your terminal, navigate to the top level directory of your project and type `npm run review`

This will create a file called `review.md`.

You may not understand right now how exactly the command above works but that's okay. What's important now is that it is working for you. We'll actually learn more about npm scripts later. 

### About the review.md doc:

* You can run the script `npm run review` as many times as you like to get updated feedback.

* Every time you run the grading script, the old file is deleted and a new file is created. At the top of the file is a time stamp that shows when the file was created.

Final note: `review.md` and `node_modules` are not being tracked by git. They won't appear in the list of files altered when you make git commits and they won't appear in your remote repo after you push your changes. This is because review.md and node_modules have both been added to `.gitignore`. You may choose to remove review.md from .gitignore if you prefer to have it a part of your final project (we don't really have a strong opinion about this either way) but **do not** remove node_modules from .gitignore. Later in the program we'll talk about why.

---

### Submitting your Project

The code review in [Epicenter](https://epicenter.epicodus.com/) has more instructions on how to submit your project. 

Before you do, please make sure all objectives are passing and there are no errors or warnings. If you're stuck please leave a note on what the issue is for your Teacher when submitting your project. Double check that you are meeting all expectations from the prompt in Epicenter as well.

Be aware that your Teacher may have additional resubmission requirements after review.

---

### Troubleshooting 

Here is a list of possible issues you may run into and how to work around them:

1. *"My terminal says there is some error in `node_modules` folder"*<br>
possible fix: Delete the node_modules folder and run `npm install` again

2. *"When I run `npm run review` I get some kind of error"*<br>
possible fix: Try running the script yourself. In your terminal, the top level directory, type `chmod +x grading_script.sh`, hit enter, then type ` ./grading_script.sh`. This should create a review.md file for you. You can run `./grading_script.sh` as many times as you like for updated feedback.

3. *"I am getting permission issues. My terminal says I do not have permission."*<br>
possible fix: In your terminal, in the top level directory, type `chmod +x grading_script.sh`. If that doesn't work, you can try `chmod u+x grading_script.sh` After that run the grading script as usual.

4. *"There is something going wrong not described here."*<br>
If all else fails, you don't need to use the grading script to complete the project. Do your best. Make sure you are checking your process against the list of objectives outlined in the prompt. Leave a note for your Teacher that you were unable to use the grading scripts.
