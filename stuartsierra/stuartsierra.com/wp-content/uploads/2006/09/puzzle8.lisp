;;;; puzzle8.lisp

;;; by Stuart Sierra <mail@stuartsierra.com>

;;; released September 10, 2006

;;; Copyright (c) 2006 Stuart Sierra.

;;; This program is free software; you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 2 of the License, or
;;; (at your option) any later version.

;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.

;;; You should have received a copy of the GNU General Public License
;;; along with this program; if not, write to the Free Software
;;; Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA



;;; This is a simple implementation of the classic "8 Puzzle," a
;;; 3-by-3 grid of sliding blocks.  The blocks are numbered 0 through
;;; 7; there is one empty space.  The objective of the game is to
;;; place the blocks in order by moving one block at a time into an
;;; adjacent empty space.

;;; The grid is stored and manipulated as a list of integers.  The
;;; symbol B is the hole.  So this grid:

;;; 0 1 2
;;; 3 4 5
;;; 6   7

;;; Is represented as the list (0 1 2 3 4 5 6 b 7)

;;; Example usage:

;;; CL-USER> (breadth-first-search '(0 1 2 3 4 5 6 b 7))
;;; "Found (0 1 2 3 4 5 6 7 B) in 3 steps.
;;; Expanded 9 nodes, stored a maximum of 5 nodes."


(defun hole (grid)
  "Return integer index into GRID at which the 'hole' is located."
  (position 'b grid))

(defun col (pair)
  (car pair))

(defun row (pair)
  (cdr pair))

(defun coords (index)
  "Transform INDEX, an integer index into the list, into an (X . Y)
coordinate pair for a 3x3 grid."
  (cons (second (multiple-value-list (floor index 3)))
	(floor index 3)))

(defun index (coords)
  "Transform COORDS, an (X . Y) coordinate pair for a 3x3 grid, into
an integer index."
  (+ (col coords)
     (* 3 (row coords))))

(defun swap (a b list)
  "Return a new list equivalent to LIST but with the items at indexes
A and B swapped."
  (let ((new (copy-seq list)))
    (setf (nth a new)
	  (nth b list))
    (setf (nth b new)
	  (nth a list))
    new))

(defun right (grid)
  "Move the 'hole' on the 3x3 GRID one space to the right.  If there
is no space to the right, return NIL."
  (let ((hole (coords (hole grid))))
    (if (= 2 (col hole))
	nil
	(swap (index hole)
	      (index (cons (1+ (col hole)) (row hole)))
	      grid))))

(defun left (grid)
  "Move the 'hole' on the 3x3 GRID one space to the left.  If there
is no space to the left, return NIL."
  (let ((hole (coords (hole grid))))
    (if (zerop (col hole))
	nil
	(swap (index hole)
	      (index (cons (1- (col hole)) (row hole)))
	      grid))))

(defun up (grid)
  "Move the 'hole' on the 3x3 GRID one space up.  If there is no space
up, return NIL."
  (let ((hole (coords (hole grid))))
    (if (zerop (row hole))
	nil
	(swap (index (cons (col hole) (1- (row hole))))
	      (index hole)
	      grid))))

(defun down (grid)
  "Move the 'hole' on the 3x3 GRID one space down.  If there is no
space down, return NIL."
  (let ((hole (coords (hole grid))))
    (if (= 2 (row hole))
	nil
	(swap (index (cons (col hole) (1+ (row hole))))
	      (index hole)
	      grid))))

(defun successors (grid)
  "Return a list of new grids consisting of all possible moves from
GRID."
  (delete nil (list (up grid)
		    (down grid)
		    (left grid)
		    (right grid))))

(defun finished? (grid)
  "Return T if GRID is in perfect order with the 'hole' at the end,
NIL otherwise."
  (equal grid '(0 1 2 3 4 5 6 7 b)))

(defun breadth-first-search (start)
  (let ((open (list start)) ; the list of nodes to be examined
	(closed (list)) ; the list of nodes already examined
	(steps 0) ; number of iterations
	(expanded 0) ; total number of nodes expanded
	(stored 0)) ; max number of nodes stored at any one time
    (loop while open do
	  (let ((x (pop open))) 
	    (when (finished? x)
	      (return (format nil "Found ~a in ~a steps.
Expanded ~a nodes, stored a maximum of ~a nodes." x steps expanded stored)))
	    (incf steps)
	    (pushnew x closed :test #'equal)
	    (let ((successors (successors x)))
	      (incf expanded (length successors))
	      (setq successors
		    (delete-if (lambda (a)
				 (or (find a open :test #'equal)
				     (find a closed :test #'equal)))
			       successors))
	      (setq open (append open successors))
	      (setq stored (max stored (length open))))))))

(defun depth-first-search (start)
  "Identical to breadth-first, but successor nodes are added to the
*end* of OPEN instead of the beginning."
  (let ((open (list start)) 
	(closed (list))
	(steps 0)
	(expanded 0)
	(stored 0))
    (loop while open do
	  (let ((x (pop open))) 
	    (when (finished? x)
	      (return (format nil "Found ~a in ~a steps.
Expanded ~a nodes, stored a maximum of ~a nodes." x steps expanded stored)))
	    (incf steps)
	    (pushnew x closed :test #'equal)
	    (let ((successors (successors x)))
	      (incf expanded (length successors))
	      (setq successors
		    (delete-if (lambda (a)
				 (or (find a open :test #'equal)
				     (find a closed :test #'equal)))
			       successors))
	      (setq open (append open successors))
	      (setq stored (max stored (length open))))))))

