#The main class of this gem
class OutputHandler

  # Creates a new instance of OutputHandler. It accepts an optionshash.
  #
  # @param console [Boolean]  If set to true (default), the handler will output to STDOUT. 
  # @param logfile [String] If set to a target and the target is valid, the handler will output to logfile. 
  #
  #   
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


  # Returns whether output currently is paused.
  #
  # @return [Boolean] 
  def paused?
    @paused
  end

  # Pauses the output. If parameter is sent, output will autoresume after delay. Overrides currently
  # set delay.
  #
  # @param limit [Numeric] Time to pause.
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
 
  # Unpauses currently paused output regardless of any set delay.
  def unpause
    @paused = false
  end

  # Flushes currently suspended output.
  #
  # @param silent [Boolean] If set to true, flushes to /dev/null, else to configured output(s).
  def flush(silent = false)
    while not @outputQueue.empty?
      el = @outputQueue.pop
      self.out!(el[:s], el[:newline]) unless silent
    end
  end

  # Sends next chunk to outputs. Will be queued if #paused, otherwise sent to output(s).
  #
  # @param chunk [printable Object]
  # @param newline [Boolean] Indicates whether (default) or not to end line with a newline character.
  def out(chunk = "", newline = true)
    @outputQueue << { s: chunk, newline: newline }
  end

  # Sends next chunk to output(s) directly, regardless of #paused.
  #
  # @param (see #out)
  def out!(chunk = "", newline = true)
    print "\r#{chunk.chomp}#{newline ? "\n" : ""}" if @console
    File.open(@logfile,'a+'){|f| f.write "\r#{chunk.chomp}#{newline ? "\n" : "" }" }  if @file
  end

  # Spawns output thread
  # @!visibility private
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

  # Spawns a thread that creates some random output
  #
  # @!visibility private
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
