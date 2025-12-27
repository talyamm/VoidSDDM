# Void SDDM Theme

A minimal and clean SDDM login theme with customizable appearance and smooth animations.

https://github.com/user-attachments/assets/3466105d-9b18-4c78-8c42-7708ccf43605

# Presets

<details>
  <summary>configs/default.conf</summary>
<img width="327" height="177" alt="image" src="https://github.com/user-attachments/assets/1c27810f-a00a-484f-98e0-9b5df6603a81" />
</details>

<details>
  <summary>configs/gruvbox.conf</summary>
<img width="344" height="189" alt="image" src="https://github.com/user-attachments/assets/2fb87d54-c416-463c-a43f-be19ba37b584" />
</details>

<details>
  <summary>configs/everforest.conf</summary>
<img width="331" height="183" alt="image" src="https://github.com/user-attachments/assets/3cb8eec8-eb6f-4bc2-8a10-074b8a0ace83" />
</details>

<details>
  <summary>configs/catppuccin.conf</summary>
<img width="337" height="171" alt="image" src="https://github.com/user-attachments/assets/15c1f695-3fed-4101-b1e0-a2c74b9be156" />
</details>

<details>
  <summary>configs/nord.conf</summary>
<img width="334" height="169" alt="image" src="https://github.com/user-attachments/assets/22c037a4-d43b-42bb-8123-1d40e3ff2784" />
</details>

<details>
  <summary>configs/tokyonight.conf</summary>
<img width="328" height="203" alt="image" src="https://github.com/user-attachments/assets/37c21b4a-afb6-47dc-8874-33ddc179f3d8" />
</details>

[`Customization guide`](#Themes)

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

# Themes

The theme includes multiple color schemes in the `configs/` folder:

- `default.conf` - Default black theme
- `gruvbox.conf` - Gruvbox color scheme
- `everforest.conf` - Everforest color scheme
- `catppuccin.conf` - Catppuccin Mocha color scheme
- `nord.conf` - Nord color scheme
- `tokyonight.conf` - Tokyo Night color scheme

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
