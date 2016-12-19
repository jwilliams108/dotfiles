#!/usr/bin/env coffee -p

###
Phoenix.app config

Resize windows based on half size or golden ratio
###

# Preferences
Phoenix.set
  daemon: false
  openAtLogin: false

# Grid Settings
MARGIN_X     = 3
MARGIN_Y     = 3
GRID_WIDTH   = 21
GRID_HEIGHT  = 21
GRID_RATIO   = 1.618
GRID_A_RATIO = 1 / GRID_RATIO
GRID_B_RATIO = 1 - GRID_A_RATIO

# Window grid
Window::screenRect = -> @screen().visibleFrameInRectangle()

Window::calculateGrid = (x, y, width, height) ->
  x:      Math.round(x * @screenRect().width) + MARGIN_X + @screenRect().x
  y:      Math.round(y * @screenRect().height) + MARGIN_Y + @screenRect().y
  width:  Math.round(width * @screenRect().width) - 2.0 * MARGIN_X
  height: Math.round(height * @screenRect().height) - 2.0 * MARGIN_Y

Window::toGrid = (x, y, width, height) ->
  rect = @calculateGrid(x, y, width, height)
  @setFrame rect
  @

# Window info/current_positions
Window::gridCurrentPosition = ->
  x:      Math.round(@frame().x / @screenRect().width * GRID_WIDTH)
  y:      Math.round(@frame().y / @screenRect().height * GRID_HEIGHT)
  width:  Math.round(@frame().width / @screenRect().width * GRID_WIDTH)
  height: Math.round(@frame().height / @screenRect().height * GRID_HEIGHT)

# expanded Window primitives
Window::topRight = ->
  x: @frame().x + @frame().width
  y: @frame().y

Window::toLeft = ->
  _.filter @neighbors('west'), (win) ->
    win.topLeft().x < @topLeft().x - 10

Window::toRight = ->
  _.filter @neighbors('east'), (win) ->
    win.topRight().x > @topRight().x + 10

Window.sortByMostRecent = (windows) ->
  allVisible = Window.recent()

  _.chain(windows)
    .sortBy (win) ->
      _.map(allVisible, (w)-> w.title()).indexOf(win.title())
    .value()

# Window popout/focus
lastFrames = {}

Window::uid           = -> "#{@app().name()}::#{@title()}"
Window::rememberFrame = -> lastFrames[@uid()] = @frame()
Window::forgetFrame   = -> delete lastFrames[@uid()]

# Window positions
Window::toggleBorderedScreen = (border) ->
  fullFrame = @calculateGrid(border / GRID_WIDTH, border / GRID_HEIGHT, (GRID_WIDTH - (2.0 * border)) / GRID_WIDTH, (GRID_HEIGHT - (2.0 * border)) / GRID_HEIGHT)
  unless _.isEqual(@frame(), fullFrame)
    @rememberFrame()
    @toGrid border / GRID_WIDTH, border / GRID_HEIGHT, (GRID_WIDTH - (2.0 * border)) / GRID_WIDTH, (GRID_HEIGHT - (2.0 * border)) / GRID_HEIGHT
  else if lastFrames[@uid()]
    @setFrame lastFrames[@uid()]
    @forgetFrame()

Window::toggleFullScreen = ->
  fullFrame = @calculateGrid(0, 0, 1, 1)
  unless _.isEqual(@frame(), fullFrame)
    @rememberFrame()
    @toGrid 0, 0, 1, 1
  else if lastFrames[@uid()]
    @setFrame lastFrames[@uid()]
    @forgetFrame()

# Window resizing
Window::resizeWindow = (direction) ->
  half_width  = Math.round(0.5 * GRID_WIDTH)
  half_height = Math.round(0.5 * GRID_HEIGHT)
  full_width  = 1 * GRID_WIDTH
  full_height = 1 * GRID_HEIGHT
  fiba_width  = Math.round(GRID_A_RATIO * GRID_WIDTH)
  fiba_height = Math.round(GRID_A_RATIO * GRID_HEIGHT)
  fibb_width  = Math.round(GRID_B_RATIO * GRID_WIDTH)
  fibb_height = Math.round(GRID_B_RATIO * GRID_HEIGHT)

  current_position = @gridCurrentPosition()

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
      new_width = half_width - 1 # take one unit off as the grid doesn't divide evenly
      new_x = half_width
      new_height = full_height
      new_y = 0
    else if current_position.width == (half_width - 1) && current_position.x == half_width
      new_width = fiba_width
      new_x = fibb_width
      new_height = full_height
      new_y = 0
    else if current_position.width == fiba_width && current_position.x == fibb_width
      new_width = 17 # not exactly fib, but whatever
      new_x = GRID_WIDTH - new_width
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

  @toGrid new_x, new_y, new_width / GRID_WIDTH, new_height / GRID_HEIGHT

# toggle through stacked windows
Window::toggleStackedWindows = ->
  stackedWindows = []

  allVisible = Window.recent()

  _.each allVisible, (window) ->
    if _.isEqual(@frame, window.frame())
      stackedWindows.push(window)

  topMostWindow = stackedWindows.pop()
  topMostWindow.focus()

# focus to direction
Window::focusToFrontLeft = ->
  win = Window.focused()
  targets = win.neighbours('west')

  sortedTargets = Window.sortByMostRecent(targets)

  if sortedTargets.length
    topMostLeft = sortedTargets[0]
    topMostLeft.focus()

Window::focusToFrontRight = ->
  win = Window.focused()
  targets = win.neighbours('east')

  sortedTargets = Window.sortByMostRecent(targets)

  if sortedTargets.length
    topMostRight = sortedTargets[0]
    topMostRight.focus()

# Bindings
keys = []
key_binding = (key, modifier, fn)-> keys.push Key.on(key, modifier, fn)

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
key_binding 'H',  shiftCmd, -> Window.focused().focusToFrontLeft()
key_binding 'L',  shiftCmd, -> Window.focused().focusToFrontRight()
