/*
* Copyright (c) 2017 Lains
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*/
namespace Coin {
    public class MainWindow : Gtk.Dialog {
        private Gtk.Stack stack;

        public MainWindow (Gtk.Application application) {
            Object (application: application,
                    icon_name: "com.github.lainsce.coin",
                    resizable: false,
                    title: _("Coin"),
                    height_request: 272,
                    width_request: 500);

            Granite.Widgets.Utils.set_theming_for_screen (
                this.get_screen (),
                Stylesheet.BODY,
                Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
            );
        }

        construct {
            this.get_style_context ().add_class ("rounded");
            this.window_position = Gtk.WindowPosition.CENTER;

            var test = new Gtk.Label ("Testing...");
            test.halign = Gtk.Align.END;
            test.margin_bottom = 18;
            test.get_style_context ().add_class ("test");

            var grid = new Gtk.Grid ();
            grid.column_spacing = 12;
            grid.margin_bottom = 6;
            grid.margin_end = 18;
            grid.margin_start = 18;
            grid.attach (test, 2, 0, 1, 1);

            stack = new Gtk.Stack ();
            stack.transition_type = Gtk.StackTransitionType.CROSSFADE;
            stack.vhomogeneous = true;
            stack.add_named (grid, "money");

            var content_box = get_content_area () as Gtk.Box;
            content_box.border_width = 0;
            content_box.add (stack);
            content_box.show_all ();

            var settings = AppSettings.get_default ();

            int x = settings.window_x;
            int y = settings.window_y;

            if (x != -1 && y != -1) {
                move (x, y);
            }
        }

        public override bool delete_event (Gdk.EventAny event) {
            int x, y;
            get_position (out x, out y);

            var settings = AppSettings.get_default ();
            settings.window_x = x;
            settings.window_y = y;

            return false;
        }
    }
}
