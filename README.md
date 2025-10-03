# Crypto-Finder for Wallets and Miners by BestNoob
A script to find crypto wallets and crypto miners on your computer drive.
It search your drive and list up possible locations.

# Features:
✅ Basic PowerShell script

✅ Easy to modify as your need

✅ Fast and simple

# Limitations:
❌ not tested for efficency

❌ no backup of files

❌ no automatations


# Requirements
PowerShell

# Prerequisites
Admin rights could be useful

# Copy the code and save as script
Mark and copy or download the codelines from git.

save the file as .ps1 file and name it how you want 
example: 

- Find-Miners.ps1

# Run the Script
Open a PowerShell window (with admin rights)

Navigate to the directory where you have placed the script.
 - cd C:\Users\Username\Desktop\

Run the script using the following command:
 - .\Find-Miners.ps1 -TargetDrive D:

> [!NOTE]
> ### if the script is not running you may have to execute following line ###
- Set-ExecutionPolicy RemoteSigned -Scope Process
