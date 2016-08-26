format = '%d %a %l:%M %p'

command: "date +\"#{format}\""

# the refresh frequency in milliseconds
refreshFrequency: 30000

render: -> """
  <h1>
    <span id="date" class="span1"></span>
    <span id="day" class="span2"></span>
    <span id="time" class="span3"></span>
    <span id="meridiem" class="span4"></span>
  </h1>
"""

update: (output, domEl) ->
  components = output.replace(/\s\s+/g, ' ').split(' ')
  heading    = $(domEl).find('h1')

  for component, i in components
    heading.find(".span#{i + 1}").text(component)

style: """
  left 5px
  bottom 0
  color #999
  -webkit-font-smoothing antialiased
  font-family 'San Francisco Display', 'Helvetica Neue'
  font-size 11px
  font-weight 500

  h1
    font-size 5em
    font-weight 100
    margin 0
    padding 0

  #day
    color #777
    margin-left -12px
    text-transform lowercase
    font-size 48px

  #time
    margin-left -10px
    color rgba(#777, 0.8)

  #meridiem
    text-transform lowercase
    margin-left -14px
    font-size 32px
    color rgba(#777, 0.5)
"""
