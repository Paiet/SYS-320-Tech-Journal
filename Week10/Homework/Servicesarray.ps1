#Description: List services and allow them to pick what they want to view out of an array.

function select_service () {

    cls

    # List all registered services

    Get-Service

    # Make array with 3 set values

    $arrService =@('all','stopped','running')

    $readService = Read-Host -Prompt "Select what you would like to view 'all' services, 'stopped' services, or 'running' services? Or press 'q' to quit."

    # Check if the user wants to quit.

    if ($readService -match "^[qQ]$") {
     
        # Stop executing the program and close the script

        break
}

service_check -serviceToSearch $readService

}

function service_check() {

    # input the user types in forselect_service

    Param([string]$serviceToSearch)

    # Set variable $theService

    $theService = "$serviceToSearch"

    # If the input status exists in the $arrService array list the related services

    if ($arrService -match $theService){

        write-host -BackgroundColor black -ForegroundColor yellow "Please wait it may take time to process"
        sleep 3

        # Call the function to view the service

        view_service -serviceToSearch $serviceToSearch

        # If else tell the user that its an invalid value 

        } else {

            write-host -BackgroundColor red -ForegroundColor white "Invalid value"

            sleep 3

            select_service

        }

    } # Ends the service_check()

function view_service () {

    cls

    if ($serviceToSearch -eq "all") {

    Get-Service | Sort-Object -Property Status, Name

    # Pause the screen and wait until the user is ready to proceed.

    read-host -Prompt "press enter when finished"

    # Go back to select_service

    select_service

    } else {

    # Gets the services

    Get-Service | Where-Object {$_.Status -eq $serviceToSearch} | Sort-Object -Property Name

    # Pause the screen until done viewing 

    read-host -Prompt "Press enter when done"

    # Go back to select_service

    select_service

    }

} # Ends the view_service()


# runs the select_service as the first function 
select_service 
