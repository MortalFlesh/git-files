VS-Code
=======

## Fixing a font on Mojave OS
After mojave OS upgrade run to restore font quality (see https://github.com/atom/atom/issues/17486#issuecomment-424140110)
```bash
defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
```

