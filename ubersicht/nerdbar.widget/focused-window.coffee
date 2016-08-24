command: "~/.ubersicht/nerdbar.widget/get-focused-window.applescript"

refreshFrequency: 1000 # ms

render: (output) ->
  "#{output}"

style: """
  -webkit-font-smoothing: antialiased
  color: #D6E7EE
  font-family 'San Francisco Display', 'Helvetica Neue'
  font-size 11px
  height: 16px
  left: 10px
  overflow: hidden
  text-overflow: ellipsis
  top: 6px
  width: 500px
"""
