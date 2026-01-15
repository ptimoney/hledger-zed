; Code outline for hledger
; Shows transactions and directives in the outline panel

; Transactions - show date and description in outline
(transaction
  (transaction_header
    date: (date) @context
    description: (description) @name)) @item

; Account declarations
(account_directive
  "account" @context
  name: (account) @name) @item

; Commodity declarations
(commodity_directive
  "commodity" @context
  symbol: (commodity) @name) @item

; Include directives
(include_directive
  "include" @context
  path: (file_path) @name) @item

; Payee declarations
(payee_directive
  "payee" @context
  name: (payee_name) @name) @item

; Tag declarations
(tag_directive
  "tag" @context
  name: (tag_name) @name) @item
