# Phoenix.app config

## Basic Settings

    MARGIN_X     = 4
    MARGIN_Y     = 4
    GRID_WIDTH   = 21
    GRID_HEIGHT  = 13

## Application config

    EDITOR       = "MacVim"
    BROWSER      = "Google Chrome"
    DEVBROWSER   = "Google Chrome Canary"
    MATBROWSER   = "Firefox"
    INTBROWSER   = "Safari"
    TERMINAL     = "iTerm"
    MAIL         = "Mail"
    CALENDAR     = "Calendar"
    IM           = "Adium"
    FINDER       = "Finder"
    MUSIC        = "Vox"
    VIDEO        = "VLC"

## Layout config

Default app layouts.
**note:** The last app in a layout array will get focus.

    layouts =
      "Editor and Terminal":
        0: app: EDITOR,   whereTo: "toFib13Left"
        1: app: TERMINAL, whereTo: "toFib8Right"

      "Communications":
        0: app: INTBROWSER, whereTo: "toFib13TopLeft"
        1: app: CALENDAR,   whereTo: "toFib13BtmLeft"
        2: app: MAIL,       whereTo: "toFib13TopLeft"
        3: app: IM,         whereTo: "toFib8BtmRight"

## Utility Methods

### Debug

    debug = (message)->
      api.alert message, 10

### Window Grid

Snap all windows to grid layout

    snapAllToGrid = ->
      Window.visibleWindows().map (win) ->
        win.snapToGrid()
        return
      return

Change grid by a width factor

    changeGridWidth = (by_) ->
      GRID_WIDTH = Math.max(1, GRID_WIDTH + by_)
      api.alert "grid is now " + GRID_WIDTH + " tiles wide", 1
      snapAllToGrid()
      return

    changeGridHeight = (by_) ->
      GRID_HEIGHT = Math.max(1, GRID_HEIGHT + by_)
      api.alert "grid is now " + GRID_HEIGHT + " tiles high", 1
      snapAllToGrid()
      return

Get the current grid as `{x:,y:,width:,height:}`

    Window::getGrid = ->
      winFrame = @frame()
      screenRect = @screen().frameWithoutDockOrMenu()
      thirdScreenWidth = screenRect.width / GRID_WIDTH
      halfScreenHeight = screenRect.height / GRID_HEIGHT
      x: Math.round((winFrame.x - screenRect.x) / thirdScreenWidth)
      y: Math.round((winFrame.y - screenRect.y) / halfScreenHeight)
      width: Math.max(1, Math.round(winFrame.width / thirdScreenWidth))
      height: Math.max(1, Math.round(winFrame.height / halfScreenHeight))

Set the current grid from an object `{x:,y:,width:,height:}`

    Window::setGrid = (grid, screen) ->
      screenRect = screen.frameWithoutDockOrMenu()
      thirdScreenWidth = screenRect.width / GRID_WIDTH
      halfScreenHeight = screenRect.height / GRID_HEIGHT
      newFrame =
        x: (grid.x * thirdScreenWidth) + screenRect.x
        y: (grid.y * halfScreenHeight) + screenRect.y
        width: grid.width * thirdScreenWidth
        height: grid.height * halfScreenHeight
      newFrame.x += MARGIN_X
      newFrame.y += MARGIN_Y
      newFrame.width -= (MARGIN_X * 2.0)
      newFrame.height -= (MARGIN_Y * 2.0)
      @setFrame newFrame

Snap the current window to the grid

    Window::snapToGrid = ->
      @setGrid @getGrid(), @screen()  if @isNormalWindow()

Calculate the grid based on the parameters, `x`, `y`, `width`, `height`, (returning an object `{x:,y:,width:,height:}`)

    Window::calculateGrid = (x, y, width, height) ->
      screen = @screen().frameWithoutDockOrMenu()
      x: Math.round(x * screen.width) + MARGIN_X + screen.x
      y: Math.round(y * screen.height) + MARGIN_Y + screen.y
      width: Math.round(width * screen.width) - 2.0 * MARGIN_X
      height: Math.round(height * screen.height) - 2.0 * MARGIN_Y

