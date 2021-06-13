from . import Palette


class TaskRenderer:
    def __init__(self, theme=None):
        self.palette = Palette(theme=theme)
        self.clear = self.palette.color("clear")
        self.separator = self.palette.color("separator")

    def renderBody(self, task):
        parts = []
        if task.dateInclude:
            parts += [f"{self.palette.color('date')}{task.date.display} {self.clear}"]
        if task.timeInclude:
            parts += [f"{self.palette.color('time')}{task.time.display} {self.clear}"]
        if task.mission:
            parts += [self.palette.color("mission")]
        elif task.garage:
            parts += [self.palette.color("garage")]
        if task.end:
            parts += [f"to {self.palette.color('end')}{task.end.display}{self.clear}"]
        parts += [task.subject]

        return "".join(parts)

    def render(self, task):
        parts = []
        parts += [
            f"{task.rank}{self.separator}",
            f"{self.palette.color('context')}{task.context}{self.clear}",
            self.separator,
            self.renderBody(task),
            f"{self.separator}{task.file}"
        ]
        return "".join(parts)
