require 'tk'

class Main
  def create_msg
    $config_text = TkMessage.new(
      $root,
      text: 'hello',
      borderwidth: 30
    )
    $config_text.pack
  end

  def sub
    ct = 1
    loop do
      sleep(1)
      $config_text.configure(text: "ok:#{ct}")
      ct += 1
    end
  end
end

main = Main.new
main.create_msg
t1 = Thread.start { main.sub }
Tk.mainloop
