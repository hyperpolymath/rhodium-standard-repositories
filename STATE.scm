;;; STATE.scm — rhodium-standard-repositories
;; SPDX-License-Identifier: AGPL-3.0-or-later
;; SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell

(define metadata
  '((version . "0.2.0") (updated . "2025-12-17") (project . "rhodium-standard-repositories")))

(define current-position
  '((phase . "v0.2 - Standards & Security Hardening")
    (overall-completion . 65)
    (components
      ((documentation ((status . "complete") (completion . 100)))
       (ci-cd-workflows ((status . "complete") (completion . 100)))
       (security-hardening ((status . "complete") (completion . 100)))
       (well-known-standards ((status . "complete") (completion . 100)))
       (nix-flake ((status . "complete") (completion . 100)))
       (examples ((status . "partial") (completion . 70)))
       (tooling ((status . "planned") (completion . 20)))
       (guix-package ((status . "planned") (completion . 0)))))))

(define blockers-and-issues
  '((critical ())
    (high-priority
      (("Add guix.scm package definition" . "RSR requires Guix primary, Nix fallback")))))

(define critical-next-actions
  '((immediate
      (("Add guix.scm" . high)
       ("Implement rhodium-validate tool" . high)))
    (this-week
      (("Expand rhodium-minimal example" . medium)
       ("Add more template examples" . medium)))))

(define session-history
  '((snapshots
      ((date . "2025-12-15") (session . "initial") (notes . "SCM files added"))
      ((date . "2025-12-17") (session . "security-review") (notes . "SHA-pinned all GitHub Actions, updated workflows")))))

(define state-summary
  '((project . "rhodium-standard-repositories") (completion . 65) (blockers . 0) (updated . "2025-12-17")))