Window to grid

    Window::toGrid = (x, y, width, height) ->
      rect = @calculateGrid(x, y, width, height)
      @setFrame rect
      this

Window top right point

    Window::topRight = ->
      f = @frame()
      {
        x: f.x + f.width
        y: f.y
      }

Windows on the left

    Window::toLeft = ->
      p = @topLeft()
      _.chain(@windowsToWest())
      .filter (win)->
        win.topLeft().x < p.x - 10
      .value()

Windows on the right

    Window::toRight = ->
      p = @topRight()
      _.chain(@windowsToEast())
      .filter (win) ->
        win.topRight().x > p.x + 10
      .value()

### Window information

    Window::info = ->
      f = @frame()
      "[#{@app().pid}] #{@app().title()} : #{@title()}\n{x:#{f.x}, y:#{f.y}, width:#{f.width}, height:#{f.height}}\n"

Sort any window collection by most recently with focus. We use
`info()` as a way of identifying the windows in place. Not too
performant, but with collections of this size, it's not a problem.

    Window.sortByMostRecent = (windows)->
      allVisible = Window.visibleWindowsMostRecentFirst()
      _.chain(windows)
      .sortBy (win)->
        _.map(allVisible, (w)-> w.info()).indexOf(win.info())
      .value()

### Window moving and sizing

Temporary storage for frames

    lastFrames = {}

Set a window to full screen

    Window::toFullScreen = ->
      fullFrame = @calculateGrid(0, 0, 1, 1)
      unless _.isEqual(@frame(), fullFrame)
        @rememberFrame()
        @toGrid 0, 0, 1, 1
      else if lastFrames[this]
        @setFrame lastFrames[this]
        @forgetFrame()

Remember and forget frames

    Window::rememberFrame = -> lastFrames[this] = @frame()
    Window::forgetFrame = -> delete lastFrames[this]

Standard window positions

    #                                  x:   y:   width: height:
    Window::toTopHalf     = -> @toGrid 0,   0,   1,     0.5
    Window::toBottomHalf  = -> @toGrid 0,   0.5, 1,     0.5
    Window::toLeftHalf    = -> @toGrid 0,   0,   0.5,   1
    Window::toRightHalf   = -> @toGrid 0.5, 0,   0.5,   1
    #                                  x:   y:   width: height:
    Window::toTopRight    = -> @toGrid 0.5, 0,   0.5,   0.5
    Window::toBottomRight = -> @toGrid 0.5, 0.5, 0.5,   0.5
    Window::toTopLeft     = -> @toGrid 0,   0,   0.5,   0.5
    Window::toBottomLeft  = -> @toGrid 0,   0.5, 0.5,   0.5

Fibonacci window positions

    #                                     x:     y:    width: height:
    Window::toFib13Left      = -> @toGrid 0,     0,    13/21, 1
    Window::toFib13Right     = -> @toGrid 8/21,  0,    13/21, 1
    Window::toFib8Right      = -> @toGrid 13/21, 0,    8/21,  1
    Window::toFib8Left       = -> @toGrid 0,     0,    8/21,  1
    #                                     x:     y:    width: height:
    Window::toFib13TopLeft   = -> @toGrid 0,     0,    13/21, 8/13
    Window::toFib8TopRight   = -> @toGrid 13/21, 0,    8/21,  8/13
    Window::toFib13BtmLeft   = -> @toGrid 0,     8/13, 13/21, 5/13
    Window::toFib8BtmRight   = -> @toGrid 13/21, 8/13, 8/21,  5/13

Move the current window to the next / previous screen

    moveWindowToNextScreen = ->
      win = Window.focusedWindow()
      win.setGrid win.getGrid(), win.screen().nextScreen()

    moveWindowToPreviousScreen = ->
      win = Window.focusedWindow()
      win.setGrid win.getGrid(), win.screen().previousScreen()

