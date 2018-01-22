;;;; package.lisp
;;;;
;;;; Copyright (c) 2018 Jeremiah LaRocco <jeremiah_larocco@fastmail.com>

(defpackage #:simple-png
  (:nicknames :sp)
  (:use #:cl)
  (:export

   #:create-png
   #:read-png
   #:write-png

   #:set-channel
   #:get-channel

   #:set-rgb
   #:get-rgb

   #:set-rgba
   #:get-rgba

   #:increment-pixel
   #:increment-channel
   #:increment-red
   #:increment-green
   #:increment-blue
   #:increment-alpha))
