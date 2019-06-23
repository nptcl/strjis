(defpackage #:strjis
  (:use #:cl)
  (:export
    #:*recovery-ascii*
    #:*recovery-jis*
    #:*recovery-shiftjis*
    #:*recovery-eucjis*
    #:*recovery-unicode*
    #:*recovery-check*
    #:*eol-0a*
    #:*eol-0d*
    #:*eol-0d0a*
    #:*kana-iso2022jp*
    #:*kana-shift*

    #:ascii
    #:jis
    #:iso2022jp
    #:eucjp
    #:eucjis
    #:shiftjis
    #:utf8
    #:utf8bom
    #:utf8no
    #:utf16
    #:utf16v
    #:utf16le
    #:utf16be
    #:utf16lebom
    #:utf16bebom
    #:utf32
    #:utf32v
    #:utf32le
    #:utf32be
    #:utf32lebom
    #:utf32bebom
    #:unicode
    #:eol2

    #:coerce-list
    #:coerce-vector
    #:coerce-string
    #:coerce-stream

    #:east-asian-symbol
    #:east-asian-width
    #:east-asian-length
    ))

