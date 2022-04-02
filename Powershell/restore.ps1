# Author: username-c-is-unavailable;
<# 
  Purpose: Restore lost Active Directory information by creating a specific
		   Organizational Unit, and importing Users from a .csv file.

           Restore lost database information by recreating a database and a table,
           and importing data from a .csv file
#>

################################################################################################################################
################################################################################################################################

### This section deals Active Directory.###


try {
	# Import the ActiveDirectory module to allow the use of AD cmdlets.
	Import-Module ActiveDirectory
	
    # Create a new OU named "finance". Note: The specifications explicitly listed "finance" in lower-case lettering.
	New-ADOrganizationalUnit "finance" -Description "Finance OU" 
	
	# Write out a notification that we have successfully created the Organizational Unit.
	Write-Host "An OU named 'finance' has been successfully created."
	
	# Create new paths to the necessary files by concatenating each filename to the path from which this script is running (by using Powershell automatic variable $PSScriptRoot).
    $financeUsers = Join-Path -Path $PSScriptRoot -ChildPath "\financePersonnel.csv"
	$newClients = Join-Path -Path $PSScriptRoot -ChildPath "\NewClientData.csv"

	# Iterate through each line of the file. 
	$userList = Import-CSV -Path $financeUsers

    # Create new Users from each line of the file and put them directly into the 'finance' OU.
    # Note: "$user" is not a keyword or automatic Powershell variable. It is just a dynamically created variable to hold each line from the file.
	foreach ($user in $userList) {

        New-ADUser -Name ($user.First_Name + " " + $user.Last_Name) -DisplayName ($user.First_Name + " " + $user.Last_Name) -Surname $user.Last_Name -GivenName $user.First_Name -PostalCode $user.PostalCode -OfficePhone $user.OfficePhone -MobilePhone $user.MobilePhone -SamAccountName $user.samAccount -Path "OU=finance,DC=ucertify,DC=com" -Description ("Generated from mass recovery data on:" + " " + $(Get-Date))
	}


################################################################################################################################
################################################################################################################################

### This section deals with database imports.###

# Import a module that we need to interact with databasse from Powershell
Import-Module SQLPS -DisableNameChecking 


# Change to the Database directory.
cd SQLSERVER:\SQL\UCERTIFY1\UCERTIFY3\Databases
Write-Host "Current Directory: " $pwd


# The server name.
$dbInstance = "UCERTIFY1\UCERTIFY3"

# The name of the database to create.
$dbName = "ClientDB"

# Instantiate a new database object, using our database instance and database name.
$db = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Database -Argumentlist $dbInstance, $dbName

# Create the database.
$db.Create()


# Build a SQL statement string that we will use for creating a database table.
$sqlCreateTable = "
Use ClientDB;

CREATE TABLE Client_A_Contacts
(
[first_name] VARCHAR(500),
[last_name] VARCHAR(500),
[city] VARCHAR(500),
[county] VARCHAR(500),
[zip] VARCHAR(50),
[officePhone] VARCHAR(50),
[mobilePhone] VARCHAR(50)
)"

# Execute the SQL statement. This will add the table to the database.
Invoke-SqlCmd -ServerInstance $dbInstance -Query $sqlCreateTable


# Read the User data from the csv file and put it into an object.
$newUserList = Import-CSV -Path $newClients

# Iterate through each line from the file, and take the value of each column.
foreach ($newUser in $newUserList) {
    $firstName = $newUser.first_name
    $lastName = $newUser.last_name
    $city = $newUser.city
    $county = $newUser.county
    $zip = $newUser.zip
    $officePhone = $newUser.officePhone
    $mobilePhone = $newUser.mobilePhone

    # Build a SQL statement string to insert the data into the relevant table. For parameters, use the variables we created above.
    $sqlInsertStatement = "
        Use ClientDB;

        INSERT INTO Client_A_Contacts(first_name,last_name,city,county,zip,officePhone,mobilePhone)
        VALUES('$firstName','$lastName','$city','$county','$zip','$officePhone','$mobilePhone')"
        
        # Execute the Insert statement.
        Invoke-SqlCmd -ServerInstance $dbInstance -Query $sqlInsertStatement
}


}
catch [System.OutOfMemoryException] {
    Write-Host "An OutOfMemoryException has occurred."
}catch
{
	Write-Host "Some error has occurred." $StackTrace
}