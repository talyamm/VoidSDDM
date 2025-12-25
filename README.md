# Void SDDM Theme

A minimal and clean SDDM login theme with customizable appearance and smooth animations.

**[Watch Showcase Video](assets/showcase.mp4)**

## Installation

### Clone from GitHub

```bash
git clone https://github.com/talyamm/voidsddm.git
```

### Copy to SDDM themes directory:

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

### Previewing a theme

You can preview the set theme without logging out by runnning:

```bash
sddm-greeter --test-mode --theme /usr/share/sddm/themes/voidsddm
```

## Themes

The theme includes multiple color schemes in the `configs/` folder:

- `default.conf` - Default black theme
- `gruvbox.conf` - Gruvbox color scheme
- `everforest.conf` - Everforest color scheme
- `catppuccin.conf` - Catppuccin Mocha color scheme
- `nord.conf` - Nord color scheme

To switch themes, edit `metadata.desktop` and change the `ConfigFile` value:

```bash
sudo nano /usr/share/sddm/themes/voidsddm/metadata.desktop
```

Change the `ConfigFile` line to your desired theme:

```ini
ConfigFile=configs/gruvbox.conf
```

## Keyboard Navigation

- **Arrow Keys**: Navigate between selectors and options
- **Enter**: Activate selected option or authenticate
- **F10**: Suspend system
- **F11**: Shutdown system
- **F12**: Restart system

## Requirements

- SDDM (Simple Desktop Display Manager)
- Qt 6