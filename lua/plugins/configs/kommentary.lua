local config = require'kommentary.config'

config.configure_language({"typescript", "javascript"}, {
  single_line_comment_string = "//",
  multi_line_comment_strings = { "/**", "*/" },
})

