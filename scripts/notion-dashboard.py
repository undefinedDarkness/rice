import gi
import pathlib
gi.require_version('Gtk', '3.0')
gi.require_version('WebKit2', '4.1')

from gi.repository import Gtk, WebKit2, Gio, GLib

def store_session(webview):
    session_state = webview.get_session_state()
    session_state_data = session_state.serialize().get_data()

    with open('data.dump', "wb") as f:
        f.write(session_state_data)

    pass

def restore_session(webview):
    with open('data.dump', 'rb') as f:
        content = f.read()
        session_state = WebKit2.WebViewSessionState(GLib.Bytes.new(content))
        webview.restore_session_state(session_state)


class MyWindow(Gtk.Window):

    def __init__(self):
        Gtk.Window.__init__(self, title="Notion Dashboard")
        self.set_default_size(800, 600)

        # Create a WebKit WebView
        self.webview = WebKit2.WebView()
        self.webctx = self.webview.get_context()
        cookie_manager = self.webctx.get_cookie_manager()
        cookie_manager.set_persistent_storage("cookies.dump", WebKit2.CookiePersistentStorage.TEXT)
        
        if pathlib.Path("./data.dump").exists():
            restore_session(self.webview)
            print("Restored from data dump.")

        self.webview.load_uri("https://www.notion.so")

        self.connect("destroy", Gtk.main_quit)
        self.connect("destroy", lambda _: store_session(self.webview))

        self.add(self.webview)

win = MyWindow()
win.connect("destroy", Gtk.main_quit)
win.show_all()
Gtk.main()

