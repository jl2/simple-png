;;;; simple-png.asd
;;;;
;;;; Copyright (c) 2018 Jeremiah LaRocco <jeremiah_larocco@fastmail.com>

(asdf:defsystem #:simple-png
  :description "Simple library to manipulate PNG images."
  :author "Jeremiah LaRocco <jeremiah_larocco@fastmail.com>"
  :license "ISC (BSD-like)"
  :depends-on (#:png)
  :serial t
  :components ((:file "package")
               (:file "simple-png")))

