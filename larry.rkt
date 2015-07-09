;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname larry-walks-columns) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require 2htdp/image)
(require 2htdp/universe)

;; Larry walks - control him using the arrow keys.
;; Please note that running the program may take a while, and makes DrRacket a bit sluggish.
;; Please be patient!
;; Also, apologies for the cumbersome creation of images from primitives.
;; Start the program with (main LARRY-START).

;; =================
;; Helper function for constant definition

;; Number Color -> Image
;; produce a solid rectangle of width 6 and the specified height and color

(check-expect (box 5 "black") (rectangle 6 5 "solid" "black"))
(check-expect (box 12 "pink") (rectangle 6 12 "solid" "pink"))

;(define (box h c) (rectangle 6 2 "solid" "black"))  ;stub

(define (box h c) (rectangle 6 h "solid" c))

;; =================
;; Constants:

(define WIDTH 600)
(define HEIGHT 450)
(define CTR-X (/ WIDTH 2))
(define CTR-Y (/ HEIGHT 2))
(define SPEED 4)
(define TICK-RATE 0.07)
(define MTS (empty-scene WIDTH HEIGHT "pink"))

; Colors for Larry images.
(define clr0 (make-color 0 0 0 0))
(define clr1 (make-color 0 0 0 255))
(define clr2 (make-color 255 255 255 255))
(define clr3 (make-color 252 252 252 255))
(define clr4 (make-color 168 168 168 255))
(define clr5 (make-color 252 84 84 255))
(define clr6 (make-color 168 0 0 255))

