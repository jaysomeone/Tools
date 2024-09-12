
# "C:\Users\jluu1\OneDrive\Desktop\accessible_directories.txt"

# Prompt the user for the directory to check
$rootDirectory = Read-Host "Please enter the full path of the directory you want to check (e.g., C:\)"

# Check if the directory exists
if (-Not (Test-Path $rootDirectory)) {
    Write-Host "The specified directory does not exist. Exiting script."
    exit
}

# Prompt the user for the location to save the output file
$outputFile = Read-Host "Please enter the full path of the output file (e.g., C:\accessible_directories.txt)"

# Prompt the user to choose whether to check recursively or not
$recursiveCheck = Read-Host "Do you want to check directories recursively? (y/n)"

# Clear the output file if it already exists
if (Test-Path $outputFile) {
    Clear-Content $outputFile
}

# Function to check directory access
function Test-DirectoryAccess {
    param (
        [string]$directory
    )

    try {
        # Attempt to get the list of items in the directory
        Get-ChildItem -Path $directory -ErrorAction Stop | Out-Null
        return $true
    } catch {
        return $false
    }
}

# Get the list of directories based on recursive choice, including hidden directories (-Force)
if ($recursiveCheck -eq "y") {
    # Get all directories recursively, including hidden ones
    $directories = Get-ChildItem -Path $rootDirectory -Directory -Recurse -Force -ErrorAction SilentlyContinue
} else {
    # Get only the top-level directories, including hidden ones
    $directories = Get-ChildItem -Path $rootDirectory -Directory -Force -ErrorAction SilentlyContinue
}

# Total number of directories
$totalDirs = $directories.Count

# Loop through each directory and test access, with progress reporting
for ($i = 0; $i -lt $totalDirs; $i++) {
    $directory = $directories[$i]
    $path = $directory.FullName

    # Update progress bar
    $percentComplete = [math]::Round(($i / $totalDirs) * 100)
    Write-Progress -Activity "Checking directory access" -Status "$percentComplete% Complete" -PercentComplete $percentComplete -CurrentOperation "Checking $path"

    if (Test-DirectoryAccess -directory $path) {
        # Write the accessible directory path to the output file
        Add-Content -Path $outputFile -Value $path
    }
}

Write-Host "Directory access check completed. Results saved to $outputFile"
