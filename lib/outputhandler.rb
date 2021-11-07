require 'date'
#The main class of this gem
class OutputHandler

  # Aliasing puts and print, as they are included / inherited (?) from IO
  alias_method :superputs,  :puts
  # Aliasing puts and print, as they are included / inherited (?) from IO
  alias_method :superprint, :print

  # Creates a new instance of OutputHandler. It accepts an options hash.
  #
  # @param opts [Hash]  
  # @option opts [Boolean] :console If set to true (default), the handler will output to STDOUT. 
  # @option opts [String] :logfile If set to a target and the target is valid, the handler will output to logfile. 
  #
  def initialize(
    console: true,
    location: nil,
    logfile: -> { "#{Date.today.strftime('%Y-%m-%d')}.log" },
    carriage: false,
    debug: false,
    &block)

    @debug   = debug
    @file    = location.nil? ? false : true
    @console = console
    @location = location
    @logfile = logfile.lambda? ? logfile : (-> { "#{logfile}" } )
    @paused  = false
    @defaultCR = carriage
    @outputMonitor = Monitor.new
    @outputQueue = Queue.new
    @block   = block.to_proc if block_given?
    system("mkdir -p #{location}") unless location.nil? or File.exist?(location)
    spawn_output
  end

  # Convenience method, accepts a second parameter to force carriage return
  # (while \\r in-line also is accepted)
  #
  # @param chunk [printable Object]
  # @param cr    [Boolean] for carriage return
  def puts(chunk = "", cr: @defaultCR)
      self.out(chunk: chunk, newline: true, cr: cr)
  end

  # (see #puts) 
  def puts!(chunk = "", cr: @defaultCR)
    self.out!(chunk: chunk, newline: true, cr: cr)
  end

  # (see #puts)
  def print(chunk = "", cr: @defaultCR)
      self.out(chunk: chunk, newline: false, cr: cr)
  end

  # (see #puts)
  def print!(chunk =  "", cr: @defaultCR)
    self.out!(chunk: chunk, newline: false, cr: cr)
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

  alias_method :resume, :unpause

  # Flushes currently suspended output.
  #
  # @param silent [Boolean] If set to true, flushes to /dev/null, else 
  # to configured output(s).
  def flush(silent: false)
    while not outputQueue.empty?
      el = outputQueue.pop
      self.out!(**el) unless silent
    end
  end

  # Provides inspection
  #
  def inspect
    arr = []
    tmpQueue = Queue.new
    while not @outputQueue.empty?
      el = @outputQueue.pop
      arr << el
      tmpQueue << el
    end
    @outputQueue = tmpQueue
    return "<#OutputHandler:0x#{self.object_id.to_s(16)}, paused: #{@paused}, queueLength: #{@outputQueue.size}, outputQueue: #{arr.inspect}>"
  end

  private

  attr_reader :console, :logfile, :location, :file, :outputQueue, :debug

  # Sends next chunk to outputs. Will be queued if #paused, otherwise
  # sent to output(s).
  #
  # @param chunk [printable Object]
  # @param newline [Boolean] Indicates whether (default) or not to end
  # line with a newline character.
  def out(chunk: "", newline: true, cr: false)
    outputQueue << { chunk: chunk, newline: newline, cr: cr }
  end

  # Sends next chunk to output(s) directly, regardless of #paused.
  #
  # @param (see #out)
  def out!(chunk: "", newline: true, cr: false)
    binding.irb if debug
    superprint("#{cr ? "\r" : ""
               }#{chunk.chomp
               }#{newline ? "\n" : ""}") if console
    File.open("#{location}/#{logfile.call}",'a+'){|f| f.write "#{cr ? "\r" : ""
                                        }#{chunk.chomp
                                        }#{newline ? "\n" : "" }" }  if file
    @block.call(chunk) if @block.is_a? Proc
  end

  # Spawns output thread
  # @!visibility private
  def spawn_output
    @outputThread = Thread.new do
      loop do
        if self.paused?
          sleep 0.1
        else
          o = outputQueue.pop
          out!(**o)
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