; Building blocks for Larry images.
(define col-0 (box 102 clr0))
(define col-1 (above (box 9 clr0) (box 15 clr1) (box 9 clr0) (box 12 clr3) (box 9 clr4) (box 3 clr5) (box 45 clr0)))
(define col-2 (above (box 3 clr0) (box 24 clr1) (box 3 clr0) (box 3 clr1) (box 36 clr3) (box 3 clr4) (box 9 clr3) (box 6 clr1) (box 15 clr0)))
(define col-3 (above (box 3 clr0) (box 24 clr1) (box 3 clr5) (box 3 clr1) (box 36 clr3) (box 33 clr0)))
(define col-4 (above (box 3 clr0) (box 24 clr1) (box 3 clr0) (box 3 clr1) (box 36 clr3) (box 3 clr4) (box 21 clr3) (box 6 clr1) (box 3 clr0)))
(define col-5 (above (box 6 clr0) (box 18 clr1) (box 9 clr0) (box 18 clr3) (box 9 clr4) (box 3 clr5) (box 39 clr0)))
(define col-6 (above (box 9 clr0) (box 15 clr1) (box 9 clr0) (box 15 clr3) (box 12 clr4) (box 3 clr5) (box 39 clr0)))
(define col-7 (above (box 3 clr0) (box 24 clr1) (box 3 clr0) (box 3 clr1) (box 36 clr3) (box 3 clr4) (box 18 clr3) (box 6 clr1) (box 6 clr0)))
(define col-8 (above (box 6 clr0) (box 18 clr1) (box 9 clr0) (box 27 clr3) (box 6 clr5) (box 36 clr0)))
(define col-9 (above (box 9 clr0) (box 15 clr1) (box 9 clr0) (box 18 clr3) (box 9 clr4) (box 3 clr5) (box 39 clr0)))
(define col-10 (above (box 3 clr0) (box 24 clr1) (box 3 clr0) (box 3 clr1) (box 36 clr3) (box 3 clr4) (box 15 clr3) (box 6 clr1) (box 9 clr0)))
(define col-11 (above (box 6 clr0) (box 18 clr1) (box 9 clr0) (box 15 clr3) (box 6 clr4) (box 3 clr5) (box 45 clr0)))
(define col-12 (above (box 9 clr0) (box 15 clr1) (box 9 clr0) (box 21 clr3) (box 6 clr4) (box 3 clr5) (box 39 clr0)))
(define col-13 (above (box 6 clr0) (box 18 clr1) (box 9 clr0) (box 12 clr3) (box 12 clr4) (box 3 clr5) (box 42 clr0)))
(define col-14 (above (box 6 clr0) (box 18 clr1) (box 9 clr0) (box 15 clr3) (box 15 clr4) (box 3 clr5) (box 36 clr0)))
(define col-15 (above (box 6 clr0) (box 12 clr1) (box 3 clr5) (box 6 clr1) (box 6 clr0) (box 30 clr3) (box 39 clr0)))
(define col-16 (above (box 3 clr0) (box 3 clr1) (box 6 clr5) (box 3 clr1) (box 15 clr5) (box 3 clr1) (box 24 clr3) (box 3 clr4) (box 6 clr5) (box 3 clr4) (box 21 clr3) (box 6 clr1) (box 6 clr0)))
(define col-17 (above (box 3 clr0) (box 6 clr1) (box 15 clr5) (box 3 clr6) (box 6 clr5) (box 24 clr1) (box 9 clr4) (box 36 clr0)))
(define col-18 (above (box 3 clr0) (box 6 clr1) (box 3 clr5) (box 3 clr1) (box 15 clr5) (box 3 clr1) (box 6 clr3) (box 3 clr1) (box 21 clr3) (box 3 clr4) (box 27 clr3) (box 6 clr1) (box 3 clr0)))
(define col-19 (above (box 9 clr0) (box 9 clr1) (box 3 clr5) (box 6 clr1) (box 6 clr0) (box 27 clr3) (box 6 clr5) (box 36 clr0)))
(define col-20 (above (box 6 clr0) (box 12 clr1) (box 3 clr5) (box 6 clr1) (box 6 clr0) (box 18 clr3) (box 3 clr4) (box 3 clr3) (box 45 clr0)))
(define col-21 (above (box 3 clr0) (box 3 clr1) (box 6 clr5) (box 3 clr1) (box 15 clr5) (box 3 clr1) (box 18 clr3) (box 3 clr4) (box 6 clr5) (box 6 clr4) (box 15 clr3) (box 6 clr1) (box 15 clr0)))
(define col-22 (above (box 9 clr0) (box 9 clr1) (box 3 clr5) (box 6 clr1) (box 6 clr0) (box 15 clr3) (box 9 clr4) (box 3 clr5) (box 42 clr0)))
(define col-23 (above (box 6 clr0) (box 12 clr1) (box 3 clr5) (box 6 clr1) (box 6 clr0) (box 27 clr3) (box 6 clr5) (box 36 clr0)))
(define col-24 (above (box 3 clr0) (box 3 clr1) (box 6 clr5) (box 3 clr1) (box 15 clr5) (box 3 clr1) (box 30 clr3) (box 3 clr4) (box 24 clr3) (box 6 clr1) (box 6 clr0)))
(define col-25 (above (box 3 clr0) (box 6 clr1) (box 15 clr5) (box 3 clr6) (box 6 clr5) (box 27 clr1) (box 6 clr4) (box 36 clr0)))
(define col-26 (above (box 6 clr0) (box 12 clr1) (box 3 clr5) (box 6 clr1) (box 6 clr0) (box 18 clr3) (box 6 clr4) (box 6 clr5) (box 39 clr0)))
(define col-27 (above (box 3 clr0) (box 3 clr1) (box 6 clr5) (box 3 clr1) (box 15 clr5) (box 3 clr1) (box 30 clr3) (box 3 clr4) (box 27 clr3) (box 6 clr1) (box 3 clr0)))
(define col-28 (above (box 3 clr0) (box 6 clr1) (box 3 clr5) (box 3 clr1) (box 15 clr5) (box 3 clr1) (box 6 clr3) (box 3 clr1) (box 12 clr3) (box 9 clr5) (box 3 clr4) (box 21 clr3) (box 6 clr1) (box 9 clr0)))
(define col-29 (above (box 9 clr0) (box 9 clr1) (box 3 clr5) (box 6 clr1) (box 6 clr0) (box 18 clr3) (box 3 clr4) (box 6 clr3) (box 42 clr0)))
(define col-30 (above (box 6 clr0) (box 12 clr1) (box 3 clr5) (box 6 clr1) (box 6 clr0) (box 9 clr3) (box 12 clr4) (box 3 clr5) (box 45 clr0)))
(define col-31 (above (box 3 clr0) (box 6 clr1) (box 3 clr5) (box 3 clr1) (box 15 clr5) (box 3 clr1) (box 6 clr3) (box 3 clr1) (box 6 clr3) (box 9 clr5) (box 6 clr3) (box 3 clr4) (box 15 clr3) (box 6 clr1) (box 15 clr0)))
(define col-32 (above (box 9 clr0) (box 9 clr1) (box 3 clr5) (box 6 clr1) (box 6 clr0) (box 15 clr3) (box 3 clr4) (box 3 clr3) (box 48 clr0)))
(define col-33 (above (box 3 clr0) (box 6 clr1) (box 3 clr5) (box 3 clr1) (box 15 clr5) (box 3 clr1) (box 6 clr3) (box 3 clr1) (box 9 clr3) (box 3 clr4) (box 9 clr5) (box 3 clr4) (box 21 clr3) (box 6 clr1) (box 9 clr0)))
(define col-34 (above (box 9 clr0) (box 9 clr1) (box 3 clr5) (box 6 clr1) (box 6 clr0) (box 21 clr3) (box 3 clr4) (box 3 clr3) (box 42 clr0)))
(define col-35 (above (box 15 clr0) (box 6 clr5) (box 30 clr0) (box 6 clr5) (box 45 clr0)))
(define col-36 (above (box 6 clr0) (box 3 clr1) (box 3 clr6) (box 3 clr1) (box 12 clr5) (box 24 clr0) (box 6 clr3) (box 12 clr0) (box 15 clr3) (box 9 clr0) (box 3 clr1) (box 6 clr0)))
(define col-37 (above (box 3 clr0) (box 6 clr1) (box 3 clr6) (box 18 clr5) (box 3 clr0) (box 18 clr1) (box 6 clr3) (box 6 clr1) (box 6 clr4) (box 3 clr3) (box 9 clr0) (box 9 clr3) (box 3 clr1) (box 9 clr0)))
(define col-38 (above (box 3 clr0) (box 15 clr1) (box 3 clr6) (box 12 clr5) (box 3 clr1) (box 21 clr3) (box 3 clr4) (box 9 clr3) (box 3 clr4) (box 9 clr3) (box 15 clr0) (box 3 clr1) (box 3 clr0)))
(define col-39 (above (box 3 clr0) (box 30 clr1) (box 12 clr3) (box 12 clr4) (box 12 clr3) (box 9 clr0) (box 18 clr3) (box 3 clr1) (box 3 clr0)))
(define col-40 (above (box 6 clr0) (box 21 clr1) (box 15 clr0) (box 12 clr4) (box 48 clr0)))
(define col-41 (above (box 15 clr0) (box 6 clr5) (box 24 clr0) (box 6 clr5) (box 45 clr0) (box 3 clr1) (box 3 clr0)))
(define col-42 (above (box 6 clr0) (box 3 clr1) (box 3 clr6) (box 3 clr1) (box 12 clr5) (box 18 clr0) (box 6 clr3) (box 18 clr0) (box 27 clr3) (box 3 clr1) (box 3 clr0)))
(define col-43 (above (box 3 clr0) (box 6 clr1) (box 3 clr6) (box 18 clr5) (box 3 clr0) (box 12 clr1) (box 6 clr3) (box 12 clr1) (box 9 clr4) (box 30 clr0)))
(define col-44 (above (box 3 clr0) (box 15 clr1) (box 3 clr6) (box 12 clr5) (box 3 clr1) (box 15 clr3) (box 3 clr4) (box 15 clr3) (box 3 clr4) (box 9 clr3) (box 21 clr0)))
(define col-45 (above (box 3 clr0) (box 30 clr1) (box 9 clr3) (box 9 clr4) (box 18 clr3) (box 9 clr0) (box 12 clr3) (box 6 clr0) (box 3 clr1) (box 3 clr0)))
(define col-46 (above (box 6 clr0) (box 21 clr1) (box 12 clr0) (box 9 clr4) (box 6 clr0) (box 6 clr5) (box 27 clr0) (box 9 clr3) (box 3 clr1) (box 3 clr0)))
(define col-47 (above (box 42 clr0) (box 12 clr4) (box 3 clr1) (box 45 clr0)))
(define col-48 (above (box 15 clr0) (box 6 clr5) (box 27 clr0) (box 6 clr5) (box 48 clr0)))
(define col-49 (above (box 6 clr0) (box 3 clr1) (box 3 clr6) (box 3 clr1) (box 12 clr5) (box 21 clr0) (box 6 clr3) (box 42 clr0) (box 3 clr1) (box 3 clr0)))
(define col-50 (above (box 3 clr0) (box 6 clr1) (box 3 clr6) (box 18 clr5) (box 3 clr0) (box 15 clr1) (box 6 clr3) (box 9 clr1) (box 9 clr4) (box 24 clr3) (box 3 clr1) (box 3 clr0)))
(define col-51 (above (box 3 clr0) (box 15 clr1) (box 3 clr6) (box 12 clr5) (box 3 clr1) (box 18 clr3) (box 6 clr4) (box 9 clr3) (box 3 clr4) (box 9 clr3) (box 21 clr0)))
(define col-52 (above (box 3 clr0) (box 30 clr1) (box 6 clr3) (box 15 clr4) (box 15 clr3) (box 9 clr0) (box 9 clr3) (box 9 clr0) (box 3 clr1) (box 3 clr0)))
(define col-53 (above (box 6 clr0) (box 21 clr1) (box 12 clr0) (box 15 clr4) (box 30 clr0) (box 9 clr3) (box 3 clr1) (box 6 clr0)))
(define col-54 (box 105 clr0))
(define col-55 (above (box 15 clr0) (box 6 clr5) (box 33 clr0) (box 6 clr5) (box 45 clr0)))
(define col-56 (above (box 6 clr0) (box 3 clr1) (box 3 clr6) (box 3 clr1) (box 12 clr5) (box 27 clr0) (box 6 clr3) (box 9 clr0) (box 15 clr3) (box 21 clr0)))
(define col-57 (above (box 3 clr0) (box 6 clr1) (box 3 clr6) (box 18 clr5) (box 3 clr0) (box 21 clr1) (box 6 clr3) (box 3 clr1) (box 9 clr4) (box 9 clr0) (box 6 clr3) (box 12 clr0) (box 3 clr1) (box 3 clr0)))
(define col-58 (above (box 3 clr0) (box 15 clr1) (box 3 clr6) (box 12 clr5) (box 3 clr1) (box 21 clr3) (box 3 clr4) (box 9 clr3) (box 3 clr4) (box 27 clr3) (box 3 clr1) (box 3 clr0)))
(define col-59 (above (box 3 clr0) (box 30 clr1) (box 6 clr3) (box 18 clr4) (box 12 clr3) (box 15 clr0) (box 12 clr1) (box 9 clr0)))
(define col-60 (above (box 6 clr0) (box 21 clr1) (box 78 clr0)))
(define col-61 (above (box 15 clr0) (box 6 clr5) (box 81 clr0)))
(define col-62 (above (box 6 clr0) (box 3 clr1) (box 3 clr6) (box 3 clr1) (box 12 clr5) (box 21 clr0) (box 9 clr5) (box 12 clr0) (box 15 clr3) (box 6 clr0) (box 6 clr1) (box 6 clr0)))
(define col-63 (above (box 3 clr0) (box 6 clr1) (box 3 clr6) (box 18 clr5) (box 3 clr0) (box 30 clr1) (box 9 clr4) (box 9 clr0) (box 9 clr3) (box 3 clr1) (box 9 clr0)))
(define col-64 (above (box 3 clr0) (box 15 clr1) (box 3 clr6) (box 12 clr5) (box 3 clr1) (box 15 clr3) (box 3 clr4) (box 6 clr5) (box 3 clr4) (box 6 clr3) (box 3 clr4) (box 9 clr3) (box 15 clr0) (box 3 clr1) (box 3 clr0)))
(define col-65 (above (box 3 clr0) (box 30 clr1) (box 15 clr3) (box 3 clr4) (box 9 clr3) (box 3 clr4) (box 6 clr3) (box 9 clr0) (box 18 clr3) (box 3 clr1) (box 3 clr0)))
(define col-66 (above (box 6 clr0) (box 21 clr1) (box 12 clr0) (box 15 clr3) (box 48 clr0)))
(define col-67 (above (box 6 clr0) (box 3 clr1) (box 3 clr6) (box 3 clr1) (box 12 clr5) (box 18 clr0) (box 6 clr4) (box 18 clr0) (box 27 clr3) (box 3 clr1) (box 3 clr0)))
(define col-68 (above (box 3 clr0) (box 6 clr1) (box 3 clr6) (box 18 clr5) (box 3 clr0) (box 30 clr1) (box 9 clr4) (box 30 clr0)))
(define col-69 (above (box 3 clr0) (box 15 clr1) (box 3 clr6) (box 12 clr5) (box 3 clr1) (box 33 clr3) (box 3 clr4) (box 9 clr3) (box 21 clr0)))
(define col-70 (above (box 3 clr0) (box 30 clr1) (box 15 clr3) (box 6 clr4) (box 6 clr5) (box 3 clr4) (box 6 clr3) (box 9 clr0) (box 12 clr3) (box 6 clr0) (box 3 clr1) (box 3 clr0)))
(define col-71 (above (box 6 clr0) (box 21 clr1) (box 12 clr0) (box 9 clr3) (box 3 clr0) (box 6 clr3) (box 30 clr0) (box 9 clr3) (box 3 clr1) (box 3 clr0)))
(define col-72 (above (box 42 clr0) (box 12 clr3) (box 48 clr0)))
(define col-73 (above (box 6 clr0) (box 3 clr1) (box 3 clr6) (box 3 clr1) (box 12 clr5) (box 18 clr0) (box 3 clr4) (box 6 clr5) (box 42 clr0) (box 3 clr1) (box 3 clr0)))
(define col-74 (above (box 3 clr0) (box 6 clr1) (box 3 clr6) (box 18 clr5) (box 3 clr0) (box 30 clr1) (box 9 clr4) (box 24 clr3) (box 3 clr1) (box 3 clr0)))
(define col-75 (above (box 3 clr0) (box 15 clr1) (box 3 clr6) (box 12 clr5) (box 3 clr1) (box 18 clr3) (box 3 clr4) (box 6 clr5) (box 3 clr4) (box 3 clr3) (box 3 clr4) (box 9 clr3) (box 21 clr0)))
(define col-76 (above (box 3 clr0) (box 30 clr1) (box 18 clr3) (box 3 clr4) (box 6 clr3) (box 3 clr4) (box 6 clr3) (box 9 clr0) (box 9 clr3) (box 9 clr0) (box 3 clr1) (box 3 clr0)))
(define col-77 (above (box 6 clr0) (box 21 clr1) (box 12 clr0) (box 18 clr3) (box 27 clr0) (box 6 clr3) (box 6 clr1) (box 6 clr0)))
(define col-78 (above (box 12 clr0) (box 6 clr5) (box 33 clr0) (box 6 clr5) (box 45 clr0)))
(define col-79 (above (box 3 clr0) (box 3 clr1) (box 3 clr6) (box 3 clr1) (box 12 clr5) (box 27 clr0) (box 6 clr3) (box 9 clr0) (box 15 clr3) (box 21 clr0)))
(define col-80 (above (box 6 clr1) (box 3 clr6) (box 18 clr5) (box 3 clr0) (box 18 clr1) (box 9 clr3) (box 3 clr1) (box 9 clr4) (box 9 clr0) (box 6 clr3) (box 12 clr0) (box 3 clr1) (box 3 clr0)))
(define col-81 (above (box 15 clr1) (box 3 clr6) (box 12 clr5) (box 3 clr1) (box 21 clr3) (box 3 clr4) (box 9 clr3) (box 3 clr4) (box 27 clr3) (box 3 clr1) (box 3 clr0)))
(define col-82 (above (box 30 clr1) (box 15 clr3) (box 9 clr4) (box 12 clr3) (box 15 clr0) (box 12 clr1) (box 9 clr0)))
(define col-83 (above (box 3 clr0) (box 21 clr1) (box 78 clr0)))

