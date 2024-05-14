;;; hash-lib.el -- hash library

;; Copyright (C) 2012
;; (mukaer atmark gmail period com)

;; This file is NOT a part of GNU Emacs.

;;; Code:

(eval-when-compile (require 'cl))

(defun list-to-hash (arg)
  (let (
        (reshash  (make-hash-table :test 'equal))
        (j        (/ (length arg) 2)))
    (dotimes (i j)
      (let (
            (key (nth (* i 2)  arg))
            (val (nth (+ 1 (* i 2)) arg)))
        (if (typep val 'list)
            ;; true
            (let (
                  (reshash_sub (list-to-hash (car(cdr val)))))
              (puthash (nth (* i 2)  arg) reshash_sub reshash))
          ;; false
          (puthash key val  reshash))
        ))
    reshash))


(defun dump-hash (hash &optional indent)
  (let (
        (cnt (if indent (1+ indent) 0))
        (hash hash))

    (with-temp-buffer
      (loop for key being the hash-keys of hash using (hash-values val)
            do
            (insert
             (make-string (* 8 cnt) ? )
             (format "%s => " key )
             (if  (typep val 'hash-table)
                 ;; true
                 (concat  "\n" (dump-hash val  cnt ) " \n")
               ;; false
               (concat (format "%s ,\n" val ))))
            finally (delete-backward-char 2))
      (buffer-string))))


(defun append-hash (hash &rest rhash)
  (let (
        (res_hash (copy-hash-table hash )))
    (dolist (var_hash rhash)
      (loop for key being the hash-keys of var_hash using (hash-values val)
            do (puthash key val res_hash)))
    res_hash))


(defun get-hash (hash &rest rest)
  (let (
        (first   (car rest))
        (second  (cdr rest))
        (arghash  hash))
    (if second
        ;; second true
        (let (
              (reshash (gethash first arghash)))
          (if reshash
              (get-hash reshash second)
            nil))
      ;; second false
      (if (typep first 'list)
          ;; type first true
          (let (
                (first (car first))
                (second (cdr first))
                (reshash (gethash  (car first) arghash)))
            (if second
                (get-hash reshash  second)
              reshash))

        ;; type first false
        (gethash first arghash)))))

(provide 'hash-lib)
