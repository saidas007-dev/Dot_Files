from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import *

class Gruvbox(ColorScheme):
    progress_bar_color = 33
    def use(self, context):
        fg, bg, attr = default_colors
        if context.reset: return default_colors
        if context.in_browser:
            if context.selected: attr |= reverse
            if context.directory: fg = 220
            elif context.executable: fg = 142
            elif context.media: fg = 174
            elif context.container: fg = 141
            elif context.link: fg = 75
            elif context.tag_marker: fg = 204
        elif context.in_titlebar: fg = 223; attr |= bold
        elif context.in_statusbar: fg = 223; bg = 234
        elif context.in_taskview: fg = 223
        return fg, bg, attr

