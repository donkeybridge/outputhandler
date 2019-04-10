# OutputHandler

A wrapper class for ruby, that allows output to be paused. Output can be send to console, to a logfile or both.

## Description

An OutputHandler instance provides #print and #puts, behaving like commonly used IO::print and IO::puts, 
except that these do not accept _\*args_ but only one chunk to be output. 
And it behaves this way as long as #pause is not triggered. With output being paused, chunks sent to the 
instance will wait until either #unpause or #flush are triggered.

At any time, using #print! or #puts! will output directly. 

When using #pause(_limit_), the output is paused for _limit_ seconds (e.g. when printing a help message in a
fluent stream). 

\#print(!) and \#puts(!) allow a second argument of type Boolean, that adds a carriage return to the beginning of the chunk (e.g. for displaying a progressbar). Please note, that alike IO::print, you probably want to add whitespace to overwrite the entire previous output. 

OutputHandler.new is the same as OutputHandler.new(console: true, logfile: nil).

To discard currently queued output, use #flush(_true_).


## Installation

    gem install outputhandler

## Usage example:

    user:~/$ irb
    "Loading irbrc"
    2.5.1 :001 > require 'outputhandler'
    2.5.1 :002 > o = OutputHandler.new
    2.5.1 :003 > o.print "01: Lore ipsum dolor sit amet"
    01: Lore ipsum dolor sit amet2.5.1 :004 > o.pause
    2.5.1 :005 > o.puts  "02: consectetuer adipiscing elit"
    2.5.1 :006 > o.puts! "03: Aliquam hendrerit mi posuere lectus"
    03: Aliquam hendrerit mi posuere lectus
    2.5.1 :007 > o.flush
    02: consectetuer adipiscing elit
    2.5.1 :008 > o.puts  "04: Vestibulum enim wisi"
    2.5.1 :009 > o.puts! "05: viverra nec, fringilla in"
    05: viverra nec, fringilla in
    2.5.1 :010 > o.unpause
    04: Vestibulum enim wisi
    2.5.1 :011 > o.puts  "06: laoreet vitae, risus."
    06: laoreet vitae, risus.


