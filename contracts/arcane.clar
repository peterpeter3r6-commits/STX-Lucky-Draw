(impl-trait 'SP3FBR2AGK5H9QBDH3EEN6DF8EK8JY7RX8QJ5SVTE.sip-010-trait-ft-standard.sip-010-trait)

(define-fungible-token arcane-ticket u1000000)

(define-constant ERR-ZERO-AMOUNT (err u100))
(define-constant ERR-NOT-AUTHORIZED (err u101))
(define-constant ERR-MAX-REACHED (err u102))

;; Track user contributions (e.g., STX donated to project)
(define-map contributions
    principal
    uint
)

;; Total STX collected
(define-data-var total-stx uint u0)

;; Contribute STX to the Arcane Project
(define-public (contribute (stx-amount uint))
    (let (
            (caller tx-sender)
            (current-total (var-get total-stx))
            (current-contrib (default-to u0 (map-get? contributions caller)))
            (new-tickets (/ stx-amount u100)) ;; 100 uSTX = 1 ticket
        )
        (asserts! (> stx-amount u0) ERR-ZERO-AMOUNT)
        (asserts! (<= (+ (ft-get-supply arcane-ticket) new-tickets) u1000000)
            ERR-MAX-REACHED
        )
        (try! (stx-transfer? stx-amount tx-sender (as-contract tx-sender)))
        (map-set contributions caller (+ current-contrib stx-amount))
        (var-set total-stx (+ current-total stx-amount))
        (try! (ft-mint? arcane-ticket new-tickets caller))
        (ok new-tickets)
    )
)

;; SIP-010 implementations for Arcane Ticket
(define-read-only (get-name)
    (ok "Arcane Ticket")
)

(define-read-only (get-symbol)
    (ok "ARC-TKT")
)

(define-read-only (get-decimals)
    (ok u6)
)

(define-read-only (get-balance (account principal))
    (ok (ft-get-balance arcane-ticket account))
)

(define-read-only (get-total-supply)
    (ok (ft-get-supply arcane-ticket))
)

(define-read-only (get-token-uri)
    (ok none)
)

(define-public (transfer
        (amount uint)
        (sender principal)
        (recipient principal)
        (memo (optional (buff 34)))
    )
    (begin
        (asserts! (is-eq tx-sender sender) ERR-NOT-AUTHORIZED)
        (try! (ft-transfer? arcane-ticket amount sender recipient))
        (match memo
            to-print (print to-print)
            0x
        )
        (ok true)
    )
)