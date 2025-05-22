# check if we have a valid sso login
# useful for when cron ran script so that it doesnt just get a bunch
#  of errors when your not logged in
# ssoLoginCheck () {
#   echo "Checking if we have a valid sso login"
#   aws sts get-caller-identity &> /dev/null
#   # $? is the exit code of the last statement
#   code=$?
#   echo "Code: $code"
#   if [ $? -eq 0 ]; then
#       # auth is valid
#       echo "your sso token is valid, continuing"
#   else
#     echo "Your sso token is invalid, checking if we are in a tty"
#     if [ -t 1 ] ; then
#       echo "Found that this is an interactive terminal, will run the sso login"
#       # auth needs refresh
#       aws sso login
#       if [ ! $code -eq 0 ]; then
#         echo "You didnt login, exiting!"
#         exit 1;
#       fi
#     else
#       # is cron
#       echo "Not in a tty, gracefully exiting due to no active SSO login. Check that your logged in via SSO, or have perms via IAM already setup";
#       exit 1;
#     fi
#   fi
# }

ssoLoginCheck () {
  sts=$(aws sts get-caller-identity 2>&1)
  code=$?
  if [ ! $code -eq 0 ]; then
    aws sso login
  else
    success "SSO Confirmed"
    echo $sts
  fi
}