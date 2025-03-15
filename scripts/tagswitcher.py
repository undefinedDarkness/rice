import gi
gi.require_version('Gtk', '3.0')
# gi.require_version('WebKit2', '4.0')
from gi.repository import Gtk, WebKit2, Gdk # type: ignore
from pathlib import Path

script_path = Path(__file__).parent 

class TransparentWebViewWindow(Gtk.Window):

    def __init__(self):
        Gtk.Window.__init__(self, title="Transparent Webview Example")
        self.set_default_size(800, 600)
        self.connect("destroy", Gtk.main_quit)

        # Set up the GTK window with transparency
        self.set_app_paintable(True)
        screen = self.get_screen()
        rgba = screen.get_rgba_visual()
        if rgba is not None and screen.is_composited():
            self.set_visual(rgba)

        # Create a WebKit2 WebView
        self.webview = WebKit2.WebView()
        self.webview.set_background_color(Gdk.RGBA(0, 0, 0, 0))

        # Load a webpage
        self.webview.load_uri(f"file:///{script_path / 'tagswitcher.html' }")

        # Load CSS file
        self.load_css("style.css")

        # Add the WebKit2 WebView to the window
        self.add(self.webview)


        # Show all components
        self.show_all()

    def load_css(self, filename):
        # Load CSS file into the WebView
        style_provider = Gtk.CssProvider()
        style_provider.load_from_path(filename)
        context = self.webview.get_style_context()
        context.add_provider(style_provider, Gtk.STYLE_PROVIDER_PRIORITY_USER)

win = TransparentWebViewWindow()
Gtk.main()

