### 1. Install Spicetify

Run this PowerShell command to install Spicetify:

```powershell
iwr -useb https://raw.githubusercontent.com/spicetify/cli/main/install.ps1 | iex
```

This will download and install **Spicetify CLI**.

### 2. Install Spicetify Marketplace

Next, install **Spicetify Marketplace** to access additional themes, extensions, and tools:

```powershell
Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/spicetify/spicetify-marketplace/main/resources/install.ps1" | Invoke-Expression
```

This will install the marketplace.

### 3. Install Dribblish (Spotify Theme)

Now, install the **Dribblish** theme from Spicetify Themes:

```powershell
Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/spicetify/spicetify-themes/master/Dribbblish/install.ps1" | Invoke-Expression
```

This will install **Dribblish** as a theme.

### 4. Apply Catppuccin Frappe Theme

Finally, apply the **Catppuccin Frappe** color scheme to Dribblish:

```powershell
spicetify config color_scheme catppuccin-frappe
spicetify apply
```

This will set the **Catppuccin Frappe** theme variant within the Dribblish theme.

### Recap
- **Spicetify CLI** is installed with the first PowerShell command.
- **Spicetify Marketplace** is installed using the second command.
- **Dribblish** is installed from the Spicetify Themes repository.
- **Catppuccin Frappe** is applied with the final `spicetify` configuration.