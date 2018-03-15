###
Phoenix.app config

Resize windows based on half size or golden ratio
###

# Preferences
Phoenix.set
  daemon: false
  openAtLogin: true

# Grid Settings
MARGIN_X     = 3
MARGIN_Y     = 3
GRID_WIDTH   = 21
GRID_HEIGHT  = 21
GRID_RATIO   = 1.618
GRID_A_RATIO = 1 / GRID_RATIO
GRID_B_RATIO = 1 - GRID_A_RATIO

HALF_WIDTH  = Math.round(0.5 * GRID_WIDTH)
HALF_HEIGHT = Math.round(0.5 * GRID_HEIGHT)
FULL_WIDTH  = 1 * GRID_WIDTH
FULL_HEIGHT = 1 * GRID_HEIGHT
FIBA_WIDTH  = Math.round(GRID_A_RATIO * GRID_WIDTH)
FIBA_HEIGHT = Math.round(GRID_A_RATIO * GRID_HEIGHT)
FIBB_WIDTH  = Math.round(GRID_B_RATIO * GRID_WIDTH)
FIBB_HEIGHT = Math.round(GRID_B_RATIO * GRID_HEIGHT)

# helpers
Window::screenRect = (screen) -> screen?.flippedVisibleFrame() || @screen().flippedVisibleFrame()
Window::fullGridFrame = -> @calculateGrid y: 0, x: 0, width: 1, height: 1
Window::borderedFullGridFrame = (border) -> @calculateGrid x: border / GRID_WIDTH, y: border / GRID_HEIGHT, width: (GRID_WIDTH - (2.0 * border)) / GRID_WIDTH, height: (GRID_HEIGHT - (2.0 * border)) / GRID_HEIGHT

# Window positions
Window::gridCurrentPosition = ->
  x:      Math.round(@frame().x / @screenRect().width * GRID_WIDTH)
  y:      Math.round(@frame().y / @screenRect().height * GRID_HEIGHT)
  width:  Math.round(@frame().width / @screenRect().width * GRID_WIDTH)
  height: Math.round(@frame().height / @screenRect().height * GRID_HEIGHT)

Window::calculateGrid = ({x, y, width, height}) ->
  x:      Math.round(x * @screenRect().width) + MARGIN_X + @screenRect().x
  y:      Math.round(y * @screenRect().height) + MARGIN_Y + @screenRect().y
  width:  Math.round(width * @screenRect().width) - 2.0 * MARGIN_X
  height: Math.round(height * @screenRect().height) - 2.0 * MARGIN_Y

Window::toGrid = ({x, y, width, height}) ->
  rect = @calculateGrid {x, y, width, height}
  @setFrame rect

# Window popout/focus
lastFrames = {}

Window::uid           = -> "#{@app().name()}::#{@title()}"
Window::rememberFrame = -> lastFrames[@uid()] = @frame()
Window::forgetFrame   = -> delete lastFrames[@uid()]

# Window positions
Window::toggleFullScreen = ->
  unless _.isEqual @frame(), @fullGridFrame()
    @rememberFrame()
    @toGrid x: 0, y: 0, width: 1, height: 1
  else if lastFrames[@uid()]
    @setFrame lastFrames[@uid()]
    @forgetFrame()

Window::toggleBorderedScreen = (border) ->
  unless _.isEqual @frame(), @borderedFullGridFrame(border)
    @rememberFrame()
    @toGrid x: border / GRID_WIDTH, y: border / GRID_HEIGHT, width: (GRID_WIDTH - (2.0 * border)) / GRID_WIDTH, height: (GRID_HEIGHT - (2.0 * border)) / GRID_HEIGHT
  else if lastFrames[@uid()]
    @setFrame lastFrames[@uid()]
    @forgetFrame()

# Window resizing
Window::resizeWindow = (direction) ->
  current_position = @gridCurrentPosition()

  new_x = current_position.x
  new_y = current_position.y
  new_width = current_position.width
  new_height = current_position.height

  if direction == 'left'
    new_height = FULL_HEIGHT
    new_y = 0
    if current_position.width != HALF_WIDTH
      new_width = HALF_WIDTH
      new_x = 0
    else
      new_width = FIBA_WIDTH
      new_x = 0
  else if direction == 'right'
    new_height = FULL_HEIGHT
    new_y = 0
    if current_position.width != (GRID_WIDTH - (FIBB_WIDTH + 2))
      new_width = (GRID_WIDTH - (FIBB_WIDTH - 2)) # prefer slightly larger
      new_x = FIBB_WIDTH - 2
    else
      new_width = FIBB_WIDTH
      new_x = FIBA_WIDTH
  else if direction == 'top'
    new_height = FIBA_HEIGHT
    new_y = 0
  else if direction == 'bottom'
    new_height = FIBB_HEIGHT
    new_y = FIBA_HEIGHT

  new_frame =
    x: if new_x != 0 then new_x / GRID_WIDTH else 0
    y: if new_y != 0 then new_y / GRID_HEIGHT else 0
    width: new_width / GRID_WIDTH
    height: new_height / GRID_HEIGHT

  @toGrid new_frame

# toggle through stacked windows
Window::toggleStackedWindows = ->
  stackedWindows = []
  allSameVisible = _.filter Window.recent(), (win) => _.isEqual @frame(), win.frame()
  topMostWindow = allSameVisible.pop()
  topMostWindow.focus()

# Bindings
keys = []
key_binding = (key, modifier, fn) -> keys.push Key.on(key, modifier, fn)

# command keys
shiftCmd   = 'shift+cmd'.split '+'
ctrlAltCmd = 'ctrl+alt+cmd'.split '+'

# resizing
key_binding 'H', ctrlAltCmd, -> Window.focused().resizeWindow('left')
key_binding 'L', ctrlAltCmd, -> Window.focused().resizeWindow('right')
key_binding 'K', ctrlAltCmd, -> Window.focused().resizeWindow('top')
key_binding 'J', ctrlAltCmd, -> Window.focused().resizeWindow('bottom')
key_binding 'F', ctrlAltCmd, -> Window.focused().toggleFullScreen()
key_binding 'A', ctrlAltCmd, -> Window.focused().toggleBorderedScreen(0.5)

# toggle stacked windows
key_binding '`', ctrlAltCmd, -> Window.focused().toggleStackedWindows()

# focus to direction
key_binding 'H',  shiftCmd, -> Window.focused().focusClosestNeighbour('west')
key_binding 'L',  shiftCmd, -> Window.focused().focusClosestNeighbour('east')