; Larry walking up.
(define LARRY-UP-A (freeze (beside col-0 col-1 col-2 col-3 col-4 col-5 col-0)))
(define LARRY-UP-B (freeze (beside col-0 col-6 col-7 col-3 col-4 col-8 col-0)))
(define LARRY-UP-C (freeze (beside col-0 col-9 col-4 col-3 col-10 col-11 col-0)))
(define LARRY-UP-D (freeze (beside col-0 col-12 col-4 col-3 col-2 col-11 col-0)))
(define LARRY-UP-E (freeze (beside col-0 col-12 col-4 col-3 col-10 col-13 col-0)))
(define LARRY-UP-F (freeze (beside col-0 col-12 col-7 col-3 col-4 col-14 col-0)))

; Larry walking down.
(define LARRY-DOWN-A (freeze (beside col-0 col-15 col-16 col-17 col-18 col-19 col-0)))
(define LARRY-DOWN-B (freeze (beside col-0 col-20 col-21 col-17 col-18 col-22 col-0)))
(define LARRY-DOWN-C (freeze (beside col-0 col-23 col-24 col-25 col-18 col-19 col-0)))
(define LARRY-DOWN-D (freeze (beside col-0 col-26 col-27 col-25 col-28 col-29 col-0)))
(define LARRY-DOWN-E (freeze (beside col-0 col-30 col-27 col-17 col-31 col-32 col-0)))
(define LARRY-DOWN-F (freeze (beside col-0 col-26 col-27 col-17 col-33 col-34 col-0)))

