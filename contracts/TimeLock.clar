;; contracts/timelock.clar
;; TimeLock - STX vault with unlock time

(define-map vaults
  { owner: principal }
  { amount: uint, unlock-height: uint }
)

(define-constant ERR-NO-VAULT u100)
(define-constant ERR-TOO-SOON u101)

;; Deposit STX with unlock block-height
(define-public (lock (unlock-height uint))
  (let ((current (map-get? vaults { owner: tx-sender })))
    (begin
      (map-set vaults { owner: tx-sender }
        { amount: (stx-get-transfer-amount)
        , unlock-height: unlock-height })
      (ok true)
    )
  )
)

;; Withdraw after unlock time
(define-public (withdraw)
  (let ((vault (map-get? vaults { owner: tx-sender })))
    (begin
      (asserts! (is-some vault) (err ERR-NO-VAULT))
      (let ((data (unwrap-panic vault)))
        (asserts! (>= block-height (get unlock-height data)) (err ERR-TOO-SOON))
        (stx-transfer? (get amount data) (as-contract tx-sender) tx-sender)
      )
    )
  )
)

;; View vault details
(define-read-only (get-vault (who principal))
  (map-get? vaults { owner: who })
)
