BOLD = "1m"
BOLD_END = "0m"
BLUE = "34m"
CLEAR = "0m"
CYAN = "36m"
GREEN = "32m"
GREY = "90m"
INVERSE = "7m"
INVERSE_END = "27m"
LIGHT_BLUE = "94m"
NORMAL = "97m"
ORANGE = "33m"
PURPLE = "95m"
UNDERLINE = "4m"
UNDERLINE_END = "24m"


class Palette:
    def __init__(self, theme=None):
        self.theme = theme
        if self.theme:
            self.pre = "\033["
            self.colors = {
                "whostart": "95;1m",
                "whoend": BOLD_END,
                "clear": CLEAR,
                "context": PURPLE,
                "date": ORANGE,
                "end": ORANGE,
                "garage": GREY,
                "backlog": LIGHT_BLUE,
                "mission": GREEN,
                "normal": NORMAL,
                "question": BLUE,
                "separator": "\t",
                "time": CYAN,
            }
            self.modifiers = {
                "normal": "",
                "bold": "1;",
                "faint": "2;",
                "italics": "3;",
                "underline": "4;",
            }
        else:
            self.pre = ""
            self.colors = {"separator": " "}
            self.modifiers = {"faint": ""}

    def color(self, name, modifier="normal"):
        return self.pre + self.modifiers.get(modifier, "") + self.colors.get(name, "")