; Larry walking left.
(define LARRY-LEFT-A (freeze (beside col-0 col-35 col-36 col-37 col-38 col-39 col-40 col-0)))
(define LARRY-LEFT-B (freeze (beside col-0 col-41 col-42 col-43 col-44 col-45 col-46 col-47)))
(define LARRY-LEFT-C (freeze (beside col-0 col-48 col-49 col-50 col-51 col-52 col-53 col-0)))
(define LARRY-LEFT-D (freeze (beside col-54 col-55 col-56 col-57 col-58 col-59 col-60 col-54)))
(define LARRY-LEFT-E (freeze (beside col-0 col-61 col-62 col-63 col-64 col-65 col-66 col-0)))
(define LARRY-LEFT-F (freeze (beside col-0 col-41 col-67 col-68 col-69 col-70 col-71 col-72)))
(define LARRY-LEFT-G (freeze (beside col-0 col-61 col-73 col-74 col-75 col-76 col-77 col-0)))
(define LARRY-LEFT-H (freeze (beside col-0 col-78 col-79 col-80 col-81 col-82 col-83 col-0)))

; Larry walking right.
(define LARRY-RIGHT-A (freeze (beside col-0 col-40 col-39 col-38 col-37 col-36 col-35 col-0)))
(define LARRY-RIGHT-B (freeze (beside col-47 col-46 col-45 col-44 col-43 col-42 col-41 col-0)))
(define LARRY-RIGHT-C (freeze (beside col-0 col-53 col-52 col-51 col-50 col-49 col-48 col-0)))
(define LARRY-RIGHT-D (freeze (beside col-54 col-60 col-59 col-58 col-57 col-56 col-55 col-54)))
(define LARRY-RIGHT-E (freeze (beside col-0 col-66 col-65 col-64 col-63 col-62 col-61 col-0)))
(define LARRY-RIGHT-F (freeze (beside col-72 col-71 col-70 col-69 col-68 col-67 col-41 col-0)))
(define LARRY-RIGHT-G (freeze (beside col-0 col-77 col-76 col-75 col-74 col-73 col-61 col-0)))
(define LARRY-RIGHT-H (freeze (beside col-0 col-83 col-82 col-81 col-80 col-79 col-78 col-0)))


