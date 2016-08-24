command: "ps -arcwxo '%mem command' | grep -v COMMAND | head -8 | awk '{out=$1\",\"; for(i=2;i<=NF;i++){out=out\" \"$i}; print out}'"

refreshFrequency: 5000

render: -> """
  <div class="wrapper">
    <h1>Memory</h1>
    <table>
      <thead>
        <tr>
          <th>Process</th>
          <th>%</th>
        </tr>
      </thead>
      <tbody>
        <tr class='row1'></tr>
        <tr class='row2'></tr>
        <tr class='row3'></tr>
        <tr class='row4'></tr>
        <tr class='row5'></tr>
        <tr class='row6'></tr>
        <tr class='row7'></tr>
        <tr class='row8'></tr>
      </tbody>
    </table>
  </div>
"""

update: (output, domEl) ->
  processes = output.split('\n')
  table     = $(domEl).find('table')

  renderProcess = (percent, process) ->
    "<td>#{process}</td><td>#{percent}</td>"

  for process, i in processes
    args = process.split(/,(.*)/)
    table.find(".row#{i+1}").html renderProcess(args...)


style: """
  bottom 110px
  left 5px
  min-height 200px
  color #777
  background rgba(#333, .1)
  border 1px solid rgba(#555, .25)
  border-radius 10px
  -webkit-font-smoothing antialiased
  font-family 'San Francisco Display', 'Helvetica Neue'
  font-size 11px

  h1
    font-size 14px
    margin 3px 0

  table
    border-collapse collapse

  th
    font-size 12px
    padding-right 3px
    text-align right
    border-bottom 1px solid rgba(#333, 0.8)
    padding-bottom 3px

  th:first-child
    text-align left

  td
    font-size 11px
    width 24px
    padding 3px 3px 3px 0
    overflow ellipsis
    text-shadow 0 0 1px rgba(#000, 0.5)
    text-align right

  td:first-child
    width 160px
    max-width 160px
    overflow ellipsis
    text-align left

  .wrapper
    padding 0 3px 5px
"""
