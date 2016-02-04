require 'gtk3'
def MakeWin(w, h, title)
app = Gtk::Application.new("org.gtk.elten")
app.signal_connect "activate" do |application|
window = Gtk::ApplicationWindow.new(application)
window.set_title(title)
window.set_default_size(w, h)
grid = Gtk::Grid.new
window.add grid
window.show_all
end
status = app.run([$0] + ARGV)
end

