// Generated by CoffeeScript 1.7.1
var BROWSER, CALENDAR, DEVBROWSER, EDITOR, FINDER, GRID_HEIGHT, GRID_WIDTH, IM, INTBROWSER, MAIL, MARGIN_X, MARGIN_Y, MATBROWSER, MUSIC, TERMINAL, VIDEO, changeGridHeight, changeGridWidth, ctrl, ctrlAlt, ctrlAltCmd, ctrlCmd, debug, forApp, key_binding, lastFrames, layouts, moveWindowDownOneRow, moveWindowLeftOneColumn, moveWindowRightOneColumn, moveWindowToNextScreen, moveWindowToPreviousScreen, moveWindowUpOneRow, snapAllToGrid, switchLayout, transposeWindows, windowGrowOneGridColumn, windowGrowOneGridRow, windowShrinkOneGridColumn, windowShrinkOneGridRow, windowToFullHeight;

MARGIN_X = 3;

MARGIN_Y = 3;

GRID_WIDTH = 21;

GRID_HEIGHT = 13;

EDITOR = "MacVim";

BROWSER = "Google Chrome";

DEVBROWSER = "Google Chrome Canary";

MATBROWSER = "Firefox";

INTBROWSER = "Safari";

TERMINAL = "iTerm";

MAIL = "Mail";

CALENDAR = "Calendar";

IM = "Adium";

FINDER = "Finder";

MUSIC = "Vox";

VIDEO = "VLC";

layouts = {
  "Editor and Terminal": {
    0: {
      app: EDITOR,
      whereTo: "toFib13Left"
    },
    1: {
      app: TERMINAL,
      whereTo: "toFib8Right"
    }
  },
  "Communications": {
    0: {
      app: INTBROWSER,
      whereTo: "toFib13TopLeft"
    },
    1: {
      app: CALENDAR,
      whereTo: "toFib13BtmLeft"
    },
    2: {
      app: MAIL,
      whereTo: "toFib13TopLeft"
    },
    3: {
      app: IM,
      whereTo: "toFib8BtmRight"
    }
  }
};

debug = function(message) {
  return api.alert(message, 10);
};

snapAllToGrid = function() {
  Window.visibleWindows().map(function(win) {
    win.snapToGrid();
  });
};

changeGridWidth = function(by_) {
  GRID_WIDTH = Math.max(1, GRID_WIDTH + by_);
  api.alert("grid is now " + GRID_WIDTH + " tiles wide", 1);
  snapAllToGrid();
};

changeGridHeight = function(by_) {
  GRID_HEIGHT = Math.max(1, GRID_HEIGHT + by_);
  api.alert("grid is now " + GRID_HEIGHT + " tiles high", 1);
  snapAllToGrid();
};

Window.prototype.getGrid = function() {
  var halfScreenHeight, screenRect, thirdScreenWidth, winFrame;
  winFrame = this.frame();
  screenRect = this.screen().frameWithoutDockOrMenu();
  thirdScreenWidth = screenRect.width / GRID_WIDTH;
  halfScreenHeight = screenRect.height / GRID_HEIGHT;
  return {
    x: Math.round((winFrame.x - screenRect.x) / thirdScreenWidth),
    y: Math.round((winFrame.y - screenRect.y) / halfScreenHeight),
    width: Math.max(1, Math.round(winFrame.width / thirdScreenWidth)),
    height: Math.max(1, Math.round(winFrame.height / halfScreenHeight))
  };
};

Window.prototype.setGrid = function(grid, screen) {
  var halfScreenHeight, newFrame, screenRect, thirdScreenWidth;
  screenRect = screen.frameWithoutDockOrMenu();
  thirdScreenWidth = screenRect.width / GRID_WIDTH;
  halfScreenHeight = screenRect.height / GRID_HEIGHT;
  newFrame = {
    x: (grid.x * thirdScreenWidth) + screenRect.x,
    y: (grid.y * halfScreenHeight) + screenRect.y,
    width: grid.width * thirdScreenWidth,
    height: grid.height * halfScreenHeight
  };
  newFrame.x += MARGIN_X;
  newFrame.y += MARGIN_Y;
  newFrame.width -= MARGIN_X * 2.0;
  newFrame.height -= MARGIN_Y * 2.0;
  return this.setFrame(newFrame);
};

