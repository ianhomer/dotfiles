def match(command):
    return 'pull' in command.script and 'set-upstream' in command.output

def get_new_command(command):
    return "git push -u && git pull"

priority = 1
