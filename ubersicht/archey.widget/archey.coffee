command: "~/.ubersicht/archey.widget/archey.sh"

# Set the refresh frequency (milliseconds).
refreshFrequency: 60000

# Render the output.
render: -> """
  <div id="archey" class="wrapper">
    <table>
      <tbody>
        <tr id="user"></tr>
        <tr id="hostname"></tr>
        <tr id="os"></tr>
        <tr id="kernel"></tr>
        <tr id="uptime"></tr>
        <tr id="shell"></tr>
        <tr id="terminal"></tr>
        <tr id="packages"></tr>
        <tr id="cpu"></tr>
        <tr id="memory"></tr>
        <tr id="disk"></tr>
      </tbody>
    </table>
  </div>
"""

# Update the rendered output.
update: (output, domEl) ->
  dom = $(domEl)

  # Parse the JSON created by the shell script.
  data = JSON.parse output
  el = $('#archey table')

  renderProcess = (name, value) ->
    "<td>#{name}</td><td>#{value}</td>"

  for name, value of data
    if name.toLowerCase() == 'uptime'
      # format uptime value
      value = value.replace('up ', '')
      tokens = value.split(', ')
      tokens = tokens.slice(0, -2) # remove user and load string
      # cleanup hour:min display
      index = 0
      if tokens[1]
        index = 1
      if tokens[index].indexOf(':') != -1
        date = tokens[index].split(':')
        tokens[index] = date[0] + ' hr'
        if parseInt(date[0]) > 1
          tokens[index] += 's'
        tokens[index + 1] = date[1] + ' min'
        if parseInt(date[1]) > 1
          tokens[index + 1] += 's'
      value = tokens.join(', ')
    $("tr#" + name.toLowerCase()).html(renderProcess(name, value))

style: """
  bottom 520px
  left 5px
  color #777
  font-family San Francisco Display, Helvetica Neue
  font-size 11px

  table
    border-collapse collapse

  td
    font-size 11px
    padding 3px 3px 3px 5px
    overflow ellipsis
    text-align left

  td:first-child
    padding-left 0
    text-align right
    border-right 1px solid rgba(#777, 0.2)
    color rgba(#777, .7)

  .wrapper
    padding 0 3px 5px
"""
