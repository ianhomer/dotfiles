from . import Palette


class TaskRenderer:
    def __init__(self, theme=None):
        self.palette = Palette(theme=theme)
        self.clear = self.palette.color("clear")
        self.separator = self.palette.color("separator")
        self.whostart = self.palette.color("whostart")
        self.whoend = self.palette.color("whoend")

    def renderBody(self, task):
        parts = []
        modifier = self.modifier(task)
        if task.dateInclude:
            parts += [
                self.palette.color("date", modifier),
                task.date.display,
                " ",
                self.clear,
            ]
        if task.timeInclude:
            parts += [
                f"{self.palette.color('time', modifier)}{task.time.display} {self.clear}"
            ]
        if task.end:
            parts += [f"to {self.palette.color('end')}{task.end.display}{self.clear}"]

        parts += [
            self.palette.color(task.primaryType, modifier),
            task.subject.replace("[", self.whostart).replace(
                "]", self.whoend + self.palette.color(task.primaryType)
            ),
            self.clear,
        ]
        return "".join(parts)

    def modifier(self, task):
        return "normal" if task.rankGroup < 4000 else "faint"

    def render(self, task):
        parts = []
        modifier = self.modifier(task)
        parts += [
            f"{task.rank}{self.separator}",
            f"{self.palette.color('context', modifier)}{task.context}{self.clear}",
            self.separator,
            self.renderBody(task),
            f"{self.separator}{task.file}",
        ]
        return "".join(parts)
