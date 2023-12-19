
; We want both `source.svelte` and `text.html.svelte` over the whole document.
(document) @text.html.svelte

; We adjust downward from the elements instead of scoping against `raw_text`
; because otherwise we'd miss the leading whitespace inside the tag. This would
; cause us to use the wrong comment delimiters when auto-commenting the first
; line of the embedded code.

; This catches `<style lang="scss">` by checking that at least one attribute
; value exactly matches "scss". I can't imagine this ever producing a false
; positive.
((style_element
  (start_tag
    (attribute
      (quoted_attribute_value
        (attribute_value) @_IGNORE_
          (#eq? @_IGNORE_ "scss")))))
          @meta.embedded.block.scss.html.svelte
          (#set! adjust.startAfterFirstMatchOf ">")
          (#set! adjust.endAfterFirstMatchOf "</style>")
          (#set! test.final true))

((style_element) @meta.embedded.block.css.html.svelte
  (#set! adjust.startAfterFirstMatchOf ">")
  (#set! adjust.endAfterFirstMatchOf "</style>"))


((script_element
  (start_tag
    (attribute
      (quoted_attribute_value
        (attribute_value) @_IGNORE_
          (#eq? @_IGNORE_ "ts")))))
          @meta.embedded.block.ts.html.svelte
          (#set! adjust.startAfterFirstMatchOf ">")
          (#set! adjust.endAfterFirstMatchOf "</script>")
          (#set! test.final true))

((script_element) @meta.embedded.block.js.html.svelte
  (#set! adjust.startAfterFirstMatchOf ">")
  (#set! adjust.endAfterFirstMatchOf "</script>$"))

; COMMENTS
; ========

(comment) @comment.block.html.svelte

((comment) @punctuation.definition.comment.begin.html.svelte
  (#set! adjust.startAndEndAroundFirstMatchOf "^<!--"))

((comment) @punctuation.definition.comment.end.html.svelte
  (#set! adjust.startAndEndAroundFirstMatchOf "-->$"))


; SUPPORT
; =======

(start_tag
  (tag_name) @entity.name.tag.structure._TEXT_.html.svelte
  (#match? @entity.name.tag.structure._TEXT_.html.svelte "^(body|head|html|BODY|HEAD|HTML)$")
  (#set! test.final true))

(end_tag
  (tag_name) @entity.name.tag.structure._TEXT_.html.svelte
  (#match? @entity.name.tag.structure._TEXT_.html.svelte "^(body|head|html|BODY|HEAD|HTML)$")
  (#set! test.final true))

(start_tag
  (tag_name) @entity.name.tag.block._TEXT_.html.svelte
  (#match? @entity.name.tag.block._TEXT_.html.svelte "^(address|blockquote|dd|div|section|article|aside|header|footer|nav|menu|dl|dt|fieldset|form|frame|frameset|h1|h2|h3|h4|h5|h6|iframe|noframes|object|ol|p|ul|applet|center|dir|hr|pre|ADDRESS|BLOCKQUOTE|DD|DIV|SECTION|ARTICLE|ASIDE|HEADER|FOOTER|NAV|MENU|DL|DT|FIELDSET|FORM|FRAME|FRAMESET|H1|H2|H3|H4|H5|H6|IFRAME|NOFRAMES|OBJECT|OL|P|UL|APPLET|CENTER|DIR|HR|PRE)$")
  (#set! test.final true))

(end_tag
  (tag_name) @entity.name.tag.block._TEXT_.html.svelte
  (#match? @entity.name.tag.block._TEXT_.html.svelte "^(address|blockquote|dd|div|section|article|aside|header|footer|nav|menu|dl|dt|fieldset|form|frame|frameset|h1|h2|h3|h4|h5|h6|iframe|noframes|object|ol|p|ul|applet|center|dir|hr|pre|ADDRESS|BLOCKQUOTE|DD|DIV|SECTION|ARTICLE|ASIDE|HEADER|FOOTER|NAV|MENU|DL|DT|FIELDSET|FORM|FRAME|FRAMESET|H1|H2|H3|H4|H5|H6|IFRAME|NOFRAMES|OBJECT|OL|P|UL|APPLET|CENTER|DIR|HR|PRE)$")
  (#set! test.final true))

(start_tag
  (tag_name) @entity.name.tag.inline._TEXT_.html.svelte
  (#match? @entity.name.tag.inline._TEXT_.html.svelte "^(a|abbr|acronym|area|b|base|basefont|bdo|big|br|button|caption|cite|code|col|colgroup|del|dfn|em|font|head|html|i|img|input|ins|isindex|kbd|label|legend|li|link|map|meta|noscript|optgroup|option|param|q|s|samp|script|select|small|span|strike|strong|style|sub|sup|table|tbody|td|textarea|tfoot|th|thead|title|tr|tt|u|var|A|ABBR|ACRONYM|AREA|B|BASE|BASEFONT|BDO|BIG|BR|BUTTON|CAPTION|CITE|CODE|COL|COLGROUP|DEL|DFN|EM|FONT|HEAD|HTML|I|IMG|INPUT|INS|ISINDEX|KBD|LABEL|LEGEND|LI|LINK|MAP|META|NOSCRIPT|OPTGROUP|OPTION|PARAM|Q|S|SAMP|SCRIPT|SELECT|SMALL|SPAN|STRIKE|STRONG|STYLE|SUB|SUP|TABLE|TBODY|TD|TEXTAREA|TFOOT|TH|THEAD|TITLE|TR|TT|U|VAR)$")
  (#set! test.final true))

(end_tag
  (tag_name) @entity.name.tag.inline._TEXT_.html.svelte
  (#match? @entity.name.tag.inline._TEXT_.html.svelte "^(a|abbr|acronym|area|b|base|basefont|bdo|big|br|button|caption|cite|code|col|colgroup|del|dfn|em|font|head|html|i|img|input|ins|isindex|kbd|label|legend|li|link|map|meta|noscript|optgroup|option|param|q|s|samp|script|select|small|span|strike|strong|style|sub|sup|table|tbody|td|textarea|tfoot|th|thead|title|tr|tt|u|var|A|ABBR|ACRONYM|AREA|B|BASE|BASEFONT|BDO|BIG|BR|BUTTON|CAPTION|CITE|CODE|COL|COLGROUP|DEL|DFN|EM|FONT|HEAD|HTML|I|IMG|INPUT|INS|ISINDEX|KBD|LABEL|LEGEND|LI|LINK|MAP|META|NOSCRIPT|OPTGROUP|OPTION|PARAM|Q|S|SAMP|SCRIPT|SELECT|SMALL|SPAN|STRIKE|STRONG|STYLE|SUB|SUP|TABLE|TBODY|TD|TEXTAREA|TFOOT|TH|THEAD|TITLE|TR|TT|U|VAR)$")
  (#set! test.final true))


; ELEMENTS
; ========

; Tag names
; ---------

(start_tag
  "<" @punctuation.definition.tag.begin.html.svelte
  ">" @punctuation.definition.tag.end.html.svelte)

; Fallback for any tag that didn't get scoped in the Support section above.
(start_tag
  (tag_name) @entity.name.tag.html.svelte)

(end_tag
  "</" @punctuation.definition.tag.begin.html.svelte
  ">" @punctuation.definition.tag.end.html.svelte)

(end_tag
  (tag_name) @entity.name.tag.html.svelte)

(self_closing_tag
  "<" @punctuation.definition.tag.begin.html.svelte
  (tag_name) @entity.name.tag.html.svelte
  "/>" @punctuation.definition.tag.end.html.svelte)


; Attributes
; ----------

(attribute "=" @punctuation.separator.key-value.html.svelte)
(attribute_name) @entity.other.attribute-name

; Single- and double-quotes around attribute values.
((quoted_attribute_value ["\"" "'"] @punctuation.definition.string.begin.html.svelte)
  (#set! test.onlyIfFirst true))

((quoted_attribute_value ["\"" "'"] @punctuation.definition.string.end.html.svelte)
  (#set! test.onlyIfLast true))

; If this matches, the value is double-quoted.
(quoted_attribute_value "\"") @string.quoted.double.html.svelte

; If this matches, the value is single-quoted.
(quoted_attribute_value "'") @string.quoted.single.html.svelte

; Prevent quoted attribute values from having `string.unquoted` applied.
(quoted_attribute_value
  (attribute_value) @_IGNORE_
  (#set! test.final true))

; The "foo" in `<div class=foo>`.
; Because of the preceding rule, if this matches and passes all tests, the
; value must be unquoted.
(attribute_value) @string.unquoted.html.svelte


; MISC
; ====

[
  ; (expression)
  ; (html_expr)
  (raw_text_expr)
] @meta.embedded.line.js.svelte

((if_start_expr) @punctuation.definition.keyword.svelte
  (#match? @punctuation.definition.keyword.svelte "^\\{#")
  (#set! adjust.startAndEndAroundFirstMatchOf "#"))

((if_start_expr) @keyword.control.conditional.begin.if.svelte
  (#set! adjust.startAndEndAroundFirstMatchOf "#if"))

((if_end_expr) @punctuation.definition.keyword.svelte
  (#match? @punctuation.definition.keyword.svelte "^\\{/")
  (#set! adjust.startAndEndAroundFirstMatchOf "/"))

((if_end_expr) @keyword.control.conditional.end.if.svelte
  (#set! adjust.startAndEndAroundFirstMatchOf "/if"))

((else_if_expr) @keyword.control.conditional.else.svelte
  (#set! adjust.startAndEndAroundFirstMatchOf ":else"))

((else_if_expr) @punctuation.definition.keyword.svelte
  (#set! adjust.startAndEndAroundFirstMatchOf ":"))

((else_if_expr
  (special_block_keyword) @keyword.control.conditional.if.svelte)
  (#eq? @keyword.control.conditional.if.svelte "if"))

((else_expr) @keyword.control.conditional.else.svelte
  (#set! adjust.startAndEndAroundFirstMatchOf ":else"))

((else_expr) @punctuation.definition.keyword.svelte
  (#set! adjust.startAndEndAroundFirstMatchOf ":"))

((each_start_expr) @keyword.control.loop.begin.each.svelte
  (#set! adjust.startAndEndAroundFirstMatchOf "#each"))

((each_start_expr) @punctuation.definition.keyword.svelte
  (#set! adjust.startAndEndAroundFirstMatchOf "#"))

((each_end_expr) @keyword.control.loop.end.each.svelte
  (#set! adjust.startAndEndAroundFirstMatchOf "/each"))

((each_end_expr) @punctuation.definition.keyword.svelte
  (#set! adjust.startAndEndAroundFirstMatchOf "/"))

((await_start_expr) @punctuation.definition.keyword.svelte
  (#set! adjust.startAndEndAroundFirstMatchOf "#"))

((await_start_expr) @keyword.control.loop.begin.await.svelte
  (#set! adjust.startAndEndAroundFirstMatchOf "#await"))

((await_start_expr) @keyword.control.loop.end.await.svelte
  (#set! adjust.startAndEndAroundFirstMatchOf "/await"))

((await_end_expr) @punctuation.definition.keyword.svelte
  (#set! adjust.startAndEndAroundFirstMatchOf "/"))

((key_start_expr) @punctuation.definition.keyword.svelte
  (#set! adjust.startAndEndAroundFirstMatchOf "#"))

((key_start_expr) @keyword.control.loop.begin.key.svelte
  (#set! adjust.startAndEndAroundFirstMatchOf "#key"))

((key_start_expr) @keyword.control.loop.end.key.svelte
  (#set! adjust.startAndEndAroundFirstMatchOf "/key"))

((key_end_expr) @punctuation.definition.keyword.svelte
  (#set! adjust.startAndEndAroundFirstMatchOf "/"))



((html_expr (special_block_keyword)) @keyword.other.special-method.svelte
  (#set! adjust.startAt firstChild.nextSibling.startPosition)
  (#set! adjust.endAt firstNamedChild.endPosition))

((html_expr) @punctuation.definition.special-method.svelte
  (#set! adjust.startAndEndAroundFirstMatchOf "@"))

((const_expr (special_block_keyword)) @keyword.other.special-method.svelte
  (#set! adjust.startAt firstChild.nextSibling.startPosition)
  (#set! adjust.endAt firstNamedChild.endPosition))

((const_expr) @punctuation.definition.special-method.svelte
  (#set! adjust.startAndEndAroundFirstMatchOf "@"))

(as) @keyword.control.as.svelte
