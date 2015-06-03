command: "pmset -g batt | grep -o '[0-9]*%'"

refreshFrequency: 60000

render: -> """
  <div class='battery'></div>
"""

update: (output, domEl) ->
  if (output != '')
    if (output.indexOf('100%') == -1)
      $(domEl).find('.battery').html('Battery has ' + output + ' charge remaining.')
    else
      $(domEl).find('.battery').html('Battery fully charged.')


style: """
  bottom: 85px
  left: 5px
  color: #999
  font-family: San Francisco Display, Helvetica Neue
  font-size: 11px

  div
    display: block
    color: rgba(#777, 0.7)
    font-size: 14px
    font-weight: 110
"""
