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
                "separator": "\t",
                "context": PURPLE,
                "clear": CLEAR,
                "end": ORANGE,
                "garage": GREY,
                "date": ORANGE,
                "time": CYAN,
            }
        else:
            self.colors = {"separator": " "}

    def color(self, name):
        return self.colors.get(name, "")
