class Thing:
    def __init__(self, root, filename: str):
        self.root = root
        self.filename = (
            filename[len(root) + 1 :] if filename.startswith(root) else filename
        )