Move the current window by one column/row

    moveWindowLeftOneColumn = ->
      win = Window.focusedWindow()
      frame = win.getGrid()
      frame.x = Math.max(frame.x - 1, 0)
      win.setGrid frame, win.screen()

    moveWindowRightOneColumn = ->
      win = Window.focusedWindow()
      frame = win.getGrid()
      frame.x = Math.min(frame.x + 1, GRID_WIDTH - frame.width)
      win.setGrid frame, win.screen()

    moveWindowDownOneRow = ->
      win = Window.focusedWindow()
      frame = win.getGrid()
      frame.y = Math.min(Math.floor(frame.y + 1), GRID_HEIGHT - 1)
      win.setGrid frame, win.screen()

    moveWindowUpOneRow = ->
      win = Window.focusedWindow()
      frame = win.getGrid()
      frame.y = Math.max(Math.floor(frame.y - 1), 0)
      win.setGrid frame, win.screen()

Grow and shrink the current window by a single grid cell

    windowGrowOneGridColumn = ->
      win = Window.focusedWindow()
      frame = win.getGrid()
      frame.width = Math.min(frame.width + 1, GRID_WIDTH - frame.x)
      win.setGrid frame, win.screen()

    windowShrinkOneGridColumn = ->
      win = Window.focusedWindow()
      frame = win.getGrid()
      frame.width = Math.max(frame.width - 1, 1)
      win.setGrid frame, win.screen()

    windowGrowOneGridRow = ->
      win = Window.focusedWindow()
      frame = win.getGrid()
      frame.height = Math.min(frame.height + 1, GRID_HEIGHT)
      win.setGrid frame, win.screen()

    windowShrinkOneGridRow = ->
      win = Window.focusedWindow()
      frame = win.getGrid()
      frame.height = Math.max(frame.height - 1, 1)
      win.setGrid frame, win.screen()

Expand the current window's height to vertically fill the screen

    windowToFullHeight = ->
      win = Window.focusedWindow()
      frame = win.getGrid()
      frame.y = 0
      frame.height = GRID_HEIGHT
      win.setGrid frame, win.screen()

### Transpose windows

    transposeWindows = (swapFrame = true, switchFocus = true) ->
      win = Window.focusedWindow()
      left = win.toRight()
      right = win.toLeft()
      targets = if left.length > 0
        left
      else if right.length > 0
        right

      unless targets?.length > 0
        api.alert "Can't see any windows to transpose"
        return

      target = Window.sortByMostRecent(targets)[0]

      t_frame = target.frame()
      w_frame = win.frame()

      if swapFrame
        win.setFrame t_frame
        target.setFrame w_frame
      else
        target.topLeft x:w_frame.x, y:w_frame.y
        win.topLeft    x:t_frame.x, y:t_frame.y

      target.focusWindow() if switchFocus

### Applications

Select the first window for an app

    App::firstWindow = -> @visibleWindows()[0]

Find an app by it's `title`

    App.byTitle = (title) ->
      apps = @runningApps()
      i = 0
      while i < apps.length
        app = apps[i]
        if app.title() is title
          app.show()
          return app
        i++
      return

Find all apps with `title`

    App.allWithTitle = (title) ->
      _(@runningApps()).filter (app) ->
        true  if app.title() is title

Focus or start an app with `title`

    App.focusOrStart = (title) ->
      apps = App.allWithTitle(title)
      if _.isEmpty(apps)
        api.alert "Attempting to start #{title}"
        api.launch title
        return

      windows = _.chain(apps)
      .map (x) ->
        x.allWindows()
      .flatten()
      .value()

      activeWindows = _(windows)
      .reject (win) ->
        win.isWindowMinimized()

      if _.isEmpty(activeWindows)
        api.launch title

      activeWindows.forEach (win) ->
        win.focusWindow()
        return
      return

Run the given function `fn` for an app with `title`

    forApp = (title, fn) ->
      app = App.byTitle(title)
      _.each app.visibleWindows(), fn  if app

### Manage layouts

