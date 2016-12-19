/*
Phoenix.app config

Resize windows based on half size or golden ratio
 */

(function() {
  var GRID_A_RATIO, GRID_B_RATIO, GRID_HEIGHT, GRID_RATIO, GRID_WIDTH, MARGIN_X, MARGIN_Y, ctrlAltCmd, key_binding, keys, lastFrames, shiftCmd;

  Phoenix.set({
    daemon: false,
    openAtLogin: false
  });

  MARGIN_X = 3;

  MARGIN_Y = 3;

  GRID_WIDTH = 21;

  GRID_HEIGHT = 21;

  GRID_RATIO = 1.618;

  GRID_A_RATIO = 1 / GRID_RATIO;

  GRID_B_RATIO = 1 - GRID_A_RATIO;

  Window.prototype.screenRect = function() {
    return this.screen().visibleFrameInRectangle();
  };

  Window.prototype.calculateGrid = function(x, y, width, height) {
    return {
      x: Math.round(x * this.screenRect().width) + MARGIN_X + this.screenRect().x,
      y: Math.round(y * this.screenRect().height) + MARGIN_Y + this.screenRect().y,
      width: Math.round(width * this.screenRect().width) - 2.0 * MARGIN_X,
      height: Math.round(height * this.screenRect().height) - 2.0 * MARGIN_Y
    };
  };

  Window.prototype.toGrid = function(x, y, width, height) {
    var rect;
    rect = this.calculateGrid(x, y, width, height);
    this.setFrame(rect);
    return this;
  };

  Window.prototype.gridCurrentPosition = function() {
    return {
      x: Math.round(this.frame().x / this.screenRect().width * GRID_WIDTH),
      y: Math.round(this.frame().y / this.screenRect().height * GRID_HEIGHT),
      width: Math.round(this.frame().width / this.screenRect().width * GRID_WIDTH),
      height: Math.round(this.frame().height / this.screenRect().height * GRID_HEIGHT)
    };
  };

  Window.prototype.topRight = function() {
    return {
      x: this.frame().x + this.frame().width,
      y: this.frame().y
    };
  };

  Window.prototype.toLeft = function() {
    return _.filter(this.neighbors('west'), function(win) {
      return win.topLeft().x < this.topLeft().x - 10;
    });
  };

  Window.prototype.toRight = function() {
    return _.filter(this.neighbors('east'), function(win) {
      return win.topRight().x > this.topRight().x + 10;
    });
  };

  Window.sortByMostRecent = function(windows) {
    var allVisible;
    allVisible = Window.recent();
    return _.chain(windows).sortBy(function(win) {
      return _.map(allVisible, function(w) {
        return w.title();
      }).indexOf(win.title());
    }).value();
  };

  lastFrames = {};

  Window.prototype.uid = function() {
    return (this.app().name()) + "::" + (this.title());
  };

  Window.prototype.rememberFrame = function() {
    return lastFrames[this.uid()] = this.frame();
  };

  Window.prototype.forgetFrame = function() {
    return delete lastFrames[this.uid()];
  };

  Window.prototype.toggleBorderedScreen = function(border) {
    var fullFrame;
    fullFrame = this.calculateGrid(border / GRID_WIDTH, border / GRID_HEIGHT, (GRID_WIDTH - (2.0 * border)) / GRID_WIDTH, (GRID_HEIGHT - (2.0 * border)) / GRID_HEIGHT);
    if (!_.isEqual(this.frame(), fullFrame)) {
      this.rememberFrame();
      return this.toGrid(border / GRID_WIDTH, border / GRID_HEIGHT, (GRID_WIDTH - (2.0 * border)) / GRID_WIDTH, (GRID_HEIGHT - (2.0 * border)) / GRID_HEIGHT);
    } else if (lastFrames[this.uid()]) {
      this.setFrame(lastFrames[this.uid()]);
      return this.forgetFrame();
    }
  };

  Window.prototype.toggleFullScreen = function() {
    var fullFrame;
    fullFrame = this.calculateGrid(0, 0, 1, 1);
    if (!_.isEqual(this.frame(), fullFrame)) {
      this.rememberFrame();
      return this.toGrid(0, 0, 1, 1);
    } else if (lastFrames[this.uid()]) {
      this.setFrame(lastFrames[this.uid()]);
      return this.forgetFrame();
    }
  };

  Window.prototype.resizeWindow = function(direction) {
    var current_position, fiba_height, fiba_width, fibb_height, fibb_width, full_height, full_width, half_height, half_width, new_height, new_width, new_x, new_y;
    half_width = Math.round(0.5 * GRID_WIDTH);
    half_height = Math.round(0.5 * GRID_HEIGHT);
    full_width = 1 * GRID_WIDTH;
    full_height = 1 * GRID_HEIGHT;
    fiba_width = Math.round(GRID_A_RATIO * GRID_WIDTH);
    fiba_height = Math.round(GRID_A_RATIO * GRID_HEIGHT);
    fibb_width = Math.round(GRID_B_RATIO * GRID_WIDTH);
    fibb_height = Math.round(GRID_B_RATIO * GRID_HEIGHT);
    current_position = this.gridCurrentPosition();
    new_x = current_position.x;
    new_y = current_position.y;
    new_width = current_position.width;
    new_height = current_position.height;
    if (direction === 'left') {
      if (current_position.width === half_width && current_position.height !== full_height) {
        new_width = half_width;
        new_x = 0;
        new_height = full_height;
        new_y = 0;
      } else if (current_position.width === fiba_width && current_position.height !== full_height) {
        new_width = fiba_width;
        new_x = 0;
        new_height = full_height;
        new_y = 0;
      } else if (current_position.width === fibb_width && current_position.height !== full_height) {
        new_width = fiba_width;
        new_x = 0;
        new_height = full_height;
        new_y = 0;
      } else if ((current_position.width === half_width && current_position.x === 0) || current_position.width === fibb_width) {
        new_width = fiba_width;
        new_x = 0;
        new_height = full_height;
        new_y = 0;
      } else {
        new_width = half_width;
        new_x = 0;
        new_height = full_height;
        new_y = 0;
      }
    } else if (direction === 'right') {
      if (current_position.width === half_width && current_position.height !== full_height) {
        new_width = half_width;
        new_x = half_width;
        new_height = full_height;
        new_y = 0;
      } else if (current_position.width === fibb_width && current_position.height !== full_height) {
        new_width = fibb_width;
        new_x = fiba_width;
        new_height = full_height;
        new_y = 0;
      } else if (current_position.width === fibb_width || (current_position.width === half_width && current_position.x === 0)) {
        new_width = half_width - 1;
        new_x = half_width;
        new_height = full_height;
        new_y = 0;
      } else if (current_position.width === (half_width - 1) && current_position.x === half_width) {
        new_width = fiba_width;
        new_x = fibb_width;
        new_height = full_height;
        new_y = 0;
      } else if (current_position.width === fiba_width && current_position.x === fibb_width) {
        new_width = 17;
        new_x = GRID_WIDTH - new_width;
        new_height = full_height;
        new_y = 0;
      } else {
        new_width = fibb_width;
        new_x = fiba_width;
        new_height = full_height;
        new_y = 0;
      }
    } else if (direction === 'top') {
      new_height = fiba_height;
      new_y = 0;
    } else if (direction === 'bottom') {
      new_height = fibb_height;
      new_y = fiba_height;
    }
    if (new_x !== 0) {
      new_x = new_x / GRID_WIDTH;
    }
    if (new_y !== 0) {
      new_y = new_y / GRID_HEIGHT;
    }
    return this.toGrid(new_x, new_y, new_width / GRID_WIDTH, new_height / GRID_HEIGHT);
  };

  Window.prototype.toggleStackedWindows = function() {
    var allVisible, stackedWindows, topMostWindow;
    stackedWindows = [];
    allVisible = Window.recent();
    _.each(allVisible, function(window) {
      if (_.isEqual(this.frame, window.frame())) {
        return stackedWindows.push(window);
      }
    });
    topMostWindow = stackedWindows.pop();
    return topMostWindow.focus();
  };

  Window.prototype.focusToFrontLeft = function() {
    var sortedTargets, targets, topMostLeft, win;
    win = Window.focused();
    targets = win.neighbours('west');
    sortedTargets = Window.sortByMostRecent(targets);
    if (sortedTargets.length) {
      topMostLeft = sortedTargets[0];
      return topMostLeft.focus();
    }
  };

  Window.prototype.focusToFrontRight = function() {
    var sortedTargets, targets, topMostRight, win;
    win = Window.focused();
    targets = win.neighbours('east');
    sortedTargets = Window.sortByMostRecent(targets);
    if (sortedTargets.length) {
      topMostRight = sortedTargets[0];
      return topMostRight.focus();
    }
  };

  keys = [];

  key_binding = function(key, modifier, fn) {
    return keys.push(Key.on(key, modifier, fn));
  };

  shiftCmd = 'shift+cmd'.split('+');

  ctrlAltCmd = 'ctrl+alt+cmd'.split('+');

  key_binding('H', ctrlAltCmd, function() {
    return Window.focused().resizeWindow('left');
  });

  key_binding('L', ctrlAltCmd, function() {
    return Window.focused().resizeWindow('right');
  });

  key_binding('K', ctrlAltCmd, function() {
    return Window.focused().resizeWindow('top');
  });

  key_binding('J', ctrlAltCmd, function() {
    return Window.focused().resizeWindow('bottom');
  });

  key_binding('F', ctrlAltCmd, function() {
    return Window.focused().toggleFullScreen();
  });

  key_binding('A', ctrlAltCmd, function() {
    return Window.focused().toggleBorderedScreen(0.5);
  });

  key_binding('`', ctrlAltCmd, function() {
    return Window.focused().toggleStackedWindows();
  });

  key_binding('H', shiftCmd, function() {
    return Window.focused().focusToFrontLeft();
  });

  key_binding('L', shiftCmd, function() {
    return Window.focused().focusToFrontRight();
  });

}).call(this);
