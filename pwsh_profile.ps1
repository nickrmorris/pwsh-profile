Function grep {
    param (
        [string]$Pattern,
        [switch]$i,    # Ignore case
        [switch]$v,    # Invert match
        [switch]$c,    # Count matches
        [switch]$o     # Show only matching text
    )

    begin {
        # Build regex pattern with explicit case sensitivity
        $matchPattern = if ($i) { "(?i)$Pattern" } else { "(?-i)$Pattern" }

        # Initialize results array
        $results = @()
    }

    process {
        # Ensure input exists before processing
        if ($_ -ne $null) {
            # Handle filenames/directories separately
            if ($_ -is [System.IO.FileInfo] -or $_ -is [System.IO.DirectoryInfo]) {
                $matches = $_ | Where-Object { $_.Name -match $matchPattern }
            } else {
                # Handle text content search
                $matches = $_ | Select-String -Pattern $matchPattern
            }

            # Handle -v (invert match)
            if ($v) {
                $matches = $_ | Where-Object { $_ -notmatch $matchPattern }
            }

            # Store results
            $results += $matches
        }
    }

    end {
        # Handle -c (Count matches, return only a single number)
        if ($c) {
            Write-Output ($results | Measure-Object).Count
            return  # Ensures only the count is output, not matched items
        }

        # Handle -o (Show only matching text)
        if ($o) {
            $results | ForEach-Object { $_.Matches.Value }
            return
        }

        # Default output (show full matching results)
        $results
    }
}

Function head {
    param (
        [int]$Count = 10
    )
    begin {
        # Initialize an array to store items
        $items = @()
    }
    process {
        # Collect items from the pipeline
        $items += $_
    }
    end {
        # Output only the first $Count items
        $items | Select-Object -First $Count
    }
}

Function -head {
    param (
        [int]$Count = 10
    )
    begin {
        # Initialize an array to store items
        $items = @()
    }
    process {
        # Collect items from the pipeline
        $items += $_
    }
    end {
        # Output only the first $Count items
        $items | Select-Object -First $Count
    }
}

Function tail {
    param (
        [int]$Count = 10
    )
    begin {
        # Initialize an array to store items
        $items = @()
    }
    process {
        # Collect items from the pipeline
        $items += $_
    }
    end {
        # Output only the last $Count items
        $items | Select-Object -Last $Count
    }
}

Function -tail {
    param (
        [int]$Count = 10
    )
    begin {
        # Initialize an array to store items
        $items = @()
    }
    process {
        # Collect items from the pipeline
        $items += $_
    }
    end {
        # Output only the last $Count items
        $items | Select-Object -Last $Count
    }
}

Function lst {
    Get-ChildItem | Sort-Object LastWriteTime
}

Set-Alias vi nvim
Set-Alias vim nvim
Set-Alias oldvim vim

function pp {
    param(
        [Parameter(ValueFromRemainingArguments = $true)]
        [String[]]$args
    )
    python -m pip install --trusted-host files.pythonhosted.org --trusted-host pypi.org --trusted-host pypi.python.org @args
}
function touch {
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$Path
    )

    if (Test-Path -LiteralPath $Path) {
        # Update the LastWriteTime and LastAccessTime to the current time
        $currentDate = Get-Date
        Set-ItemProperty -LiteralPath $Path -Name LastWriteTime -Value $currentDate
        Set-ItemProperty -LiteralPath $Path -Name LastAccessTime -Value $currentDate
    } else {
        # Create an empty file
        New-Item -ItemType File -Path $Path -Force | Out-Null
    }
}

Function df {
    Get-PSDrive | Where-Object { $_.Used -gt 0 } | Format-Table Name, @{Label="Used(GB)";Expression={"{0:N2}" -f ($_.Used / 1GB)}}, @{Label="Free(GB)";Expression={"{0:N2}" -f ($_.Free / 1GB)}}
}

Function du {
    param(
        [string]$Path = "."
    )
    $size = (Get-ChildItem -Path $Path -Recurse -File | Measure-Object -Property Length -Sum).Sum
    if ($size -gt 1GB) {
        "{0:N2} GB" -f ($size / 1GB)
    } elseif ($size -gt 1MB) {
        "{0:N2} MB" -f ($size / 1MB)
    } elseif ($size -gt 1KB) {
        "{0:N2} KB" -f ($size / 1KB)
    } else {
        "{0} Bytes" -f $size
    }
}

Function basename {
    param([string]$Path)
    [System.IO.Path]::GetFileName($Path)
}

Function dirname {
    param([string]$Path)
    [System.IO.Path]::GetDirectoryName($Path)
}

Function uptime {
    (Get-Date) - (gcim Win32_OperatingSystem).LastBootUpTime
}

Function alias {
    Get-Alias | Sort-Object Name | Format-Table -AutoSize
}

Register-ArgumentCompleter -Native -CommandName az -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
    $completion_file = New-TemporaryFile
    $env:ARGCOMPLETE_USE_TEMPFILES = 1
    $env:_ARGCOMPLETE_STDOUT_FILENAME = $completion_file
    $env:COMP_LINE = $wordToComplete
    $env:COMP_POINT = $cursorPosition
    $env:_ARGCOMPLETE = 1
    $env:_ARGCOMPLETE_SUPPRESS_SPACE = 0
    $env:_ARGCOMPLETE_IFS = "`n"
    $env:_ARGCOMPLETE_SHELL = 'powershell'
    az 2>&1 | Out-Null
    Get-Content $completion_file | Sort-Object | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, "ParameterValue", $_)
    }
    Remove-Item $completion_file, Env:\_ARGCOMPLETE_STDOUT_FILENAME, Env:\ARGCOMPLETE_USE_TEMPFILES, Env:\COMP_LINE, Env:\COMP_POINT, Env:\_ARGCOMPLETE, Env:\_ARGCOMPLETE_SUPPRESS_SPACE, Env:\_ARGCOMPLETE_IFS, Env:\_ARGCOMPLETE_SHELL
}