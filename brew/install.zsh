# https://stackoverflow.com/questions/21577968/how-to-tell-if-homebrew-is-installed-on-mac-os-x#:~:text=I%20use%20this%20to%20perform%20update%20or%20install%3A

which -s brew >/dev/null
if [[ $? != 0 ]] ; then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# else
#     brew update
fi