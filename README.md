# class OutputHandler

## Usage:

    user:~/$ irb
    "Loading irbrc"
    2.5.1 :001 > require 'outputhandler'
    2.5.1 :002 > o = OutputHandler.new
    2.5.1 :003 > o.out "01: Lore ipsum dolor sit amet"
    01: Lore ipsum dolor sit amet
    2.5.1 :004 > o.pause
    2.5.1 :005 > o.out  "02: consectetuer adipiscing elit"
    2.5.1 :006 > o.out! "03: Aliquam hendrerit mi posuere lectus"
    03: Aliquam hendrerit mi posuere lectus
    2.5.1 :007 > o.flush
    02: consectetuer adipiscing elit
    2.5.1 :008 > o.out  "04: Vestibulum enim wisi"
    2.5.1 :009 > o.out! "05: viverra nec, fringilla in"
    05: viverra nec, fringilla in
    2.5.1 :010 > o.unpause
    04: Vestibulum enim wisi
    o.out  "06: laoreet vitae, risus."
    06: laoreet vitae, risus.


