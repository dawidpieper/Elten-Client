require 'gtk3'
def MakeWin(w, h, title)
app = Gtk::Application.new("org.gtk.elten")
app.signal_connect "activate" do |application|
$window = Gtk::ApplicationWindow.new(application)
$window.set_title(title)
$window.set_default_size(w, h)
grid = Gtk::Grid.new
$window.add grid
$window.show_all
end
status = app.run([$0] + ARGV)
end
def alert (txt)
dialog = Gtk::Dialog.new("elten", $window, Gtk::Dialog::DESTROY_WITH_PARENT, [Gtk::Stock::OK, Gtk::Dialog::RESPONSE_NONE])
dialog.signal_connect("response") { dialog.destroy }
dialog.vbox.add(Gtk::Label.new(txt))
dialog.show_all
end

