class OutputHandler

  def initialize(opts = {}, *args, &block)
    raise TypeError unless opts.is_a? Hash
    @outputQueue = Queue.new
    @console = opts[:console].nil? ? true : opts[:console]
    @logfile = opts[:logfile].nil? ? nil : opts[:logfile]
    @file = @logfile.nil? ? false : true
    @paused = false
    @outputMonitor = Monitor.new
    system("touch #{@logfile}") unless @logfile.nil?
    self.spawn_output
  end

  def paused?
    @paused
  end

  def pause(limit = 0)
    unless self.paused?
      Thread.kill(@outputThread)
      @paused = true
      self.spawn_output
    end
    if limit > 0
      Thread.new do
        sleep limit
        @paused = false
      end
    end
  end
 

  def unpause
    @paused = false
  end

  def flush(silent = false)
    while not @outputQueue.empty?
      el = @outputQueue.pop
      self.out!(el[:s], el[:newline]) unless silent
    end
  end

  def out(s = "", newline = true)
    @outputQueue << { s: s, newline: newline }
  end

  def out!(s = "", newline = true)
    print "\r#{s.chomp}#{newline ? "\n" : ""}" if @console
    File.open(@logfile,'a+'){|f| f.write "\r#{s.chomp}#{newline ? "\n" : "" }" }  if @file
  end

  def spawn_output
    @outputThread = Thread.new do
      loop do
        if self.paused?
          sleep 0.1
        else
          out = @outputQueue.pop
          s   = out[:s]
          print "\r#{s}#{out[:newline] ? "\n" : ""}" if @console
          File.open(@logfile,'a+'){|f| f.write "\r#{s}#{out[:newline] ? "\n" : "" }" }  if @file
        end
      end
    end
  end

  def random_output
    if @random_out_thread.nil?
      @random_out_thread = Thread.new do
        loop do
          o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
          string = (0...50).map { o[rand(o.length)] }.join
          @outputQueue << { s: string, newline: true }
          sleep 5
        end
      end
    else
      Thread.kill @random_out_thread
      @random_out_thread = nil
    end
  end


end