;; =================
;; Data definitions:

;; Direction is one of:
;;  - "up"
;;  - "down"
;;  - "left"
;;  - "right"
;; interp. the direction Larry walks.

;; <examples are redundant for enumerations>

#;
(define (fn-for-direction d)
  (cond [(string=? "up" d) (...)]
        [(string=? "down" d) (...)]
        [(string=? "left" d) (...)]
        [(string=? "right" d) (...)]))

;; Template rules used:
;;  - one of: 4 cases
;;  - atomic distinct: "up"
;;  - atomic distinct: "down"
;;  - atomic distinct: "left"
;;  - atomic distinct: "right"


;; Step is Natural[0, 7]
;; interp. the current step of Larry in the animation
;;         there are 8 steps when moving in x-direction
;;         there are 6 steps when moving in y-direction

(define S1 0)  ; first step
(define S2 5)  ; last step when moving in y-direction
(define S3 7)  ; last step when moving in x-direction

#;
(define (fn-for-step s)
  (... s))

;; Template rules used:
;;  - atomic non-distinct: Natural[0, 7]


(define-struct larry (x y moving dir step))
;; Larry is (make-larry Natural Natural Boolean Direction Step)
;; interp. Larry walking at position x, y in direction dir
;;         and he is at the specified step in the animation
;;         He is standing still if moving is false

