#Setup for getting folder location
Add-Type -AssemblyName System.Windows.Forms
$FileBrowser = New-Object System.Windows.Forms.FolderBrowserDialog

# Variables
$CommitMessage='auto committed from auto-committing-setup.ps1!'
$FileName='auto-committing-setup.ps1'

## Get user input
# Get GitHub username
$GitHubUsername=Read-Host "Enter GitHub Username"

# Get repo location
Write-Host "Select folder for repo to be put into:"
$null = $FileBrowser.ShowDialog()
$PracticeRepoDir= $FileBrowser.SelectedPath + "\powershell-practice"
Write-Host $PracticeRepoDir

# Clone repo
git clone "https://github.com/$GitHubUsername/powershell-practice.git" $PracticeRepoDir

# Copy script
Copy-Item -Path "$PSCommandPath" $PracticeRepoDir

# Change dir
Set-Location $PracticeRepoDir

# Add new script file to git staging
git add $FileName

# Commit changes
git commit -m $CommitMessage

# push
git push
