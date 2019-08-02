require 'tk'

class Main
  def initialize
    @max = 0
    @min = 100
    @root = TkRoot.new
    @root.title('config')

    @config_frame = TkFrame.new(@root)
    @max_frame    = TkFrame.new(@root)
    @min_frame    = TkFrame.new(@root)

    @cpu_temp_text = TkLabel.new(
      @config_frame,
      text: 'CPU temp:',
      # borderwidth: 100
      width: 12,
      height: 2
    )
    @cpu_temp = TkLabel.new(
      @config_frame,
      text: return_temp + '°C',
      # borderwidth: 100
      width: 12,
      height: 2
    )
    @max_text = TkLabel.new(
      @max_frame,
      text: 'max temp:',
      width: 12,
      height: 2
    )
    @max_temp = TkLabel.new(
      @max_frame,
      text: '0',
      fg: 'red',
      width: 12,
      height: 2
    )
    @min_text = TkLabel.new(
      @min_frame,
      text: 'min temp:',
      width: 12,
      height: 2
    )
    @min_temp = TkLabel.new(
      @min_frame,
      text: '0',
      fg: 'blue',
      width: 12,
      height: 2
    )

    @config_frame.pack
    @max_frame.pack
    @min_frame.pack

    @cpu_temp_text.pack(side: 'left')
    @cpu_temp.pack(side: 'right')

    @max_text.pack(side: 'left')
    @max_temp.pack(side: 'right')

    @min_text.pack(side: 'left')
    @min_temp.pack(side: 'right')
  end

  def temp_rewrite
    loop do
      sleep(0.5)
      current_temp = return_temp
      @cpu_temp.configure(text: current_temp + '°C')
      judge_max_min_temp(current_temp.to_f)
    end
  end

  def judge_max_min_temp(temp)
    if temp > @max
      @max = temp
      max_min_temp_rewrite(@max_temp, @max)
    elsif temp < @min
      @min = temp
      max_min_temp_rewrite(@min_temp, @min)
    end
  end

  def max_min_temp_rewrite(label, val)
    label.configure(text: val.to_s + '°C')
  end

  private

    def return_temp
      temp = `istats`.scan(/CPU.*°C/)[0].scan(/\d.*°C/)[0].scan(/\d*[.]\d*/)[0] # return '55.55'
      # judge_max_min_temp(temp)
      temp
    end
end

main = Main.new
t1 = Thread.start { main.temp_rewrite }
Tk.mainloop
