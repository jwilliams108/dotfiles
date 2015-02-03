###
Phoenix.app config

Resize windows based on half size or golden ratio
###

# Grid Settings
MARGIN       = 3
GRID_RATIO   = 1.618
GRID_A_RATIO = 1 / GRID_RATIO
GRID_B_RATIO = 1 - GRID_A_RATIO
GRID_WIDTH   = 21
GRID_HEIGHT  = 21

# Utility Methods
debug = (message)->
  api.alert message, 10

# Window grid
Window::_calculateGrid = (x, y, width, height) ->
  screen = @screen().frameWithoutDockOrMenu()
  x: Math.round(x * screen.width) + MARGIN + screen.x
  y: Math.round(y * screen.height) + MARGIN + screen.y
  width: Math.round(width * screen.width) - (2.0 * MARGIN)
  height: Math.round(height * screen.height) - (2.0 * MARGIN)

Window::_toGrid = (x, y, width, height) ->
  rect = @_calculateGrid(x, y, width, height)
  @setFrame rect
  this

# Window info/current_positions
Window::_gridCurrentPosition = ->
  screen = @screen().frameWithoutDockOrMenu()
  frame = @frame()
  x = frame.x
  y = frame.y

  if x != 0
    x = Math.round(x / screen.width * GRID_WIDTH)

  if y != 0
    y = Math.round(y / screen.height * GRID_WIDTH)

  {
    x: x
    y: y
    width: Math.round(frame.width / screen.width * GRID_WIDTH)
    height: Math.round(frame.height / screen.height * GRID_HEIGHT)
  }

# expanded Window primitives
Window::topRight = ->
  frame = @frame()
  {
    x: frame.x + f.width
    y: frame.y
  }

Window::toLeft = ->
  p = @topLeft()
  _.chain(@windowsToWest())
  .filter (win)->
    win.topLeft().x < p.x - 10
  .value()

Window::toRight = ->
  p = @topRight()
  _.chain(@windowsToEast())
  .filter (win) ->
    win.topRight().x > p.x + 10
  .value()

Window.sortByMostRecent = (windows)->
  allVisible = Window.visibleWindowsMostRecentFirst()

  _.chain(windows)
  .sortBy (win)->
    _.map(allVisible, (w)-> w.title()).indexOf(win.title())
  .value()

# Window popout/focus
_lastFrames = {}

Window::_rememberFrame = -> _lastFrames[this] = @frame()
Window::_forgetFrame = -> delete _lastFrames[this]

# Window positions
Window::toggleFibScreen = ->
  grid_x      = Math.round(GRID_B_RATIO * GRID_WIDTH / 2.0)
  grid_y      = Math.round(GRID_B_RATIO * GRID_HEIGHT / 2.0)
  grid_width  = Math.round(GRID_A_RATIO * GRID_WIDTH)
  grid_height = Math.round(GRID_A_RATIO * GRID_HEIGHT)

  fullFrame = @_calculateGrid(grid_x / GRID_WIDTH, grid_y / GRID_HEIGHT, grid_width / GRID_WIDTH, grid_height / GRID_HEIGHT)
  unless _.isEqual(@frame(), fullFrame)
    @_rememberFrame()
    @_toGrid grid_x / GRID_WIDTH, grid_y / GRID_HEIGHT, grid_width / GRID_WIDTH, grid_height / GRID_HEIGHT
  else if _lastFrames[this]
    @setFrame _lastFrames[this]
    @_forgetFrame()

Window::toggleBorderedScreen = (border) ->
  fullFrame = @_calculateGrid(border / GRID_WIDTH, border / GRID_HEIGHT, (GRID_WIDTH - (2.0 * border)) / GRID_WIDTH,
                             (GRID_HEIGHT - (2.0 * border)) / GRID_HEIGHT)
  unless _.isEqual(@frame(), fullFrame)
    @_rememberFrame()
    @_toGrid border / GRID_WIDTH, border / GRID_HEIGHT, (GRID_WIDTH - (2.0 * border)) / GRID_WIDTH, (GRID_HEIGHT - (2.0 * border)) / GRID_HEIGHT
  else if _lastFrames[this]
    @setFrame _lastFrames[this]
    @_forgetFrame()

Window::toggleFullScreen = ->
  fullFrame = @_calculateGrid(0, 0, 1, 1)
  unless _.isEqual(@frame(), fullFrame)
    @_rememberFrame()
    @_toGrid 0, 0, 1, 1
  else if _lastFrames[this]
    @setFrame _lastFrames[this]
    @_forgetFrame()