Window.prototype.snapToGrid = function() {
  if (this.isNormalWindow()) {
    return this.setGrid(this.getGrid(), this.screen());
  }
};

Window.prototype.calculateGrid = function(x, y, width, height) {
  var screen;
  screen = this.screen().frameWithoutDockOrMenu();
  return {
    x: Math.round(x * screen.width) + MARGIN_X + screen.x,
    y: Math.round(y * screen.height) + MARGIN_Y + screen.y,
    width: Math.round(width * screen.width) - 2.0 * MARGIN_X,
    height: Math.round(height * screen.height) - 2.0 * MARGIN_Y
  };
};

Window.prototype.toGrid = function(x, y, width, height) {
  var rect;
  rect = this.calculateGrid(x, y, width, height);
  this.setFrame(rect);
  return this;
};

Window.prototype.topRight = function() {
  var f;
  f = this.frame();
  return {
    x: f.x + f.width,
    y: f.y
  };
};

Window.prototype.toLeft = function() {
  var p;
  p = this.topLeft();
  return _.chain(this.windowsToWest()).filter(function(win) {
    return win.topLeft().x < p.x - 10;
  }).value();
};

Window.prototype.toRight = function() {
  var p;
  p = this.topRight();
  return _.chain(this.windowsToEast()).filter(function(win) {
    return win.topRight().x > p.x + 10;
  }).value();
};

Window.prototype.info = function() {
  var f;
  f = this.frame();
  return "[" + (this.app().pid) + "] " + (this.app().title()) + " : " + (this.title()) + "\n{x:" + f.x + ", y:" + f.y + ", width:" + f.width + ", height:" + f.height + "}\n";
};

Window.sortByMostRecent = function(windows) {
  var allVisible;
  allVisible = Window.visibleWindowsMostRecentFirst();
  return _.chain(windows).sortBy(function(win) {
    return _.map(allVisible, function(w) {
      return w.info();
    }).indexOf(win.info());
  }).value();
};

lastFrames = {};

Window.prototype.toFullScreen = function() {
  var fullFrame;
  fullFrame = this.calculateGrid(0, 0, 1, 1);
  if (!_.isEqual(this.frame(), fullFrame)) {
    this.rememberFrame();
    return this.toGrid(0, 0, 1, 1);
  } else if (lastFrames[this]) {
    this.setFrame(lastFrames[this]);
    return this.forgetFrame();
  }
};

Window.prototype.rememberFrame = function() {
  return lastFrames[this] = this.frame();
};

Window.prototype.forgetFrame = function() {
  return delete lastFrames[this];
};

Window.prototype.toTopHalf = function() {
  return this.toGrid(0, 0, 1, 0.5);
};

Window.prototype.toBottomHalf = function() {
  return this.toGrid(0, 0.5, 1, 0.5);
};

Window.prototype.toLeftHalf = function() {
  return this.toGrid(0, 0, 0.5, 1);
};

Window.prototype.toRightHalf = function() {
  return this.toGrid(0.5, 0, 0.5, 1);
};

Window.prototype.toTopRight = function() {
  return this.toGrid(0.5, 0, 0.5, 0.5);
};

Window.prototype.toBottomRight = function() {
  return this.toGrid(0.5, 0.5, 0.5, 0.5);
};

Window.prototype.toTopLeft = function() {
  return this.toGrid(0, 0, 0.5, 0.5);
};

Window.prototype.toBottomLeft = function() {
  return this.toGrid(0, 0.5, 0.5, 0.5);
};

Window.prototype.toFib13Left = function() {
  return this.toGrid(0, 0, 13 / 21, 1);
};

Window.prototype.toFib13Right = function() {
  return this.toGrid(8 / 21, 0, 13 / 21, 1);
};

