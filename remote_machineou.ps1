# Specify the name of the Active Directory domain
$DomainName = "yourdomain.com"

# Specify the name of the OU that contains the machines you want to target
$OUName = "OU=Computers,DC=yourdomain,DC=com"

# Get a list of all machines in the specified OU
$Machines = Get-ADComputer -SearchBase $OUName -Filter *

# Loop through each machine and enable remote PowerShell script execution
foreach ($Machine in $Machines) {
    # Get the name of the machine
    $MachineName = $Machine.Name
    
    # Enable remote PowerShell script execution for the machine
    Invoke-Command -ComputerName $MachineName -ScriptBlock {
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force
    }
}
