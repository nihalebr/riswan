<#
.Synopsis
Creates a virtual environment for the project in python and runs the server in it.
.Description
Creates a virtual environment for the project. If the virtual environment already exists, it will be used.
The script will then activate the virtual environment and install the requirements.
Finally, the script will start the server. after the server is stopped, the script will deactivate the virtual environment.
.Example
runserver.ps1
Creates a virtual environment for the project in a folder called venv and runs the server in it.
#>

$Folder = "./venv"
$version = "3.11.0" # Replace this with the version you want to check
$Script:Activate = "$Folder/Scripts/activate.ps1"
$Script:Deactivate = "$Folder/Scripts/deactivate.bat"
$python = Get-Command python -ErrorAction SilentlyContinue

write-host "Django Server Starting Script"
write-host "-----------------------------"
write-host "Checking for Python $version or above 🐍"
if ($python) {
    $output = $python.Version.ToString()
    if ($output -ge $version) {
        Write-Host "Python version $version or above is already installed.😎"
    }
    else {
        Write-Host "Python version $version or above is not installed. Please upgrade your Python version.😔"
    }
}
else {
    Write-Host "Python is not installed on this system."
}

try {
    write-host "-----------------------------"
    write-host "Checking for virtual environment 📜"
    if (-not (Test-Path $Folder)) {
        write-host "Creating virtual environment 🛠️"
        python3.exe -m venv $Folder
    }
    write-host "virtual environment : ✅"
    write-host "-----------------------------"
    write-host "Activating virtual environment ✨"
    & $Script:Activate
    write-host "virtual environment active : ✅"
    write-host "-----------------------------"
    write-host "Installing requirements 📦"
    pip install -r requirements.txt
    write-host "requirements installed : ✅"
    write-host "-----------------------------"
    write-host "Starting server 🚀"
    python manage.py runserver
}
catch {
    write-host "-----------------------------"
    write-host "An Exception has occurred 😔"
    Write-Host $_.Exception.Message
}