(define LARRY-1 (make-larry 60 10 true "up" 4))               ;moving up, step 4 in animation
(define LARRY-2 (make-larry 40 40 true "left" 6))             ;moving left, at step 6 in animation
(define LARRY-START (make-larry CTR-X CTR-Y false "right" 0)) ;facing right (not moving), at step 0 in animation

#;
(define (fn-for-larry l)
  (... (larry-x l)       ;Natural
       (larry-y l)       ;Natural
       (larry-moving l)  ;Boolean
       (larry-dir l)     ;Direction
       (larry-step l)))  ;Step

;; Template rules used:
;;  - compound: 5 fields

;; =================
;; Functions:

;; Larry -> Larry
;; start the world with (main LARRY-START) 
;; 
(define (main l)
  (big-bang l                                 ; Larry
            (name "Return of the Lounge Lizard")
            (on-tick   move-larry TICK-RATE)  ; Larry -> Larry
            (to-draw   render-larry)          ; Larry -> Image
            (on-key    handle-key)))          ; Larry KeyEvent -> Larry

;; Larry -> Larry
;; produce the next larry based on direction and current x, y position.

(check-expect (move-larry (make-larry 20 30 true "right" 0)) (make-larry (+ 20 SPEED) 30 true "right" 1))  ;move SPEED right, increase step
(check-expect (move-larry (make-larry 50 50 true "left" 5))  (make-larry (- 50 SPEED) 50 true "left" 6))   ;move SPEED left, increase step
(check-expect (move-larry (make-larry 44 12 true "right" 7)) (make-larry (+ 44 SPEED) 12 true "right" 0))  ;move SPEED right, go to first step

(check-expect (move-larry (make-larry 20 30 true "up" 0))    (make-larry 20 (- 30 SPEED) true "up" 1))     ;move SPEED up, increase step
(check-expect (move-larry (make-larry 60 22 true "down" 5))  (make-larry 60 (+ 22 SPEED) true "down" 0))   ;move SPEED right, increase step

(check-expect (move-larry (make-larry 20 30 false "up" 0))   (make-larry 20 30 false "up" 0))     ;not moving
(check-expect (move-larry (make-larry 60 22 false "down" 5)) (make-larry 60 22 false "down" 5))   ;not moving

;(define (move-larry l) LARRY-START) ;stub

;<use template from Larry>

(define (move-larry l)
  (cond
    [(not (larry-moving l)) l]
    [(string=? "up"    (larry-dir l)) 
     (make-larry (larry-x l) (- (larry-y l) SPEED) (larry-moving l) (larry-dir l) (next-y-step (larry-step l)))]
    [(string=? "down"  (larry-dir l)) 
     (make-larry (larry-x l) (+ (larry-y l) SPEED) (larry-moving l) (larry-dir l) (next-y-step (larry-step l)))]
    [(string=? "left"  (larry-dir l)) 
     (make-larry (- (larry-x l) SPEED) (larry-y l) (larry-moving l) (larry-dir l) (next-x-step (larry-step l)))]
    [(string=? "right" (larry-dir l)) 
     (make-larry (+ (larry-x l) SPEED) (larry-y l) (larry-moving l) (larry-dir l) (next-x-step (larry-step l)))]))

