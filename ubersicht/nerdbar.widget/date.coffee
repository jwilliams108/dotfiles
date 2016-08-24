command: "date +\"%a %d %b\""

refreshFrequency: 10000

render: (output) ->
  "#{output}"

style: """
  right: 60px
  top: 4px
  -webkit-font-smoothing: antialiased
  font-family 'San Francisco Display', 'Helvetica Neue'
  font-size 11px
  color: #FFFFFF
"""
