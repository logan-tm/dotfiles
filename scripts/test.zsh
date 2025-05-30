. $HOME/.env.sh
. $DOTFILES/util/print.sh

info "Waiting..."
sleep 1
pretty_print clear_last && pretty_print success "Done!"

info "Waiting again..."
sleep 1
pretty_print clear_last && pretty_print success "Done!"

pretty_print debug "Debug message"