;; Step -> Step
;; produce the next animation step for a vertically-moving larry, vertical steps are Number[0,7]

(check-expect (next-x-step 0) 1) ;first
(check-expect (next-x-step 5) 6) ;middle
(check-expect (next-x-step 7) 0) ;last

;(define (next-x-step s) 0)  ;stub

;<use template from Step>
(define (next-x-step s)
  (if (< s 7) (+ s 1) 0))

;; Step -> Step
;; produce the next animation step for a horizontally-moving larry.

(check-expect (next-y-step 0) 1) ;first
(check-expect (next-y-step 3) 4) ;middle
(check-expect (next-y-step 5) 0) ;last

;(define (next-y-step s) 0)  ;stub

;<use template from Step>
(define (next-y-step s)
  (if (< s 5) (+ s 1) 0))

;; Larry -> Image
;; render the appropriate image of Larry on the scene

(check-expect (render-larry (make-larry 0 0 true "up" 0)) 
              (place-image LARRY-UP-A 0 0 MTS)) 
(check-expect (render-larry (make-larry 0 0 true "down" 0)) 
              (place-image LARRY-DOWN-A 0 0 MTS)) 
(check-expect (render-larry (make-larry 140 180 false "left" 5)) 
              (place-image LARRY-LEFT-F 140 180 MTS)) 
(check-expect (render-larry (make-larry 290 222 false "right" 3)) 
              (place-image LARRY-RIGHT-D 290 222 MTS)) 

;(define (render-larry l) l) ;stub

;<use template from Larry>
(define (render-larry l)
  (place-image (choose-larry l) 
               (larry-x l)
               (larry-y l)
               MTS))

;; Larry -> Image
;; render the appropriate image of Larry on the scene

(check-expect (choose-larry (make-larry 0 0 true "up" 0)) LARRY-UP-A)
(check-expect (choose-larry (make-larry 0 0 false "down" 0)) LARRY-DOWN-A)
(check-expect (choose-larry (make-larry 140 true 180 "left" 5)) LARRY-LEFT-F)
(check-expect (choose-larry (make-larry 290 false 222 "right" 3)) LARRY-RIGHT-D)

;(define (choose-larry l) LARRY-UP-A)  ;stub

;<use template from Larry>
(define (choose-larry l)
  (cond [(string=? "up"    (larry-dir l)) (choose-up    (larry-step l))]
        [(string=? "down"  (larry-dir l)) (choose-down  (larry-step l))]
        [(string=? "left"  (larry-dir l)) (choose-left  (larry-step l))]
        [(string=? "right" (larry-dir l)) (choose-right (larry-step l))]))

;; Step -> Image
;; render the appropriate image of Larry walking up

(check-expect (choose-up 0) LARRY-UP-A)
(check-expect (choose-up 1) LARRY-UP-B)
(check-expect (choose-up 2) LARRY-UP-C)
(check-expect (choose-up 3) LARRY-UP-D)
(check-expect (choose-up 4) LARRY-UP-E)
(check-expect (choose-up 5) LARRY-UP-F)

;(define (choose-up s) LARRY-UP-A)  ;stub

;<use template from Step>
(define (choose-up s)
  (cond [(= 0 s) LARRY-UP-A]
        [(= 1 s) LARRY-UP-B]
        [(= 2 s) LARRY-UP-C]
        [(= 3 s) LARRY-UP-D]
        [(= 4 s) LARRY-UP-E]
        [(= 5 s) LARRY-UP-F]))


;; Step -> Image
;; render the appropriate image of Larry walking down

(check-expect (choose-down 0) LARRY-DOWN-A)
(check-expect (choose-down 1) LARRY-DOWN-B)
(check-expect (choose-down 2) LARRY-DOWN-C)
(check-expect (choose-down 3) LARRY-DOWN-D)
(check-expect (choose-down 4) LARRY-DOWN-E)
(check-expect (choose-down 5) LARRY-DOWN-F)

;(define (choose-down s) LARRY-DOWN-A)  ;stub

;<use template from Step>
(define (choose-down s)
  (cond [(= 0 s) LARRY-DOWN-A]
        [(= 1 s) LARRY-DOWN-B]
        [(= 2 s) LARRY-DOWN-C]
        [(= 3 s) LARRY-DOWN-D]
        [(= 4 s) LARRY-DOWN-E]
        [(= 5 s) LARRY-DOWN-F]))


;; Step -> Image
;; render the appropriate image of Larry walking left

