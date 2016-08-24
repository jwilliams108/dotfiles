command: "date +\"%H:%M\""

refreshFrequency: 10000 # ms

render: (output) ->
  "#{output}"

style: """
  right: 10px
  top: 4px
  -webkit-font-smoothing: antialiased
  font-family 'San Francisco Display', 'Helvetica Neue'
  font-size 11px
  color: #FFFFFF
"""
