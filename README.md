# class OutputHandler

## Usage:

  o = OutputHandler.new
  o.out "01: Lore ipsum dolor sit amet"
  >> 01: Lore ipsum dolor sit amet
  o.pause 
  o.out  "02: consectetuer adipiscing elit"
  o.out! "03: Aliquam hendrerit mi posuere lectus"
  >> 03: Aliquam hendrerit mi posuere lectus
  o.flush 
  >> 02: consectetuer adipiscing elit
  o.out  "04: Vestibulum enim wisi"
  o.out! "05: viverra nec, fringilla in"
  >> 05: viverra nec, fringilla in
  o.unpause 
  >> 04: Vestibulum enim wisi
  o.out  "06: laoreet vitae, risus."
  >> 06: laoreet vitae, risus.


