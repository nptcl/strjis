# strjis

strjis is a japanese text reader
from JIS, EUC-JIS, SHIFT-JIS, UTF-8, and any Unicode encodings
in Common Lisp.


## Function

```
(coerce-list x :input input-encoding :output output-encoding)
(coerce-vector x :input input-encoding :output output-encoding)
(coerce-string x :input input-encoding :output output-encoding)
(coerce-stream x output-stream :input input-encoding :output output-encoding)
```

x: `(or vector list string stream)`

input-encoding: `utf8`, `ascii`,
`jis`, `iso2022jp`, `eucjp`, `eucjis`, `shiftjis`, `unicode`,
`utf16`, `utf16v`, `utf16be`, `utf16le`,
`utf32`, `utf32v`, `utf32be`, `utf32le`

output-encoding: `ascii`,
`jis`, `iso2022jp`, `eucjp`, `eucjis`, `shiftjis`, `unicode`,
`utf8`, `utf8bom`, `utf8no`,
`utf16`, `utf16v`, `utf16be`, `utf16le`, `utf16bebom`, `utf16lebom`,
`utf32`, `utf32v`, `utf32be`, `utf32le`, `utf32bebom`, `utf32lebom`


## Example

### Translate from JIS vector to UTF-8 list.

```
(coerce-list
  #(#x1B #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26)
  :input 'jis :output 'utf8)
-> (227 129 130 227 129 132 227 129 134)
```


### Translate from SHIFT-JIS list to UTF-8 BOM vector.

```
(coerce-vector
  '(#x82 #xA0 #x82 #xA2 #x82 #xA4)
  :input 'shiftjis :output 'utf8bom)
-> #(239 187 191 227 129 130 227 129 132 227 129 134)
```


### Translate from Unicode string to EUC-JIS list.

```
(coerce-list "あいう" :output 'eucjis)
-> (164 162 164 164 164 166)
```


### Translate from JIS list to Unicode string.

```
(coerce-string
  '(#x1B #x24 #x42  #x24 #x22  #x24 #x24  #x24 #x26)
  :input 'jis)
-> "あいう"
```


### Translate from a text file to UTF-16BE file.

```
(with-open-file (input #p"input.txt" :direction :input)
  (with-open-file (output #p"output.txt" :direction :output
                          :if-exists :supersede
                          :if-does-not-exist :create
                          :element-type '(unsigned-byte 8))
    (coerce-stream input output :output 'utf16be)))
```


### Translate from EUC-JIS file to SHIFT-JIS file.

```
(with-open-file (input #p"input.txt" :direction :input
                       :element-type '(unsigned-byte 8))
  (with-open-file (output #p"output.txt" :direction :output
                          :if-exists :supersede
                          :if-does-not-exist :create
                          :element-type '(unsigned-byte 8))
    (coerce-stream input output :input 'eucjis :output 'shiftjis)))
```


## License

[The Unlicense](LICENSE)


## Distribution

https://github.com/nptcl/strjis