(check-expect (choose-left 0) LARRY-LEFT-A)
(check-expect (choose-left 1) LARRY-LEFT-B)
(check-expect (choose-left 2) LARRY-LEFT-C)
(check-expect (choose-left 3) LARRY-LEFT-D)
(check-expect (choose-left 4) LARRY-LEFT-E)
(check-expect (choose-left 5) LARRY-LEFT-F)
(check-expect (choose-left 6) LARRY-LEFT-G)
(check-expect (choose-left 7) LARRY-LEFT-H)

;(define (choose-left s) LARRY-LEFT-A)  ;stub

;<use template from Step>
(define (choose-left s)
  (cond [(= 0 s) LARRY-LEFT-A]
        [(= 1 s) LARRY-LEFT-B]
        [(= 2 s) LARRY-LEFT-C]
        [(= 3 s) LARRY-LEFT-D]
        [(= 4 s) LARRY-LEFT-E]
        [(= 5 s) LARRY-LEFT-F]
        [(= 6 s) LARRY-LEFT-G]
        [(= 7 s) LARRY-LEFT-H]))

;; Step -> Image
;; render the appropriate image of Larry walking right

(check-expect (choose-right 0) LARRY-RIGHT-A)
(check-expect (choose-right 1) LARRY-RIGHT-B)
(check-expect (choose-right 2) LARRY-RIGHT-C)
(check-expect (choose-right 3) LARRY-RIGHT-D)
(check-expect (choose-right 4) LARRY-RIGHT-E)
(check-expect (choose-right 5) LARRY-RIGHT-F)
(check-expect (choose-right 6) LARRY-RIGHT-G)
(check-expect (choose-right 7) LARRY-RIGHT-H)

;(define (choose-right s) LARRY-RIGHT-A)  ;stub

;<use template from Step>
(define (choose-right s)
  (cond [(= 0 s) LARRY-RIGHT-A]
        [(= 1 s) LARRY-RIGHT-B]
        [(= 2 s) LARRY-RIGHT-C]
        [(= 3 s) LARRY-RIGHT-D]
        [(= 4 s) LARRY-RIGHT-E]
        [(= 5 s) LARRY-RIGHT-F]
        [(= 6 s) LARRY-RIGHT-G]
        [(= 7 s) LARRY-RIGHT-H]))

;; Larry KeyEvent -> Larry
;; use keys to alter the direction Larry walks in, resetting animation step in the process, or making him stop
;;  - up, down, left, right arrow to move in those directions
;;  - pressing the same arrow key twice stops Larry
;;  - space bar to center Larry (direction remains unchanged)

(check-expect (handle-key (make-larry 20 20 true "up" 1) "down")    (make-larry 20 20 true "down" 0))     ;moving up -> moving down
(check-expect (handle-key (make-larry 30 30 false "up" 2) "left")   (make-larry 30 30 true "left" 0))     ;facing up -> moving left
(check-expect (handle-key (make-larry 84 48 true "down" 3) "right") (make-larry 84 48 true "right" 0))    ;moving down -> moving right
(check-expect (handle-key (make-larry 84 50 true "up" 4) "up")      (make-larry 84 50 false "up" 0))      ;moving up -> facing up
(check-expect (handle-key (make-larry 84 50 false "up" 4) "up")     (make-larry 84 50 true "up" 0))       ;facing up -> moving up
(check-expect (handle-key (make-larry WIDTH 0 true "up" 5) " ")     (make-larry CTR-X CTR-Y true "up" 0)) ;space

;(define (handle-key l ke) l)  ;stub

;; <use template from design recipe>

(define (handle-key l ke)
  (cond [(key=? ke " ") 
         (make-larry CTR-X CTR-Y (larry-moving l) (larry-dir l) 0)]
        [(key=? ke "up") 
         (make-larry (larry-x l) (larry-y l) (next-moving l "up") "up" 0)]
        [(key=? ke "down") 
         (make-larry (larry-x l) (larry-y l) (next-moving l "down") "down" 0)]
        [(key=? ke "left") 
         (make-larry (larry-x l) (larry-y l) (next-moving l "left") "left" 0)]
        [(key=? ke "right") 
         (make-larry (larry-x l) (larry-y l) (next-moving l "right") "right" 0)]))

;; Larry Direction -> Boolean
;; produce true if Larry should be moving (he was standing still or changed direction)

(check-expect (next-moving (make-larry 0 0 true "up" 0) "up") false)  ;moving and same direction
(check-expect (next-moving (make-larry 0 0 false "up" 0) "up") true)  ;standing still
(check-expect (next-moving (make-larry 0 0 true "up" 0) "down") true) ;change direction

;(define (next-moving l d) d)  ;stub

; <use template from Larry>

(define (next-moving l d)
  (not (and (larry-moving l) (string=? d (larry-dir l)))))

(main LARRY-START)
