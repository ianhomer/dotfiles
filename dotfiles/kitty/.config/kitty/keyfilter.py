from typing import List
from kitty.boss import Boss
from kittens.tui.handler import result_handler
from kitty.key_encoding import KeyEvent, parse_shortcut
from kitty.key_encoding import CTRL

def main(args: List[str]) -> str:
    pass


def is_vim(window):
    print(window)
    processes = window.child.foreground_processes
    return any(process["cmdline"][0] in ["nvim", "vim"] for process in processes)


def key_event(keymap):
    mods, key = parse_shortcut(keymap)
    return KeyEvent(mods=mods, key=key, ctrl=CTRL & mods)


@result_handler(no_ui=True)
def handle_result(
    args: List[str], answer: str, target_window_id: int, boss: Boss
) -> None:

    action = args[1]
    keymap = args[2]

    window = boss.window_id_map.get(target_window_id)

    if is_vim(window):
        encoded_key = window.encoded_key(key_event(keymap).as_window_system_event())
        window.write_to_child(encoded_key)
    elif action in ["left", "right", "top", "bottom"]:
        boss.active_tab.neighboring_window(action)
