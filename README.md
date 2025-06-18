# 🛠️ PowerShell Productivity Profile

Supercharge your Windows PowerShell!
This profile brings some of the best of Unix-like command line utilities, smart Python/dev workflow helpers, and handy PowerShell shortcuts—all in one file. Perfect for developers, sysadmins, and power users.

---

## ✨ Features & Highlights

### Classic \*nix Commands (with PowerShell style)

* **`grep`** – Pattern search with color, invert, count, match-only, and case-insensitive options
* **`head`, `tail`** – Quickly preview file and command output (with `-head`, `-tail` for flexibility)
* **`lst`** – List directory contents sorted by last modified
* **`df`, `du`** – Show drive or folder size summaries

### Smart File Utilities

* **`touch`** – Create files or update timestamps
* **`basename` / `dirname`** – Path manipulation helpers

### Dev Shortcuts

* **`pp`** – Shortcut for robust `pip install` (Python, behind safe `--trusted-host`)
* **`uptime`** – Show time since your last Windows boot

### Aliases & Customizations

* **`vi`, `vim`, `oldvim`** – Alias all your vi/vim needs to Neovim (`nvim`)
* **`alias`** – List all current PowerShell aliases

### Tab Completion for Azure CLI (`az`)

* Native autocompletion for `az` commands—just hit `[Tab]`!

---

## 📦 Installation

**Quick Start:**
Download the `profile.ps1` script from this repo, and add it to your PowerShell `$PROFILE`.

### 1. Clone or Download

```powershell
git clone https://github.com/nickrmorris/pwsh-profile.git
cd pwsh-profile
```

Or download `pwsh_profile.ps1` directly.

### 2. Back Up Your Existing Profile

```powershell
if (Test-Path $PROFILE) { Copy-Item $PROFILE "$PROFILE.bak" }
```

### 3. Install This Profile

Copy the script contents into your PowerShell profile:

```powershell
notepad $PROFILE
```

Paste the contents of `profile.ps1` and save.

Or, to **overwrite your profile** directly (**CAUTION:** This will replace your profile!):

```powershell
Copy-Item .\profile.ps1 $PROFILE -Force
```

### 4. Reload PowerShell

Open a new PowerShell window, or run:

```powershell
. $PROFILE
```

---

## 🏗️ Usage Examples

#### Search text and files

```powershell
Get-Content myfile.txt | grep -i "error"
Get-ChildItem | grep "log$"         # Search filenames
```

#### Show the first/last N lines

```powershell
Get-Content myfile.txt | head -Count 20
Get-Content myfile.txt | tail -Count 50
```

#### Directory size and free space

```powershell
du C:\Projects
df
```

#### File timestamp or creation

```powershell
touch newfile.txt
```

#### Path utilities

```powershell
basename "C:\foo\bar\baz.txt"   # → baz.txt
dirname  "C:\foo\bar\baz.txt"   # → C:\foo\bar
```

#### Dev Python shortcut

```powershell
pp install requests beautifulsoup4
```

#### Uptime

```powershell
uptime
```

---

## 🧩 Custom Aliases

| Alias  | Expands to | Description                 |
| ------ | ---------- | --------------------------- |
| vi     | nvim       | Use Neovim as `vi`          |
| vim    | nvim       | Use Neovim as `vim`         |
| oldvim | vim        | Original vim (if available) |

---

## 📝 Tips

* All functions work natively with pipelines:
  `Get-Content ... | grep ... | head`
* Designed for PowerShell 5+ and Windows 10/11 (but portable!)

---

## 🤝 Contributing

Feel free to submit pull requests for new helper functions, bug fixes, or documentation improvements!

---