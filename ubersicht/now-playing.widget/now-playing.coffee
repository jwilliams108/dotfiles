command: "~/.ubersicht/now-playing.widget/now-playing.sh"

# Set the refresh frequency (milliseconds).
refreshFrequency: 3000

# Render the output.
render: -> """
  <p id="now">Now<br />Playing</p>
  <div id='now_playing'>
    <p class='title'></span>
    <p>
      <span class='artist'></span>
      <span class='album'></span>
    </p>
  </div>
"""

# Update the rendered output.
update: (output, domEl) ->
  dom = $(domEl)

  # Parse the JSON created by the shell script.
  data = JSON.parse output
  now_playing = data.now_playing
  el = $('#' + 'now_playing')

  if now_playing
    if now_playing.status == 'playing' or now_playing.status == 'paused'
      $('#now').html('Now<br />Playing')
      el.removeClass().addClass(now_playing.status)
      el.find('.title').text(now_playing.title || '')
      el.find('.artist').text(now_playing.artist || '')
      el.find('.album').text(now_playing.album || '')
    else
      $('#now').html('Not<br />Playing')
      el.removeClass()
      el.find('.title, .artist, .album').text('')
  else
    $('#now').html('Not<br />Playing')
    el.removeClass()
    el.find('.title, .artist, .album').text('')


# CSS Style
style: """
  left 5px
  top 5px
  font-family San Francisco Display, Helvetica Neue
  font-size 11px

  div
    margin-top 3px
    margin-left 5px
    padding 12px 0 6px 24px
    border-left 1px solid rgba(#777, 0.5)

  p
    margin 0
    padding 0

  #now, .title, .artist, .album
    font-size 18px
    color rgba(#777, 1)

  #now
    display block
    float left
    padding-top 32px
    font-size 11px
    font-weight 500
    text-align right
    color rgba(#777, 0.5)

  #now_playing
    display inline-block
    min-height 42px
    float left

  .artist
    font-size 14px
    color rgba(#777, 0.7)

  .album
    font-size 14px
    color rgba(#777, 0.5)

  .playing
    background url(/now-playing.widget/images/play.png)

  .paused
    background url(/now-playing.widget/images/paused.png)

  #now_playing.playing,
  #now_playing.paused
    background-position 5px 36px
    background-repeat no-repeat
    background-size 10px 12px
"""
