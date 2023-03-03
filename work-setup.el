;;; work-setup.el -*- lexical-binding: t; -*-

(cl-defstruct work-setup-dev
  workspace-name
  path
  (cmd nil :type cons))

(setq dev-list
      (list (make-work-setup-dev
             :workspace-name "newton-hs"
             :path "~/work/newton-hs")
            (make-work-setup-dev
             :workspace-name "npci-mocking"
             :path "~/work/npci-mocking"
             :cmd '("nvm use 8" "node app.js"))
            (make-work-setup-dev
             :workspace-name "pgres"
             :path "~/"
             :cmd '("pgres" "\\x"))
            (make-work-setup-dev
             :workspace-name "redis-cli"
             :path "~/"
             :cmd '("redis-cli"))
            (make-work-setup-dev
             :workspace-name "ghci"
             :path "~/"
             :cmd '("ghci"))))

(defun abshekh/get-workspaces ()
  (+workspace-list-names))

(defun abshekh/start-and-run-in-term (cmd term-name)
  (vterm term-name)
  (mapc #'(lambda (x) (progn
                        (term-send-raw-string x)
                        (vterm-send-return))) cmd)
  (evil-escape))

(defun abshekh/create-project-workspace (workspaces workspace-name workspace-path &optional &key cmd)
  (unless (member workspace-name workspaces)
    (progn
      (+workspace/new workspace-name)
      (find-file workspace-path)
      (when cmd
        (abshekh/start-and-run-in-term cmd (concat workspace-name "-term"))))))

(defun abshekh/delete-project-workspace (workspaces workspace-name)
  (let ((kill-buffer-query-functions nil))
    (when (member workspace-name workspaces)
      (+workspace-delete workspace-name))))

(defun abshekh/setup-dev ()
  (interactive)
  (let
      ((workspaces (abshekh/get-workspaces)))
    (mapc #'(lambda (x) (abshekh/create-project-workspace
                         workspaces
                         (work-setup-dev-workspace-name x)
                         (work-setup-dev-path x)
                         :cmd (work-setup-dev-cmd x))) dev-list)
    (+workspace-switch (work-setup-dev-workspace-name (car dev-list)))))


(defun abshekh/flush-dev ()
  (interactive)
  (let
      ((workspaces (abshekh/get-workspaces)))
    (mapc #'(lambda (x) (abshekh/delete-project-workspace
                         workspaces
                         (work-setup-dev-workspace-name x))) dev-list)
    (+workspace/cycle 1)))
