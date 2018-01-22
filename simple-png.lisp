;;;; simple-png.lisp
;;;;
;;;; Copyright (c) 2018 Jeremiah LaRocco <jeremiah_larocco@fastmail.com>

(in-package #:simple-png)

(declaim (inline create-png
                 read-png
                 write-png
                 set-rgb
                 set-rgba
                 get-rgb
                 get-rgba
                 increment-pixel
                 increment-channel
                 increment-red
                 increment-blue
                 increment-green
                 increment-alpha))

(defun read-png (file-name)
  "Read a PNG image file into memory."
  (declare (type simple-string file-name))
  (png:decode-file file-name :preserve-alpha t))

(defun create-png (width height &key (channels 3) (bit-depth 8))
  "Create a PNG image object."
  (declare (type fixnum width height channels bit-depth))
  (png:make-image height width channels bit-depth))

(defun write-png (png file-name &key (direction :output ) (if-exists :supersede))
  "Write a PNG image to the named file."
  (declare (type (simple-array (unsigned-byte 8)) png)
           (type simple-string file-name))
  (with-open-file (output file-name :element-type '(unsigned-byte 8) :direction direction :if-exists if-exists)
    (png:encode png output)))

(defun set-channel (png x y channel val)
  "Set the value of specified channel at location x y to value."
  (declare (type fixnum x y channel val))
  (declare (type (simple-array (unsigned-byte 8)) png))
  (setf (aref png x y channel) val))

(defun get-channel (png x y channel)
  "Return the value of the specified channel at location x y."
  (declare (type fixnum x y channel))
  (declare (type (simple-array (unsigned-byte 8)) png))
  (aref png x y channel))

(defun set-rgb (png x y r g b)
  "Set a pixel in im at location x,y to color (r,g,b)"
  (declare (type fixnum x y r g b))
  (declare (type (simple-array (unsigned-byte 8)) png))
  (setf (aref png x y 0) r)
  (setf (aref png x y 1) g)
  (setf (aref png x y 2) b))

(defun get-rgb (png x y)
  "Set a pixel in im at location x,y to color (r,g,b)"
  (declare (type fixnum x y))
  (declare (type (simple-array (unsigned-byte 8)) png))
  (values (aref png x y 0)
          (aref png x y 1)
          (aref png x y 2)))

(defun set-rgba (png x y r g b a)
  "Set a pixel in im at location x,y to color (r,g,b)"
  (declare (type fixnum x y r g b a))
  (declare (type (simple-array (unsigned-byte 8)) png))
  (setf (aref png x y 0) r)
  (setf (aref png x y 1) g)
  (setf (aref png x y 2) b)
  (setf (aref png x y 3) a))

(defun get-rgba (png x y)
  "Get red, green, blue, and alpha values "
  (declare (type fixnum x y))
  (declare (type (simple-array (unsigned-byte 8)) png))
  (values (aref png x y 0)
          (aref png x y 1)
          (aref png x y 2)
          (aref png x y 3)))

(defun increment-pixel (png x y cnt)
  "Increment each color component of the pixel in png at location x,y by 1"
  (declare (type fixnum x y cnt))
  (declare (type (simple-array (unsigned-byte 8)) png))
  (let ((max-val (if (= (png:image-bit-depth png) 8) 255 65535)))
    (when (and (<= (+ (aref png y x 0) cnt) max-val)
               (<= (+ (aref png y x 1) cnt) max-val)
               (<= (+ (aref png y x 2) cnt) max-val))
      (incf (aref png y x 0) cnt)
      (incf (aref png y x 1) cnt)
      (incf (aref png y x 2) cnt))))

(defun increment-channel (png x y channel cnt)
  (declare (type fixnum x y cnt))
  (declare (type (simple-array (unsigned-byte 8)) png))
  (let ((max-val (if (= (png:image-bit-depth png) 8)
                     255
                     65535))
        (inc-val (+ (aref png y x channel) cnt)))
    (when (and (<= inc-val max-val) (>= inc-val 0))
      (setf (aref png y x channel) inc-val))))

(defun increment-red (png x y cnt)
  "Increment each color component of the pixel in png at location x,y by 1"
  (declare (type fixnum x y cnt))
  (declare (type (simple-array (unsigned-byte 8)) png))
  (increment-channel png x y 0 cnt))

(defun increment-green (png x y cnt)
  "Increment each color component of the pixel in png at location x,y by 1"
  (declare (type fixnum x y cnt))
  (declare (type (simple-array (unsigned-byte 8)) png))
  (increment-channel png x y 1 cnt))

(defun increment-blue (png x y cnt)
  "Increment each color component of the pixel in png at location x,y by 1"
  (declare (type fixnum x y cnt))
  (declare (type (simple-array (unsigned-byte 8)) png))
  (increment-channel png x y 2 cnt))

(defun increment-alpha (png x y cnt)
  "Increment each color component of the pixel in png at location x,y by 1"
  (declare (type fixnum x y cnt))
  (declare (type (simple-array (unsigned-byte 8)) png))
  (increment-channel png x y 3 cnt))
