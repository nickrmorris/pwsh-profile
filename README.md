# PowerShell Productivity Profile

This profile brings some useful Unix-like command line utilities, smart Python/dev workflow helpers, and handy PowerShell shortcuts—all in one file.

---

## Features & Highlights

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

## Installation

**Quick Start:**
Download the `pwsh_profile.ps1` script from this repo, and add its contents to your PowerShell `$PROFILE`.

### 1. Clone or Download

```powershell
git clone https://github.com/nickrmorris/pwsh-profile.git
cd pwsh-profile
```

Or [download `pwsh_profile.ps1`](./pwsh_profile.ps1) directly.

### 2. Back Up Your Existing Profile

```powershell
if (Test-Path $PROFILE) { Copy-Item $PROFILE "$PROFILE.bak" }
```

### 3. Install This Profile

**Option 1: Append/replace by editing**
Copy the contents of `pwsh_profile.ps1` and paste them into your PowerShell profile:

```powershell
notepad $PROFILE
```

* Paste the contents and save.

**Option 2: Overwrite your profile directly**

> ⚠️ *This will replace your current profile script with this one!*

```powershell
Copy-Item .\pwsh_profile.ps1 $PROFILE -Force
```

### 4. Reload PowerShell

Open a new PowerShell window, or run:

```powershell
. $PROFILE
```

---

## Usage Examples

#### Search text and files

```powershell
Get-Content myfile.txt | grep "error" -i
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

## Custom Aliases

| Alias  | Expands to | Description                 |
| ------ | ---------- | --------------------------- |
| vi     | nvim       | Use Neovim as `vi`          |
| vim    | nvim       | Use Neovim as `vim`         |
| oldvim | vim        | Original vim (if available) |

---

## Tips

* All functions work natively with pipelines:
  `Get-Content ... | grep ... | head`
* Designed for PowerShell 5+ and Windows 10/11 (but portable!)

---

## Contributing

Feel free to submit pull requests for new functionality, bug fixes, or documentation improvements.

---