Switch to a predefined layout [as above](#layout-config)

    switchLayout = (name)->
      _.each layouts[name], (config)->
        App.focusOrStart config.app
        app = App.byTitle config.app
        app.firstWindow()[config.whereTo]()

### Binding alias

Alias `api.bind` as `key_binding`, to make the binding table extra
readable.

    key_binding = (key, modifier, fn) ->
      api.bind key, modifier, fn

## Bindings

Combinations of **Cmd** + **Alt/Opt** + **Ctrl**

    ctrl       = ['ctrl']
    ctrlShift  = 'ctrl+shift'.split '+'
    ctrlCmd    = 'ctrl+cmd'.split '+'
    ctrlAlt    = 'ctrl+alt'.split '+'
    ctrlAltCmd = 'ctrl+alt+cmd'.split '+'

Transpose/Swap Windows

    # Transpose
    key_binding "T",     ctrlCmd, -> transposeWindows(true, false)

    # Transpose and switch focus
    key_binding "Y",     ctrlCmd, -> transposeWindows(true, true)

Move the current window to the specific area of the screen and fill it.

    key_binding '[',  ctrl,      -> Window.focusedWindow().toFib13Left()
    key_binding ']',  ctrl,      -> Window.focusedWindow().toFib8Right()
    key_binding '[',  ctrlShift, -> Window.focusedWindow().toFib13Left()
    key_binding ']',  ctrlShift, -> Window.focusedWindow().toFib8Right()

    #key_binding '\\', ctrl,      -> Window.focusedWindow().toFib13TopLeft()
    #key_binding '/',  ctrl,      -> Window.focusedWindow().toFib13BtmLeft()
    key_binding '\\', ctrlShift,   -> Window.focusedWindow().toFib8TopRight()
    key_binding '/',  ctrlShift,   -> Window.focusedWindow().toFib8BtmRight()

Focus to direction

    key_binding 'K',  ctrlCmd, -> Window.focusedWindow().focusWindowUp()
    key_binding 'H',  ctrlCmd, -> Window.focusedWindow().focusWindowLeft()
    key_binding 'L',  ctrlCmd, -> Window.focusedWindow().focusWindowRight()
    key_binding 'J',  ctrlCmd, -> Window.focusedWindow().focusWindowDown()

Maximize the current window

    key_binding 'space', ctrlShift, -> Window.focusedWindow().toFullScreen()

Switch to or lauch apps, as defined in the [Application config](#application-config)

    #key_binding '0',     ctrlShift, -> App.focusOrStart EDITOR
    #key_binding '9',     ctrlShift, -> App.focusOrStart TERMINAL
    #key_binding '8',     ctrlShift, -> App.focusOrStart BROWSER
    #key_binding '7',     ctrlShift, -> App.focusOrStart FINDER

Switch layouts using the predefined [Layout config](#layout-config)

    key_binding '1',     ctrlShift, -> switchLayout 'Editor and Terminal'
    key_binding '2',     ctrlShift, -> switchLayout 'Communications'
    #key_binding '5',     ctrlShift, -> switchLayout 'Editor and Browser'
    #key_binding '3',     ctrlShift, -> switchLayout 'Terminal and Browser'
    #key_binding '2',     ctrlShift, -> switchLayout 'Finder and Terminal'
    #key_binding '1',     ctrlShift, -> switchLayout 'Finder and Browser'

Move window between screens

    key_binding 'N',     ctrlShift, -> moveWindowToNextScreen()
    key_binding 'P',     ctrlShift, -> moveWindowToPreviousScreen()

Snap current window or all windows to the grid

    #key_binding ';',     ctrlShift, -> Window.focusedWindow().snapToGrid()
    #key_binding "'",     ctrlShift, -> Window.visibleWindows().map (win)-> win.snapToGrid()

Move the current window around the grid

    #key_binding 'left',  ctrlShift, -> moveWindowLeftOneColumn()
    #key_binding 'up',    ctrlShift, -> windowUpOneRow()
    #key_binding 'down',  ctrlShift, -> windowDownOneRow()
    #key_binding 'right', ctrlShift, -> moveWindowRightOneColumn()

Size the current window on the grid

    #key_binding 'U',     ctrlShift, -> windowToFullHeight()

    #key_binding 'I',     ctrlShift, -> windowShrinkOneGridColumn()
    #key_binding 'O',     ctrlShift, -> windowGrowOneGridColumn()
    #key_binding ',',     ctrlShift, -> windowShrinkOneGridRow()
    #key_binding '.',     ctrlShift, -> windowGrowOneGridRow()
