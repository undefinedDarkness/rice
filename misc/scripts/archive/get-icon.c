#include <gtk/gtk.h>
#include <stdio.h>

int main(int argc, char ** argv) {

  if (argc < 3) {
    fprintf(stderr, "Not enough arguments: <icon-name> <icon-size>\n");
    return 0;
  }

  gtk_init(&argc, &argv);
  GtkIconTheme *theme = gtk_icon_theme_get_default(); 
  GtkIconInfo *icon_info = gtk_icon_theme_lookup_icon(GTK_ICON_THEME(theme), argv[1], strtol(argv[2], NULL, 10), GTK_ICON_LOOKUP_GENERIC_FALLBACK);
  printf("%s\n", gtk_icon_info_get_filename(icon_info));
}
