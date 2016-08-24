command: "ESC=`printf \"\e\"`; ps -A -o %mem | awk '{s+=$1} END {print \"\" s}'"

refreshFrequency: 30000 # ms

render: (output) ->
  "mem <span>#{output}</span>"

style: """
  left: 620px
  top: 4px
  -webkit-font-smoothing: antialiased
  font-family: 'San Francisco Display', 'Helvetica Neue'
  font-size: 11px
  color: #FFFFFF
  span
    color: #AFAFAF
"""
