# SecureKeyboard
an iOS secure and extendable keyboard UIView, not an IME.

## why secure
- random keys when shown everytime;
- no thumbnail shown when typing a key, in case of screen recording.

## why extendable
- the library is well architectured, you just need to implement your own key layout. just refer to one of NSKKeyboardTypingNumView/NSKKeyboardTypingCharacterView/NSKKeyboardTypingSymbolView.

it supports 3 layouts by now:

(black border in screenshots is emulator border)

symbols

![效果](https://github.com/macarthor/SecureKeyboard/blob/master/images/symbol.png)

characters

![效果](https://github.com/macarthor/SecureKeyboard/blob/master/images/character.png)

numbers

![效果](https://github.com/macarthor/SecureKeyboard/blob/master/images/number.png)
