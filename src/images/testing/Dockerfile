
FROM archlinux:latest AS builder

RUN pacman -Syu --noconfirm --needed base-devel git sudo

# User anlegen für makepkg (root darf nicht)
RUN useradd -m user && \
    echo "user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Paru aus dem AUR holen, bauen und installieren
USER user
WORKDIR /home/user/.local
RUN git clone https://aur.archlinux.org/paru.git && \
    cd paru && \
    makepkg -si --noconfirm && \
    cd .. && \
    rm -rf paru




FROM archlinux:latest


RUN pacman -Syu --noconfirm  && \
    pacman -S --noconfirm  --needed sudo exa 7zip aspnet-runtime autoconf logcli ffmpeg fish base-devel base-devel bash bash-completion bat bc bind btop bzip2 curl dotnet-sdk fastfetch yazi  fzf git glances glow grep gzip helm htop httpie imagemagick jq k9s kinit kubectl  make man-db man-pages md-tui micro nano net-tools nmap nodejs openssh openssl openvpn   python python-pip python-virtualenv ripgrep ripgrep rsync sed tar terminus-font tmux tmuxp traceroute ttf-fira-code ttf-fira-sans ttf-jetbrains-mono ttf-liberation ttf-opensans ugrep unarchiver unarj unrar unzip vi wget which whois xarchiver xz yq zip zoxide zoxide zsh chezmoi && \
    pacman -Scc --noconfirm && \
    useradd -m user && \
    chsh -s /bin/zsh user && \
    echo "user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

####paru

COPY --from=builder /usr/bin/paru /usr/bin/paru

USER user
RUN paru -S --noconfirm --needed   go-jsonnet grafana-alloy-bin jsonnet-bundler   gdu  ttf-victor-mono  flux-bin  lazydocker lazygit logiops pokemon-colorscripts-git oh-my-posh && \
    paru -S --noconfirm --needed --nocheck kubecolor && \
    paru -Scc --noconfirm && \
    mkdir -p  ~/.kube ~/.tmux ~/.oh-my-zsh ~/.config ~/.zplug ~/.ssh ~/.local/share/chezmoi ~/dotfiles ~/.configs
    #  sudo chsh -s /bin/zsh user && \

#  flux-bin  lazydocker logiops pokemon-colorscripts-git paru  kubecolor
#
WORKDIR /home/user
COPY .kube      /home/user/.kube
COPY .tmux      /home/user/.tmux
COPY .oh-my-zsh /home/user/.oh-my-zsh
COPY .config    /home/user/.config
COPY .zplug     /home/user/.zplug
COPY .ssh       /home/user/.ssh
COPY .local/share/chezmoi /home/user/.local/share/chezmoi
COPY dotfiles   /home/user/dotfiles
COPY .zshrc     /home/user/.zshrc
COPY .gitconfig /home/user/.gitconfig
COPY .tmux.conf      /home/user/.tmux.conf

USER root
RUN chown -R user:user /home/user && \
    chmod -R u+rwx /home/user
USER user
#RUN zsh -c "source ~/.zshrc && zplug update"
CMD [ "zsh" ]