Window.prototype.toFib8Right = function() {
  return this.toGrid(13 / 21, 0, 8 / 21, 1);
};

Window.prototype.toFib8Left = function() {
  return this.toGrid(0, 0, 8 / 21, 1);
};

Window.prototype.toFib13TopLeft = function() {
  return this.toGrid(0, 0, 13 / 21, 8 / 13);
};

Window.prototype.toFib8TopRight = function() {
  return this.toGrid(13 / 21, 0, 8 / 21, 8 / 13);
};

Window.prototype.toFib13BtmLeft = function() {
  return this.toGrid(0, 8 / 13, 13 / 21, 5 / 13);
};

Window.prototype.toFib8BtmRight = function() {
  return this.toGrid(13 / 21, 8 / 13, 8 / 21, 5 / 13);
};

moveWindowToNextScreen = function() {
  var win;
  win = Window.focusedWindow();
  return win.setGrid(win.getGrid(), win.screen().nextScreen());
};

moveWindowToPreviousScreen = function() {
  var win;
  win = Window.focusedWindow();
  return win.setGrid(win.getGrid(), win.screen().previousScreen());
};

moveWindowLeftOneColumn = function() {
  var frame, win;
  win = Window.focusedWindow();
  frame = win.getGrid();
  frame.x = Math.max(frame.x - 1, 0);
  return win.setGrid(frame, win.screen());
};

moveWindowRightOneColumn = function() {
  var frame, win;
  win = Window.focusedWindow();
  frame = win.getGrid();
  frame.x = Math.min(frame.x + 1, GRID_WIDTH - frame.width);
  return win.setGrid(frame, win.screen());
};

moveWindowDownOneRow = function() {
  var frame, win;
  win = Window.focusedWindow();
  frame = win.getGrid();
  frame.y = Math.min(Math.floor(frame.y + 1), GRID_HEIGHT - 1);
  return win.setGrid(frame, win.screen());
};

moveWindowUpOneRow = function() {
  var frame, win;
  win = Window.focusedWindow();
  frame = win.getGrid();
  frame.y = Math.max(Math.floor(frame.y - 1), 0);
  return win.setGrid(frame, win.screen());
};

windowGrowOneGridColumn = function() {
  var frame, win;
  win = Window.focusedWindow();
  frame = win.getGrid();
  frame.width = Math.min(frame.width + 1, GRID_WIDTH - frame.x);
  return win.setGrid(frame, win.screen());
};

windowShrinkOneGridColumn = function() {
  var frame, win;
  win = Window.focusedWindow();
  frame = win.getGrid();
  frame.width = Math.max(frame.width - 1, 1);
  return win.setGrid(frame, win.screen());
};

windowGrowOneGridRow = function() {
  var frame, win;
  win = Window.focusedWindow();
  frame = win.getGrid();
  frame.height = Math.min(frame.height + 1, GRID_HEIGHT);
  return win.setGrid(frame, win.screen());
};

windowShrinkOneGridRow = function() {
  var frame, win;
  win = Window.focusedWindow();
  frame = win.getGrid();
  frame.height = Math.max(frame.height - 1, 1);
  return win.setGrid(frame, win.screen());
};

windowToFullHeight = function() {
  var frame, win;
  win = Window.focusedWindow();
  frame = win.getGrid();
  frame.y = 0;
  frame.height = GRID_HEIGHT;
  return win.setGrid(frame, win.screen());
};

transposeWindows = function(swapFrame, switchFocus) {
  var left, right, t_frame, target, targets, w_frame, win;
  if (swapFrame == null) {
    swapFrame = true;
  }
  if (switchFocus == null) {
    switchFocus = true;
  }
  win = Window.focusedWindow();
  left = win.toRight();
  right = win.toLeft();
  targets = left.length > 0 ? left : right.length > 0 ? right : void 0;
  if (!((targets != null ? targets.length : void 0) > 0)) {
    api.alert("Can't see any windows to transpose");
    return;
  }
  target = Window.sortByMostRecent(targets)[0];
  t_frame = target.frame();
  w_frame = win.frame();
  if (swapFrame) {
    win.setFrame(t_frame);
    target.setFrame(w_frame);
  } else {
    target.topLeft({
      x: w_frame.x,
      y: w_frame.y
    });
    win.topLeft({
      x: t_frame.x,
      y: t_frame.y
    });
  }
  if (switchFocus) {
    return target.focusWindow();
  }
};

