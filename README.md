# Void SDDM Theme

A minimal and clean SDDM login theme with customizable appearance and smooth animations.

![Screenshot](assets/screenshot.jpg)

## Installation

### Clone from GitHub

```bash
git clone https://github.com/talyamm/voidsddm.git
```

### Then copy it to the SDDM themes directory:

```bash
sudo cp -r voidsddm /usr/share/sddm/themes/
```

### Edit the configuration file:

```bash
sudo nano /etc/sddm.conf
```

```ini
[Theme]
Current=voidsddm
```

### Restart SDDM service:

```bash
sudo systemctl restart sddm
```

## Keyboard Navigation

- **Arrow Keys**: Navigate between selectors and options
- **Enter**: Activate selected option or authenticate
- **F10**: Suspend system
- **F11**: Shutdown system
- **F12**: Restart system

## Configuration

All settings can be customized in `theme.conf`:

### Appearance

- `background`: Background color
- `textColor`: Main text color
- `fontFamily`: Font family for all text
- `elementOpacity`: Global opacity for all elements (0.0-1.0)

### Password Field

- `passwordFieldWidth`: Width of password field
- `passwordFieldHeight`: Height of password field
- `passwordFieldFontSize`: Font size for password field
- `passwordFieldBackground`: Background color
- `passwordFieldBorder`: Border color
- `passwordFieldBorderActive`: Active border color
- `passwordFieldRadius`: Border radius
- `showPasswordButton`: Show password visibility toggle
- `passwordFieldOffsetX`: Horizontal offset
- `passwordFieldOffsetY`: Vertical offset

### Selectors

- `selectorHeight`: Height of selector boxes
- `selectorArrowWidth`: Width of arrow buttons
- `selectorRadius`: Border radius
- `selectorFontSize`: Font size for selector text
- `selectorBackground`: Background color
- `showSelectorPreview`: Show user/session preview text
- `selectorPreviewFontSize`: Font size for preview text
- `selectorPreviewColor`: Color for preview text
- `selectorPreviewMargin`: Margin from password field

### Animations

- `fadeInDuration`: Duration of fade-in animation in milliseconds
- `animationDuration`: Duration of other animations

### Help & Indicators

- `showHelpTips`: Show keyboard shortcuts help
- `helpTipsFontSize`: Font size for help tips
- `helpTipsColor`: Color for help tips
- `showCapsLockIndicator`: Show Caps Lock indicator
- `capsLockIndicatorColor`: Color for Caps Lock indicator
- `capsLockIndicatorFontSize`: Font size for Caps Lock indicator

### Login Error

- `loginErrorColor`: Border color on authentication error
- `loginErrorShake`: Enable shake animation on error
- `loginErrorBorderWidth`: Border width on error
- `loginErrorDelay`: Delay before checking login failure in milliseconds
- `clearPasswordOnError`: Clear password field after error

### Security

- `allowEmptyPassword`: Allow authentication with empty password
- `showCursor`: Show mouse cursor
- QML (Qt Quick 2.0)

## Requirements

- SDDM (Simple Desktop Display Manager)
- Qt 6