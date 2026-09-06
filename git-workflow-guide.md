# 🚀 The Noob-Friendly Git Workflow Guide

Welcome to Git! This guide will take you through the exact steps needed to safely work on a project with your team without breaking anything. 

---

## 🛠️ Step 1: First-Time Project Setup
You only need to do this step **once** when joining a project.

1. **Clone the project:** Download a copy of the repository from GitHub to your computer.
   ```bash
   git clone <PASTE_REPOSITORY_URL_HERE>
   ```
2. **Move into the project folder:** 
   ```bash
   cd <PROJECT_FOLDER_NAME>
   ```

---

## 🏃‍♂️ Step 2: The Daily Workflow (Do This Every Time)
Follow these steps every single time you start a new task, feature, or bug fix.

### 1. Update your local project
Before you write any new code, grab the latest updates your team has made to ensure you are working on the newest version.
```bash
git switch main
git pull origin main
```

### 2. Create your own workspace (Branching)
**Golden Rule:** Never write code directly on the `main` branch. Create a separate branch for your task.
```bash
git switch -c feature-my-task-name
```
*(Replace `feature-my-task-name` with a short descriptive name for your task, like `feature-login-button` or `fix-footer-typo`)*.

### 3. Write your code and check your status
Go to your code editor and do your work. While working, you can check what files you changed by running:
```bash
git status
```

### 4. Save your progress (Commit)
When you reach a good stopping point, save a snapshot of your changes.
```bash
# 1. Stage ALL changed files to be saved
git add .

# 2. Save the snapshot with a clear description of what you did
git commit -m "Add a short message explaining your changes here"
```

---

## 🌐 Step 3: Sharing Your Code With The Team

### 1. Push your branch to GitHub
Send your local workspace branch up to the remote server (`origin`).
```bash
git push origin feature-my-task-name
```
*(Remember to use your actual branch name instead of `feature-my-task-name`)*.

### 2. Open a Pull Request (PR)
1. Go to your repository web page on **GitHub / GitLab**.
2. Look for a yellow banner at the top that says **"Compare & pull request"** and click it.
3. Write a short description of what you built and click **"Create pull request"**.
4. Ask a teammate to review and approve your code!

### 3. Clean up
Once your Pull Request is approved and merged into `main` on GitHub, switch your local computer back to the main branch and delete your temporary workspace branch:
```bash
git switch main
git pull origin main
git branch -d feature-my-task-name
```

---

## 🚨 Git First-Aid (If you get stuck!)

* **"I messed up a file and want to undo my uncommitted changes!"**
  ```bash
  git restore <file_name>
  ```
* **"I wrote a commit message but made a typo!"**
  ```bash
  git commit --amend -m "Your new correct message"
  ```
* **"I don't know what branch I am currently on!"**
  ```bash
  git branch
  ```
