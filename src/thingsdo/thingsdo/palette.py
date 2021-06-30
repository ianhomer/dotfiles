PURPLE = "95m"
ORANGE = "33m"
CYAN = "36m"
GREEN = "32m"
GREY = "90m"
BLUE = "34m"
LIGHT_BLUE = "94m"
NORMAL = "97m"
CLEAR = "0m"


class Palette:
    def __init__(self, theme=None):
        self.theme = theme
        if self.theme:
            self.pre = "\033["
            self.colors = {
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
