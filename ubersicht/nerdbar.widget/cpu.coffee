command: "ESC=`printf \"\e\"`; ps -A -o %cpu | awk '{s+=$1} END {printf(\"%.2f\",s/8);}'"

refreshFrequency: 2000 # ms

render: (output) ->
  "cpu <span>#{output}</span>"

style: """
  right: 620px
  top: 4px
  -webkit-font-smoothing: antialiased
  font-family 'San Francisco Display', 'Helvetica Neue'
  font-size 11px
  color: #FFFFFF
  span
    color: #AFAFAF
"""
