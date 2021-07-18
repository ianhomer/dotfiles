import datetime


class Factory:
    def __init__(self, environment):
        self.environment = environment

    def getTodayLog(self, now=datetime.datetime.now()):
        today = now.strftime("%m%d")
        return self.getPath(today)

    def getPath(self, name):
        return (
            f"{self.environment.myNotesDir}/stream/{name}.md"
        )
