#include "tada68.h"
#include "timer.h"

#define TAPPING_TERM 165
#define _______ KC_TRNS

// Each layer gets a name for readability, which is then used in the keymap matrix below.
// The underscores don't mean anything - you can have a layer called STUFF or any other name.
// Layer names don't all need to be of the same length, obviously, and you can also skip them
// entirely and just use numbers.
#define _BL 0
#define _FL 1

// special keys
#define CTRLESC MT(MOD_LCTL, KC_ESC)
#define HYPER   LALT(LGUI(KC_LCTL))

// tap/hold macros
#define LSFT_PAREN 0
#define RSFT_PAREN 1
#define LGUI_BRACE 2
#define RGUI_BRACE 3

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  /* Keymap _BL: (Base Layer) Default Layer
   * ,----------------------------------------------------------------.
   * |Esc | 1|  2|  3|  4|  5|  6|  7|  8|  9|  0|  -|  =|Backsp |~ ` |
   * |----------------------------------------------------------------|
   * |Tab  |  Q|  W|  E|  R|  T|  Y|  U|  I|  O|  P|  [|  ]|  \  |Del |
   * |----------------------------------------------------------------|
   * |  Ctrl |  A|  S|  D|  F|  G|  H|  J|  K|  L|  ;|  '|Return |PgUp|
   * |----------------------------------------------------------------|
   * |Shift   |  Z|  X|  C|  V|  B|  N|  M|  ,|  .|  /|Shift | Up|PgDn|
   * |----------------------------------------------------------------|
   * |Hypr|Alt |Cmd |        Space          |Cmd| FN|Ctrl|Lef|Dow|Rig |
   * `----------------------------------------------------------------'
   *
   *  Ctrl <-- tap for escape
   *   Cmd <-- tap for braces
   * Shift <-- tap for parenthesis
   */
[_BL] = KEYMAP_ANSI(
  KC_ESC,  KC_1,   KC_2,   KC_3,   KC_4,   KC_5,   KC_6,   KC_7,   KC_8,     KC_9,   KC_0,KC_MINS,  KC_EQL, KC_BSPC, KC_GRV, \
  KC_TAB,  KC_Q,   KC_W,   KC_E,   KC_R,   KC_T,   KC_Y,   KC_U,   KC_I,     KC_O,   KC_P,KC_LBRC, KC_RBRC, KC_BSLS, KC_DEL, \
 CTRLESC,  KC_A,   KC_S,   KC_D,   KC_F,   KC_G,   KC_H,   KC_J,   KC_K,     KC_L,KC_SCLN,KC_QUOT,           KC_ENT,KC_PGUP, \
    M(0),          KC_Z,   KC_X,   KC_C,   KC_V,   KC_B,   KC_N,   KC_M,  KC_COMM, KC_DOT,KC_SLSH,    M(1),   KC_UP,KC_PGDN, \
   HYPER, KC_LALT,    M(2),                KC_SPC,                            M(3),MO(_FL),KC_RCTRL,KC_LEFT,KC_DOWN,KC_RGHT),

  /* Keymap _FL: Function Layer
   * ,----------------------------------------------------------------.
   * |   | F1|F2 |F3 |F4 |F5 |F6 |F7 |F8 |F9 |F10|F11|F12|Del    |Ins |
   * |----------------------------------------------------------------|
   * |     |   |   |   |   |   |   |   |   |   |   |   |   |     |Hme |
   * |----------------------------------------------------------------|
   * |      |   |VU-|VU+|MUT|   |   |   |   |   |   |   |        |End |
   * |----------------------------------------------------------------|
   * |        |   |   |   |   |   |   |   |   |   |   |      |   |    |
   * |----------------------------------------------------------------|
   * |    |    |    |                       |   |   |    |   |   |    |
   * `----------------------------------------------------------------'
   */
[_FL] = KEYMAP_ANSI(
  _______,  KC_F1,  KC_F2,  KC_F3,  KC_F4,  KC_F5,  KC_F6,  KC_F7,  KC_F8,  KC_F9, KC_F10, KC_F11, KC_F12, KC_DEL, KC_INS, \
  _______,_______,_______,_______,_______,_______,_______,_______,_______,_______,_______,_______,_______,_______,KC_HOME, \
  _______,_______,KC_VOLD,KC_VOLU,KC_MUTE,_______,_______,_______,_______,_______,_______,_______,        _______, KC_END, \
  _______,        _______,_______,_______,_______,_______,_______,_______,_______,_______,_______,_______,_______,_______, \
  _______,_______,_______,                _______,                        _______,_______,_______,_______,_______,_______),
};

static uint16_t start[4];

const macro_t *action_get_macro(keyrecord_t *record, uint8_t id, uint8_t opt) {
  switch(id) {
    case LSFT_PAREN:
      if (record->event.pressed) {
        start[LSFT_PAREN] = timer_read();
        return MACRO(D(LSFT), END);
      } else {
        if (timer_elapsed(start[LSFT_PAREN]) > TAPPING_TERM) {
          return MACRO(U(LSFT), END);
        } else {
          return MACRO(D(LSFT), T(9), U(LSFT), END);
        }
      }
      break;
    case RSFT_PAREN:
      if (record->event.pressed) {
        start[RSFT_PAREN] = timer_read();
        return MACRO(D(RSFT), END);
      } else {
        if (timer_elapsed(start[RSFT_PAREN]) > TAPPING_TERM) {
          return MACRO(U(RSFT), END);
        } else {
          return MACRO(D(RSFT), T(0), U(RSFT), END);
        }
      }
      break;
    case LGUI_BRACE:
      if (record->event.pressed) {
        start[LGUI_BRACE] = timer_read();
        return MACRO(D(LGUI), END);
      } else {
        if (timer_elapsed(start[LGUI_BRACE]) > TAPPING_TERM) {
          return MACRO(U(LGUI), END);
        } else {
          return MACRO(U(LGUI), D(LSFT), T(LBRACKET), U(LSFT), END);
        }
      }
      break;
    case RGUI_BRACE:
      if (record->event.pressed) {
        start[RGUI_BRACE] = timer_read();
        return MACRO(D(RGUI), END);
      } else {
        if (timer_elapsed(start[RGUI_BRACE]) > TAPPING_TERM) {
          return MACRO(U(RGUI), END);
        } else {
          return MACRO(U(RGUI), D(LSFT), T(RBRACKET), U(LSFT), END);
        }
      }
      break;
  }
  return MACRO_NONE;
}
