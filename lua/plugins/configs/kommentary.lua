local config = require'kommentary.config'

config.configure_language("typescript", {
  single_line_comment_string = "//",
  multi_line_comment_strings = { "/**", "*/" },
})

