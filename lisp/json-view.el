;;; json-view.el --- Light-Weight JSON-Viewer 
;;; $Author: tv.raman.tv $
;;; Description:  Light-weight JSON viewer
;;; Keywords: Emacspeak,  Audio Desktop JSON, Data Exploration
;;{{{  LCD Archive entry:

;;; LCD Archive Entry:
;;; emacspeak| T. V. Raman |raman@cs.cornell.edu
;;; A speech interface to Emacs |
;;; $Date: 2007-05-03 18:13:44 -0700 (Thu, 03 May 2007) $ |
;;;  $Revision: 4532 $ |
;;; Location undetermined
;;;

;;}}}
;;{{{  Copyright:
;;;Copyright (C) 1995 -- 2007, 2011, T. V. Raman
;;; Copyright (c) 1994, 1995 by Digital Equipment Corporation.
;;; All Rights Reserved.
;;;
;;; This file is not part of GNU Emacs, but the same permissions apply.
;;;
;;; GNU Emacs is free software; you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 2, or (at your option)
;;; any later version.
;;;
;;; GNU Emacs is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITN<SKELETON> FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with GNU Emacs; see the file COPYING.  If not, write to
;;; the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.

;;}}}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;{{{  introduction

;;; Commentary:
;;;json-viewer.el: View, Explore JSON data 

;;}}}
;;{{{  Required modules

(require 'cl)
(declaim  (optimize  (safety 0) (speed 3)))
(require 'json)
(require 'derived)

;;}}}
;;{{{  json-view-mode:

(define-derived-mode json-view-mode special-mode
                     "JSON Interaction."
  "View, Explore JSON-encoded data on the Emacspeak Audio Desktop."
  (let ((inhibit-read-only t)
        (start (point)))
    (goto-char (point-min))
    ))
(defvar json-view-buffer-name "*JSON Viewer"
"Name of buffer used to view JSON data.")
(defvar json-view--data nil
  "Buffer local handle to data being viewed.")

(make-variable-buffer-local 'json-view--data)
;;;###autoload
(defun json-view (json)
  "Launch a viewer for data in json.
`json' is the parsed representation of a JSON data structure."
  (interactive (list (read-minibuffer "JSON: ")))
  (declare (special json-view--data))
  (let ((buffer (get-buffer-create json-view-buffer-name))
        (inhibit-read-only  t))
    (with-current-buffer buffer
    (kill-all-local-variables)
    (erase-buffer)
    (json-view-mode)
    (setq json-view--data json)
    (cond
     ((listp json)
      (insert "<dict>\n"))
     ((vectorp json)
      (insert "<array>\n"))
     (t (insert "atom?"))))
    (switch-to-buffer buffer)))

;;}}}
(provide 'json-view)
;;{{{ end of file

;;; local variables:
;;; folded-file: t
;;; byte-compile-dynamic: t
;;; end:

;;}}}
