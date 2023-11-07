{...}: {
  programs.tmux = {
    enable = true;
    extraConfig = ''
      # Keybindings
      source-file ${./keybindings.tmux}
      source-file ${./navigator.tmux}

      # Styles
      source-file ${./styles.tmux}

      # Settings
      source-file ${./settings.tmux}
    '';
  };
}
