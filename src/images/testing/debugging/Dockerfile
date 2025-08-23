
FROM archi_base:latest 
ENV NO_TMUX=1

#

USER user
WORKDIR /home/user/.local

RUN sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply erstert3st && \
    rm -rf ~/.tmux/plugins/* && \
    tmux new-session -d -s tmp "sleep 0.1; tmux kill-session -t tmp" && \
    ~/.tmux/plugins/tpm/bin/install_plugins  && \
    ~/.local/bin/chezmoi apply --force  && \
    paru -Qtdq --noconfirm && \
    go clean -modcache -cache -testcache && \
    sudo rm -rf ~/.cache/* && \
    sudo rm -rf /tmp/* 

# RUN bash -c ' \
#   export ZPLUG_HOME=$HOME/.zplug; \
#   source $ZPLUG_HOME/init.zsh; \
#   zplug "Aloxaf/fzf-tab", defer:1; \
#   zplug "zsh-users/zsh-autosuggestions", defer:1; \
#   zplug "zsh-users/zsh-syntax-highlighting", defer:1; \
#   zplug "zshzoo/cd-ls", defer:2; \
#   zplug "MichaelAquilina/zsh-you-should-use", defer:1; \
#   zplug "MichaelAquilina/zsh-autoswitch-virtualenv", defer:2; \
#   zplug "Freed-Wu/zsh-command-not-found", defer:2; \
#   zplug "zsh-users/zsh-completions", defer:1; \
#   zplug "zsh-users/zsh-history-substring-search", defer:2; \
#   zplug install \
# '
# RUN zsh -ic "source ~/.zplug/init.zsh && zplug install"

# RUN     zsh -c "source ~/.zshrc && zplug clear && zplug --self-manage && zplug install" 
# RUN     zsh -c "source ~/.zshrc && zplug load --verbose"

CMD [ "zsh" ]