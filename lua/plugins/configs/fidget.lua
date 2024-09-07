local fidget = require'fidget'

fidget.setup{
    notification = {
        text = {
            spinner = "star",
            done = "✔",
            commenced = "Started",
            completed = "Completed",
        },
        align = {
            bottom = true,
            right = true,
        },
        timer = {
            spinner_rate = 125,
            fidget_decay = 2000,
            task_decay = 1000,
        },
        window = {
            relative = "editor",
            blend = 100,
            zindex = nil,
            border = "none",
        },
        sources = {
              jdtls = {
                  ignore = true,
              }
        }
    }
}
