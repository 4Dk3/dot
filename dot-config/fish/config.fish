if status is-interactive
and not set -q TMUX
    if tmux has-session -t 43
	exec tmux attach-session -t 43
    else
        tmux new-session -s 43
    end
end

fish_add_path ~/.local/bin 
fish_add_path ~/bin/idea-IC-251.25410.109/bin/
