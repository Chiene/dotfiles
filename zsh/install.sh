#! /bin/sh

head "Setting up Z Shell"

info "Looking for an existing zsh config ..."
if [ -f ${DOTTARGET}/.zshrc ] || [ -h ${DOTTARGET}/.zshrc ]; then
    info "\e[00;33mFound ${DOTTARGET}/.zshrc file.\e[0m \e[0;32mBacking up to ${DOTFILES}/.zshrc.bak\e[0m"
    mv ${DOTTARGET}/.zshrc ${DOTFILES}/.zshrc.bak
fi

info "Copying ${DOTTARGET}/.zshrc ..."
cp ${DOTFILES}/zshrc ${DOTTARGET}/.zshrc
sed -i -e "/^local zsh=/ c\\"$'\n'"local zsh=\"${DOTFILES}/zsh\"" ~/.zshrc

info "Copying ${DOTTARGET}/.zshenv and adding your current PATH to it ..."
if [ -f "${DOTTARGET}/.zshenv" ] || [ -h "${DOTTARGET}/.zshenv" ]; then
    info "\e[00;33mFound ${DOTTARGET}/.zshenv file.\e[0m \e[0;32mReserving ...\e[0m"
else
    cp ${DOTFILES}/zshenv ${DOTTARGET}/.zshenv
    sed -i -e "/^export PATH=/ c\\"$'\n'"export PATH=${PATH}" ~/.zshenv
fi

info "Copying ${DOTTARGET}/.zlogin ..."
if [ -f "${DOTTARGET}/.zlogin" ] || [ -h "${DOTTARGET}/.zlogin" ]; then
    info "\e[00;33mFound ${DOTTARGET}/.zlogin file.\e[0m \e[0;32mReserving ...\e[0m"
else
    cp ${DOTFILES}/zlogin ${DOTTARGET}/.zlogin
fi

info "Copying ${DOTTARGET}/.zlogout ..."
if [ -f "${DOTTARGET}/.zlogout" ] || [ -h "${DOTTARGET}/.zlogout" ]; then
    info "\e[00;33mFound ${DOTTARGET}/.zlogout file.\e[0m \e[0;32mReserving ...\e[0m"
else
    cp ${DOTFILES}/zlogout ${DOTTARGET}/.zlogout
fi

infor "Creating necessary directories ..."
[[ -e "${DOTFILES}/caches" ]] || mkdir -p "${DOTFILES}/caches"

if [ "$SHELL" != "$(which zsh)" ]; then
    info "Changing default shell to zsh ..."
    chsh -s $(which zsh)
fi