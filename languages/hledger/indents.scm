; Indentation rules for hledger
; Postings inside transactions should be indented

; Indent after transaction header
(transaction_header) @indent

; Dedent after the last posting
(dedent) @outdent
