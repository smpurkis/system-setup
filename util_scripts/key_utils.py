from pynput import keyboard
import pyperclip
import webbrowser
import subprocess as sp


def google_search_with_clipboard():
    clipboard_str = pyperclip.paste()
    search_str = "+".join(clipboard_str.split())
    google_url = f"https://www.google.com/search?q={search_str}"
    print(f"Opening new tab with Google search: {search_str}")
    webbrowser.open_new_tab(google_url)


def launch_flameshot():
    sp.run("flameshot gui".split(), shell=False)


if __name__ == "__main__":
    with keyboard.GlobalHotKeys(
        {"<ctrl>+b": google_search_with_clipboard, "<ctrl>+<shift>+s": launch_flameshot}
    ) as h:
        h.join()
