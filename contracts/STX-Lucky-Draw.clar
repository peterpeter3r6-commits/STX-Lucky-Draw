;; contracts/lucky-draw.clar
;; STX Lucky Draw - decentralized lottery game

(define-data-var ticket-price uint u10)   ;; 10 STX per ticket
(define-data-var pot uint u0)             ;; total pot collected
(define-data-var ticket-count uint u0)    ;; total tickets sold
(define-data-var game-id uint u0)         ;; tracks rounds

(define-map tickets
  { game: uint, id: uint }
  { player: principal }
)

(define-constant ERR-NO-TICKETS u100)
(define-constant ERR-NOT-ENOUGH-STX u101)
(define-constant ERR-NOT-OWNER u102)

(define-data-var contract-owner principal tx-sender)

;; 🎟️ Buy a ticket
(define-public (buy-ticket)
  (begin
    (let ((price (var-get ticket-price)))
      (as-contract (stx-transfer? price tx-sender (contract-caller)))
      (let ((id (+ u1 (var-get ticket-count))))
        (var-set ticket-count id)
        (map-set tickets { game: (var-get game-id), id: id } { player: tx-sender })
        (var-set pot (+ (var-get pot) price))
        (ok id)
      )
    )
  )
)

;; 🎉 Draw winner (only owner can trigger)
(define-public (draw-winner)
  (begin
    (asserts! (is-eq tx-sender (var-get contract-owner)) (err ERR-NOT-OWNER))
    (asserts! (> (var-get ticket-count) u0) (err ERR-NO-TICKETS))

    ;; pseudo-random winner based on block height
    (let (
      (winner-id (+ u1 (mod block-height (var-get ticket-count))))
      (pot-size (var-get pot))
      (winner (unwrap-panic (map-get? tickets { game: (var-get game-id), id: winner-id })))
    )
      (begin
        (as-contract (stx-transfer? pot-size (contract-caller) (get player winner)))
        ;; reset for next round
        (var-set game-id (+ u1 (var-get game-id)))
        (var-set pot u0)
        (var-set ticket-count u0)
        (ok (get player winner))
      )
    )
  )
)

;; --- read-only views ---
(define-read-only (get-pot) (var-get pot))
(define-read-only (get-ticket-count) (var-get ticket-count))
(define-read-only (get-ticket (game uint) (id uint)) (map-get? tickets { game: game, id: id }))
