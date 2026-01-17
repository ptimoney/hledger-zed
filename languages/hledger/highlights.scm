; Transaction dates
(date) @keyword.date

; Status markers
(status) @keyword.modifier

; Transaction codes
(code) @string.special

; Descriptions
(description) @string

; Account names
(account) @type

; Amounts - quantities and commodities
(quantity) @number
(commodity) @string.special.symbol

; Amount signs
(sign) @operator

; Directives
"account" @keyword.directive
"commodity" @keyword.directive
"include" @keyword.import
"payee" @keyword.directive
"tag" @keyword.directive

; Directive values
(payee_name) @string
(file_path) @string.special

; Comments
(line_comment) @comment
(block_comment) @comment
(inline_comment) @comment

; Operators and punctuation
"=" @operator
"@" @operator
"@@" @operator
"(" @punctuation.bracket
")" @punctuation.bracket

; Tags
(tag_name) @tag
(tag_value) @property
