;; -*- lexical-binding: t -*-

(setq gc-cons-threshold most-positive-fixnum)

(setq package-enable-at-startup nil)
(setenv "LSP_USE_PLISTS" "true")

(setq load-prefer-newer t)

(setq auto-mode-case-fold nil)
(prefer-coding-system 'utf-8)

(setq-default native-comp-async-report-warnings-errors nil
              native-comp-jit-compilation t
              package-native-compile t)

(setq frame-inhibit-implied-resize t)

(setq pgtk-wait-for-event-timeout 0.001)

(setq native-comp-async-query-on-exit t)
(setq confirm-kill-processes t)

(setq inhibit-compacting-font-caches t)

(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(when (featurep 'ns)
  (push '(ns-transparent-titlebar . t) default-frame-alist))
(setq-default mode-line-format nil)


(provide 'early-init)
;;; early-init.el ends here.
