local fidget = require'fidget'

fidget.setup{
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
    relative = "win",
    blend = 100,
    zindex = 999,
    border = "none",
  },
}
