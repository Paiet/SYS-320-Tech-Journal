# Description: Start and Stop Calculator

# Starts the calculator
Start-Process calc.exe

# Pauses for 1 second so that it can be up long enough to be found
Start-Sleep -s 1


# Stops the calculator
Stop-Process -name 'calculator'