# Window resizing
Window::resizeWindow = (direction) ->
  half_width = Math.round(0.5 * GRID_WIDTH)
  half_height = Math.round(0.5 * GRID_HEIGHT)
  full_width = 1 * GRID_WIDTH
  full_height = 1 * GRID_HEIGHT
  fiba_width = Math.round(GRID_A_RATIO * GRID_WIDTH)
  fiba_height = Math.round(GRID_A_RATIO * GRID_HEIGHT)
  fibb_width = Math.round(GRID_B_RATIO * GRID_WIDTH)
  fibb_height = Math.round(GRID_B_RATIO * GRID_HEIGHT)

  current_position = @_gridCurrentPosition()

  new_x = current_position.x
  new_y = current_position.y
  new_width = current_position.width
  new_height = current_position.height

  if direction == 'left'
    if current_position.width == half_width && current_position.height != full_height
      new_width = half_width
      new_x = 0
      new_height = full_height
      new_y = 0
    else if current_position.width == fiba_width && current_position.height != full_height
      new_width = fiba_width
      new_x = 0
      new_height = full_height
      new_y = 0
    else if current_position.width == fibb_width && current_position.height != full_height
      new_width = fiba_width
      new_x = 0
      new_height = full_height
      new_y = 0
    else if (current_position.width == half_width && current_position.x == 0) || current_position.width == fibb_width
      new_width = fiba_width
      new_x = 0
      new_height = full_height
      new_y = 0
    else
      new_width = half_width
      new_x = 0
      new_height = full_height
      new_y = 0
  else if direction == 'right'
    if current_position.width == half_width && current_position.height != full_height
      new_width = half_width
      new_x = half_width
      new_height = full_height
      new_y = 0
    else if current_position.width == fibb_width && current_position.height != full_height
      new_width = fibb_width
      new_x = fiba_width
      new_height = full_height
      new_y = 0
    else if current_position.width == fibb_width || (current_position.width == half_width && current_position.x == 0)
      new_width = half_width
      new_x = half_width
      new_height = full_height
      new_y = 0
    else if current_position.width == half_width && current_position.x != 0
      new_width = fibb_width
      new_x = fiba_width
      new_height = full_height
      new_y = 0
    else
      new_width = fibb_width
      new_x = fiba_width
      new_height = full_height
      new_y = 0
  else if direction == 'top'
    new_height = fiba_height
    new_y = 0
  else if direction == 'bottom'
    new_height = fibb_height
    new_y = fiba_height

  if new_x != 0
    new_x = new_x / GRID_WIDTH

  if new_y != 0
    new_y = new_y / GRID_HEIGHT

  @_toGrid new_x, new_y, new_width / GRID_WIDTH, new_height / GRID_HEIGHT

# toggle through stacked windows
Window::toggleStackedWindows = ->
  frame = @frame()
  stackedWindows = []

  allVisible = Window.visibleWindowsMostRecentFirst()

  _.each allVisible, (window) ->
    if _.isEqual(frame, window.frame())
      stackedWindows.push(window)

  topMostWindow = stackedWindows.pop()
  topMostWindow.focusWindow()

# focus to direction
Window::focusToFrontLeft = ->
  win = Window.focusedWindow()
  targets = win.windowsToWest()

  sortedTargets = Window.sortByMostRecent(targets)

  if sortedTargets.length
    topMostLeft = sortedTargets[0]
    topMostLeft.focusWindow()

Window::focusToFrontRight = ->
  win = Window.focusedWindow()
  targets = win.windowsToEast()

  sortedTargets = Window.sortByMostRecent(targets)

  if sortedTargets.length
    topMostRight = sortedTargets[0]
    topMostRight.focusWindow()

Window::
# Bindings
# Binding alias
key_binding = (key, modifier, fn) ->
  api.bind key, modifier, fn

# command keys
ctrlAlt    = 'ctrl+alt'.split '+'
ctrlAltCmd = 'ctrl+alt+cmd'.split '+'

# resizing
key_binding 'H', ctrlAltCmd, -> Window.focusedWindow().resizeWindow('left')
key_binding 'L', ctrlAltCmd, -> Window.focusedWindow().resizeWindow('right')
key_binding 'K', ctrlAltCmd, -> Window.focusedWindow().resizeWindow('top')
key_binding 'J', ctrlAltCmd, -> Window.focusedWindow().resizeWindow('bottom')
key_binding 'F', ctrlAltCmd, -> Window.focusedWindow().toggleFullScreen()
key_binding 'D', ctrlAltCmd, -> Window.focusedWindow().toggleFibScreen()
key_binding 'A', ctrlAltCmd, -> Window.focusedWindow().toggleBorderedScreen(0.5)

# toggle stacked windows
key_binding '`', ctrlAltCmd, -> Window.focusedWindow().toggleStackedWindows()

# focus to direction
key_binding 'H',  ctrlAlt, -> Window.focusedWindow().focusToFrontLeft()
key_binding 'L',  ctrlAlt, -> Window.focusedWindow().focusToFrontRight()
