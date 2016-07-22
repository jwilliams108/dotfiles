#--------------------------------------------------------------------------------------
# Please Read
#--------------------------------------------------------------------------------------
# The images used in this widget are from the Noun Project (http://thenounproject.com).
#
# They were created by the following individuals:
#   Ethernet by Michael Anthony from The Noun Project
#   Wireless by Piotrek Chuchla from The Noun Project
#
#--------------------------------------------------------------------------------------

command: "~/.ubersicht/sys-mon-set.widget/network-info.widget/network-info.sh"

# Set the refresh frequency (milliseconds).
refreshFrequency: 600000

# Render the output.
render: -> """
  <div id='services'>
    <div id='ethernet' class='service'>
      <p class='primaryInfo'></p>
      <p class='secondaryInfo'></p>
    </div>
    <div id='wi-fi' class='service'>
      <p class='primaryInfo'></p>
      <p class='secondaryInfo'></p>
    </div>
    <div id='public-ip' class='service'>
      <p class='primaryInfo'></p>
      <p class='secondaryInfo'></p>
    </div>
  </div>
"""

# Update the rendered output.
update: (output, domEl) ->
  dom = $(domEl)

  # Parse the JSON created by the shell script.
  data = JSON.parse output

  # Loop through the services in the JSON.
  for svc in data.service
    disabled = svc.ipaddress == ""
    el = $('#'+svc.name)
    el.find('.primaryInfo').text(svc.ipaddress || 'Not Connected')
    el.find('.secondaryInfo').text(if !disabled then svc.macaddress else '')
    el.toggleClass('disabled', disabled)


# CSS Style
style: """
  left 206px
  bottom 110px
  background rgba(#333, .1)
  border 1px solid rgba(#555, .25)
  border-radius 10px
  font-family 'San Francisco Display', 'Helvetica Neue'
  font-size 11px

  #services
    padding-top 10px

  #wi-fi
    background url(/sys-mon-set.widget/network-info.widget/images/wi-fi.png)

    &.disabled
      background url(/sys-mon-set.widget/network-info.widget/images/wi-fi_disabled.png)

  #ethernet
    background url(/sys-mon-set.widget/network-info.widget/images/ethernet.png)

    &.disabled
      background url(/sys-mon-set.widget/network-info.widget/images/ethernet_disabled.png)

  #public-ip
    background url(/sys-mon-set.widget/network-info.widget/images/globe.png)

  #public-ip, #wi-fi, #ethernet, #wi-fi.disabled, #ethernet.disabled
    padding 40px 3px 0
    min-height 40px
    width 90px
    background-position center 5px
    background-repeat no-repeat
    background-size 32px 32px

  #public-ip
    padding-bottom 3px

  .service
    text-align center

  .primaryInfo, .secondaryInfo
    padding 0px
    margin 2px

  .primaryInfo
    font-size 11px
    color rgba(#777, 1)

  .secondaryInfo
    font-size:8pt
    color rgba(#777, 0.75)

  .disabled p
    color rgba(#777, 0.75)
"""
