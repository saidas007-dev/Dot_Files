#!/usr/bin/env bash
set -euo pipefail

# ----------------------
# Config
# ----------------------
SEARCH_ROOT="${1:-$HOME}"

if [[ "$SEARCH_ROOT" == "all" ]]; then
    echo "⚠️ Full system search — may be slow!"
    sleep 1
    SEARCH_ROOT="/"
fi

# ----------------------
# Search command
# ----------------------
if ! command -v fd >/dev/null 2>&1; then
    echo "fd not found. Please install fd for fast search."
    exit 1
fi
SEARCH_CMD="fd --type f --type d --hidden --follow --exclude .git --threads 8 . \"$SEARCH_ROOT\""

# ----------------------
# Preview function
# ----------------------
preview_cmd() {
    local target="$1"
    if [[ -d "$target" ]]; then
        ls -lh --color=always "$target"
    else
        if file "$target" | grep -q text; then
            if command -v bat >/dev/null 2>&1; then
                bat --style=numbers --color=always --line-range :50 "$target" 2>/dev/null || head -n 50 "$target"
            else
                head -n 50 "$target"
            fi
        else
            echo "[Binary file — preview not available]"
        fi
    fi
}
export -f preview_cmd

# ----------------------
# Temporary file to communicate between panes
# ----------------------
TMPFILE=$(mktemp)

# ----------------------
# Start tmux panes
# ----------------------
# Left pane: FZF search
tmux split-window -h -p 50 "bash -c '
while true; do
    file=\$(eval \"$SEARCH_CMD\" | fzf \
        --height=100% \
        --layout=reverse \
        --border=rounded \
        --ansi \
        --prompt=\"🔍 Search → \" \
        --info=inline \
        --preview=\"bash -c \\\"preview_cmd {}\\\"\" \
        --preview-window=right:40%:wrap \
        --bind \"ctrl-f:toggle-preview,ctrl-h:toggle-hidden,ctrl-r:reload:$SEARCH_CMD\")
    if [[ -n \"\$file\" ]]; then
        echo \"\$file\" > \"$TMPFILE\"
    fi
done
'"

# Right pane: Ranger
tmux split-window -v -p 50 "bash -c '
while true; do
    if [[ -s \"$TMPFILE\" ]]; then
        path=\$(cat \"$TMPFILE\")
        cd \"\$(dirname \"\$path\")\"
        ranger --selectfile=\"\$path\"
        > \"$TMPFILE\"
    else
        sleep 0.2
    fi
done
'"

# Focus left pane for search
tmux select-pane -L

