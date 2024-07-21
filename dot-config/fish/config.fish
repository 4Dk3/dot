if status is-interactive
and not set -q TMUX
    if tmux has-session -t 43
	exec tmux attach-session -t 43
    else
        tmux new-session -s 43
    end
end

fish_add_path ~/.local/bin
