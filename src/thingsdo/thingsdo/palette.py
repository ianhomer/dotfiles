PURPLE = "\033[95m"
ORANGE = "\033[33m"
CYAN = "\033[36m"
GREEN = "\033[32m"
GREY = "\033[90m"
CLEAR = "\033[0m"


class Palette:
    def __init__(self, theme=None):
        self.theme = theme
        if self.theme:
            self.colors = {
                    "context": PURPLE,
                    "clear": CLEAR,
                    "end": ORANGE,
                    "garage": GREY,
                    "date": ORANGE,
                    "time": CYAN
                }

    def color(self, name):
        if self.theme:
            return self.colors.get(name, "")
        else:
            return ""





