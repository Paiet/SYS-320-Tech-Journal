##########################################################################
# Lock or Unlock User Accounts
##########################################################################
acct_lock() {

  clear
  echo "Comments: >" $alert

  echo "
  User Account Lock Tool
  **********************

  1) Lock User Account
  2) Unlock User Account
  3) Account Lock Status

  M) Main Menu
  X) Exit Program

  "
  read -p "Please choose option...>" acct_lock_opt

  case $acct_lock_opt in
    1)    echo
          read -p "Enter username...>" uzr
          chage -E 0 $uzr
          read -p "Press enter to continue"
          acct_lock
          ;;
    2)    echo
          read -p "Enter username...>" uzr
          chage -E -1 $uzr
          read -p "Press enter to continue"
          acct_lock
          ;;
    3)    echo
          read -p "Enter username...>" uzr
          ch_date=$(sudo chage -l $uzr | grep Account | gawk -F: '{print $2}' | gawk '{print $1,$2,$3}' | sed 's/,//')
          if [ "$ch_date" = "never" ] || [ "$ch_date" = "never  " ]; then
                echo "Account is UNLOCKED"
                echo "Password expiration date is: $ch_date"
                read -p "Press ENTER to continue"
                acct_lock
          else
            ch_date_convert=$(date -d "$ch_date" "+%Y-%m-%d")
            ch_date_seconds=$(date -d $ch_date_convert +%s)

            tday=$(date +%F)
            tday1=$(date -d $tday +%s)

            if [ "$ch_date_seconds" -le "$tday1" ]; then
                echo "!!! Account is LOCKED !!!"
                echo "Password expiration date is: $ch_date"
                read -p "Press ENTER to continue"
                acct_lock
            else
                echo "Account is UNLOCKED"
                echo "Password expiration date is: $ch_date"
                read -p "Press ENTER to continue"
                acct_lock
            fi
          fi  
          ;;
    m|M)  main ;;
    x|X)  clear
          exit ;;
    *)    echo
          alert="Invalid Option: $acct_lock_opt"
          acct_lock
          ;;
  esac

}
