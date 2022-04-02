# Author: username-c-is-unavailable;

<# 
  Purpose: Present the user with prompt options, and execute a task based on the input.
           This scrpt will continue to run until halted by the user.
           See the prompts below for descriptions of the tasks that can be run.
#>

try {
    # Infinite loop. Will only be broken by choosing the exit option or manually halting the script.
    while ($true) {
    
    # Prompt the user with all available options, accept their input, and assign it to the $userInput variable.
    $userInput = Read-Host "Press any number (1-5) to continue. Please see the available options below:`n
    1 - Append the name of all '.log' files within the current script's directory into a file called 'DailyLog.txt'.`n 
    2 - Find the name of all files within the current script's directory and print them (in a tabular format and in ascending alphabetical order) to a file called 'C916contents.txt'.`n
    3 - List the CPU% Processor Time and Physical Memory Usage. Will list 4 captures, in 5 second intervals.`n
    4 - List running proceses in grid format and in descending order based on processor time.`n
    5 - Exit the program.`n
    Please choose an option"

        # A switch statement that will take action based on the value of the $userInput variable
        switch($userInput){

           # Case 1
           1 { 
                # Clear the screen.
                Clear-Host

                # Create a new path by concatenating a filename to the path from which this script is running (by using Powershell automatic variable $PSScriptRoot).
                $filePath = Join-Path -Path $PSScriptRoot -ChildPath "\DailyLog.txt"

                # Write the current date to our newly created file.
                Get-Date | Out-File -Append $filePath
            
                # Get the contents of the current script directory, filter the results by matching only the files that end in ".log", and write results to our file.
                # Note: File will be created if it doesn't exist, and new data will be appended if the file already exists. It will not overwrite the existing file.
                Get-ChildItem -Recurse -Path $PSScriptRoot | Where-Object { $_.Name -match '.log$' } | Out-File -Append $filePath

                # Append a line to the file to visually separate different entries.

                "-----------------------------------------------------------------------------" | Out-File -Append $filePath

                # Inform the user that the file was written.
                Write-Host "`n" "`n" "Results written to: " $filePath "`n"

             }

           # Case 2     
           2 { 
                # Clear the screen.
                Clear-Host

                # Create a new path by concatenating a filename to the path from which this script is running (by using Powershell automatic variable $PSScriptRoot).
                $filePath = Join-Path -Path $PSScriptRoot -ChildPath "\C916contents.txt"

                # Get the contents of the current script directory, sort the output by filename (ascendng by default) and output the results to our newly-created file.
                # Note: File will be created if it doesn't exist, and overwritten if it already exists.
                Get-ChildItem -Recurse -Path $PSScriptRoot | Sort-Object Name | Out-File $filePath

                # Inform the user that the file was written.
                Write-Host "`n" "`n" "Results written to: " $filePath "`n"
        
             }

           #Case 3
           3 {
               # Clear the screen.
               Clear-Host

               # Inform the user that this task is running and that they should wait for results.
               Write-Host "Running. Please wait..." "`n"

               # Output (to the console) the processor time and memory usage. Four results will be shown in five-second intervals.
               Get-Counter -Counter "\Processor(_Total)\% Processor Time","\Memory\Available MBytes" -SampleInterval 5 -MaxSamples 4  
               
               # Inform the user that this task is complete.
               Write-Host "Task complete." "`n"                    

             }

           #Case 4
           4 {
                # Clear the screen.
                Clear-Host

                # List the running process in a new Gridiew window, sorted by processor time in seconds (CPUs), in descending order. Only list those with a processer time greater than zero.
                Get-Process | Sort-Object CPU -Descending | Where-Object { $_.CPU -gt 0 } | Out-GridView
             }

           #Case 5
           5 {
                # Notify the user that we are exiting, and end the program.
                Write-Host "`n" "Exiting..." "`n"; exit
             }

        }
     }
}
catch [System.OutOfMemoryException] {
    Write-Host "An OutOfMemoryException has occurred."
}
