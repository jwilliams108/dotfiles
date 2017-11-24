#include "tada68.h"
#include "timer.h"

// Layer definitions for readability
enum custom_layers {
  _BL,
  _FL,
  _ML
};

// special keys
#define CTRLESC MT(MOD_LCTL, KC_ESC)
#define HYPER   LALT(LGUI(KC_LCTL))

enum custom_keycodes {
  LSFT_PN = SAFE_RANGE,
  RSFT_PN,
  LGUI_BR,
  RGUI_BR
};

// Length of time before a tap is considered a hold
#define TAPPING_TERM 165

// Fillers to make layering clear
#define _______ KC_TRNS
#define XXXXXXX KC_NO

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
   * |Hypr|Alt |Cmd |        Space          |Cmd| FN|  ML|Lef|Dow|Rig |
   * `----------------------------------------------------------------'
   *
   *  Ctrl <-- tap for escape (left only)
   *   Cmd <-- tap for braces
   * Shift <-- tap for parenthesis
   */
[_BL] = KEYMAP_ANSI(
  KC_ESC,  KC_1,   KC_2,   KC_3,   KC_4,   KC_5,   KC_6,   KC_7,   KC_8,     KC_9,   KC_0,KC_MINS,  KC_EQL, KC_BSPC, KC_GRV, \
  KC_TAB,  KC_Q,   KC_W,   KC_E,   KC_R,   KC_T,   KC_Y,   KC_U,   KC_I,     KC_O,   KC_P,KC_LBRC, KC_RBRC, KC_BSLS, KC_DEL, \
 CTRLESC,  KC_A,   KC_S,   KC_D,   KC_F,   KC_G,   KC_H,   KC_J,   KC_K,     KC_L,KC_SCLN,KC_QUOT,           KC_ENT,KC_PGUP, \
 LSFT_PN,          KC_Z,   KC_X,   KC_C,   KC_V,   KC_B,   KC_N,   KC_M,  KC_COMM, KC_DOT,KC_SLSH, RSFT_PN,   KC_UP,KC_PGDN, \
   HYPER, KC_LALT, LGUI_BR,                KC_SPC,                        RGUI_BR,MO(_FL),MO(_ML), KC_LEFT, KC_DOWN,KC_RGHT),

  /* Keymap _FL: Function Layer + volume controls
   * ,----------------------------------------------------------------.
   * |   | F1|F2 |F3 |F4 |F5 |F6 |F7 |F8 |F9 |F10|F11|F12|Del    |Ins |
   * |----------------------------------------------------------------|
   * |     | F7| F5| F8|   |   |   |   |   |   |   |   |   |     |Hme |
   * |----------------------------------------------------------------|
   * |      |   |VU-|VU+|MUT|   |   |   |   |   |   |   |        |End |
   * |----------------------------------------------------------------|
   * |        |   |   |   |   |   |   |   |   |   |   |      |   |    |
   * |----------------------------------------------------------------|
   * |    |    |    |                       |   |   |    |   |   |    |
   * `----------------------------------------------------------------'
   *
   * F5 <-- cmus play/pause
   * F7 <-- cmus prev
   * F8 <-- cmus next
   */
[_FL] = KEYMAP_ANSI(
  _______,  KC_F1,  KC_F2,  KC_F3,  KC_F4,  KC_F5,  KC_F6,  KC_F7,  KC_F8,  KC_F9, KC_F10, KC_F11, KC_F12, KC_DEL, KC_INS, \
  _______,  KC_F7,  KC_F5,  KC_F8,_______,_______,_______,_______,_______,_______,_______,_______,_______,_______,KC_HOME, \
  _______,_______,KC_VOLD,KC_VOLU,KC_MUTE,_______,_______,_______,_______,_______,_______,_______,        _______, KC_END, \
  _______,        _______,_______,_______,_______,_______,_______,_______,_______,_______,_______,_______,_______,_______, \
  _______,_______,_______,                _______,                        _______,_______,_______,_______,_______,_______),

  /* Keymap _ML: Media Layer
   * ,----------------------------------------------------------------.
   * |   |   |   |   |   |MPL|   |MRW|MFF|   |   |   |MUT|VU-    |VU+ |
   * |----------------------------------------------------------------|
   * |     |MRW|MPL|MFF|   |   |   |   |   |   |   |   |   |     |    |
   * |----------------------------------------------------------------|
   * |      |   |VU-|VU+|MUT|   |   |   |   |   |   |   |        |    |
   * |----------------------------------------------------------------|
   * |        |   |   |   |   |   |   |   |   |   |   |      |   |    |
   * |----------------------------------------------------------------|
   * |    |    |    |                       |   |   |    |   |   |    |
   * `----------------------------------------------------------------'
   */
[_ML] = KEYMAP_ANSI(
  _______,_______,_______,_______,_______,KC_MPLY,_______,KC_MRWD,KC_MFFD,_______,_______,_______,KC_MUTE,KC_VOLD,KC_VOLU, \
  _______,KC_MRWD,KC_MPLY,KC_MFFD,_______,_______,_______,_______,_______,_______,_______,_______,_______,_______,_______, \
  _______,_______,KC_VOLD,KC_VOLU,KC_MUTE,_______,_______,_______,_______,_______,_______,_______,        _______,_______, \
  _______,        _______,_______,_______,_______,_______,_______,_______,_______,_______,_______,_______,_______,_______, \
  _______,_______,_______,                _______,                        _______,_______,_______,_______,_______,_______),
};

static uint16_t key_timer[4]; // this must match the length of the custom_keycodes enum

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
    case LSFT_PN:
      if (record->event.pressed) {
        key_timer[0] = timer_read();
        register_code(KC_LSFT);
      } else {
        unregister_code(KC_LSFT);
        if (timer_elapsed(key_timer[0]) < TAPPING_TERM) {
          SEND_STRING("(");
        }
      }
      return false; break;
    case RSFT_PN:
      if (record->event.pressed) {
        key_timer[1] = timer_read();
        register_code(KC_RSFT);
      } else {
        unregister_code(KC_RSFT);
        if (timer_elapsed(key_timer[1]) < TAPPING_TERM) {
          SEND_STRING(")");
        }
      }
      return false; break;
    case LGUI_BR:
      if (record->event.pressed) {
        key_timer[2] = timer_read();
        register_code(KC_LGUI);
      } else {
        unregister_code(KC_LGUI);
        if (timer_elapsed(key_timer[2]) < TAPPING_TERM) {
          SEND_STRING("{");
        }
      }
      return false; break;
    case RGUI_BR:
      if (record->event.pressed) {
        key_timer[3] = timer_read();
        register_code(KC_RGUI);
      } else {
        unregister_code(KC_RGUI);
        if (timer_elapsed(key_timer[3]) < TAPPING_TERM) {
          SEND_STRING("}");
        }
      }
      return false; break;
  }
  return true;
};