App.prototype.firstWindow = function() {
  return this.visibleWindows()[0];
};

App.byTitle = function(title) {
  var app, apps, i;
  apps = this.runningApps();
  i = 0;
  while (i < apps.length) {
    app = apps[i];
    if (app.title() === title) {
      app.show();
      return app;
    }
    i++;
  }
};

App.allWithTitle = function(title) {
  return _(this.runningApps()).filter(function(app) {
    if (app.title() === title) {
      return true;
    }
  });
};

App.focusOrStart = function(title) {
  var activeWindows, apps, windows;
  apps = App.allWithTitle(title);
  if (_.isEmpty(apps)) {
    api.alert("Attempting to start " + title);
    api.launch(title);
    return;
  }
  windows = _.chain(apps).map(function(x) {
    return x.allWindows();
  }).flatten().value();
  activeWindows = _(windows).reject(function(win) {
    return win.isWindowMinimized();
  });
  if (_.isEmpty(activeWindows)) {
    api.launch(title);
  }
  activeWindows.forEach(function(win) {
    win.focusWindow();
  });
};

forApp = function(title, fn) {
  var app;
  app = App.byTitle(title);
  if (app) {
    return _.each(app.visibleWindows(), fn);
  }
};

switchLayout = function(name) {
  return _.each(layouts[name], function(config) {
    var app;
    App.focusOrStart(config.app);
    app = App.byTitle(config.app);
    return app.firstWindow()[config.whereTo]();
  });
};

key_binding = function(key, modifier, fn) {
  return api.bind(key, modifier, fn);
};

ctrl = ['ctrl'];

ctrlCmd = 'ctrl+cmd'.split('+');

ctrlAlt = 'ctrl+alt'.split('+');

ctrlAltCmd = 'ctrl+alt+cmd'.split('+');

key_binding("T", ctrlCmd, function() {
  return transposeWindows(true, false);
});

key_binding("Y", ctrlCmd, function() {
  return transposeWindows(true, true);
});

key_binding('[', ctrl, function() {
  return Window.focusedWindow().toFib13Left();
});

key_binding(']', ctrl, function() {
  return Window.focusedWindow().toFib8Right();
});

key_binding('\\', ctrl, function() {
  return Window.focusedWindow().toFib13TopLeft();
});

key_binding('/', ctrl, function() {
  return Window.focusedWindow().toFib13BtmLeft();
});

key_binding('\\', ctrlCmd, function() {
  return Window.focusedWindow().toFib8TopRight();
});

key_binding('/', ctrlCmd, function() {
  return Window.focusedWindow().toFib8BtmRight();
});

key_binding('K', ctrlCmd, function() {
  return Window.focusedWindow().focusWindowUp();
});

key_binding('H', ctrlCmd, function() {
  return Window.focusedWindow().focusWindowLeft();
});

key_binding('L', ctrlCmd, function() {
  return Window.focusedWindow().focusWindowRight();
});

key_binding('J', ctrlCmd, function() {
  return Window.focusedWindow().focusWindowDown();
});

key_binding('space', ctrlCmd, function() {
  return Window.focusedWindow().toFullScreen();
});

key_binding('1', ctrlCmd, function() {
  return switchLayout('Editor and Terminal');
});

key_binding('2', ctrlCmd, function() {
  return switchLayout('Communications');
});

key_binding('N', ctrlCmd, function() {
  return moveWindowToNextScreen();
});

key_binding('P', ctrlCmd, function() {
  return moveWindowToPreviousScreen();
});
