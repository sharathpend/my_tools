### GNU Screen: Basic Usage

#### Introduction
GNU Screen is a terminal multiplexer that lets you run multiple shell sessions inside a single SSH connection. You can detach, reattach, split windows, scrollback, and keep processes running even if your SSH session drops.

#### Starting a Screen Session
- Start a new session with a default name:
    ```bash
    screen
    ```
- Start a named session (helps when managing multiple):
    ```bash
    screen -S mysession
    ```

#### Detaching & Reattaching
- Detach from the current session (leave it running in the background):  
  Press `Ctrl-a` then `d`
- List existing sessions:
    ```bash
    screen -ls
    ```
- Reattach to the most recently used session:
    ```bash
    screen -r
    ```
- Reattach to a named session:
    ```bash
    screen -r mysession
    ```
- Force-detach elsewhere and reattach here:
    ```bash
    screen -d -r mysession
    ```

#### Managing Windows
- Create a new window:  
  `Ctrl-a` then `c`
- Cycle to next window:  
  `Ctrl-a` then `n`
- Cycle to previous window:  
  `Ctrl-a` then `p`
- Jump directly to window N (0–9):  
  `Ctrl-a` then `N`

#### Splitting Panes
- Split horizontally:  
  `Ctrl-a` then `S`
- Split vertically:  
  `Ctrl-a` then `|`
- Switch focus between regions:  
  `Ctrl-a` then `Tab`
- Close the current region:  
  `Ctrl-a` then `Q`

#### Copy & Paste (Scrollback)
1. Enter copy/scrollback mode:  
   `Ctrl-a` then `[`
2. Scroll with arrow keys or PageUp/PageDown.
3. Start selection:  
   Press `Space` at the start.
4. End selection:  
   Move to the end and press `Space` again.
5. Paste into the window:  
   `Ctrl-a` then `]`

#### Logging Output
- Toggle logging on/off (writes to `screenlog.0`):  
  `Ctrl-a` then `H`

#### Exiting & Killing
- Exit the shell in a window (closes that window):  
  Type `exit` or press `Ctrl-d`
- Kill the current window immediately:  
  `Ctrl-a` then `K` (confirm with `y`)
- Kill the entire session:  
  `Ctrl-a` then `\` (confirm with `y`)

#### Tips & Tricks
- Attach to a session from multiple terminals (shared view):  
  ```bash
  screen -x mysession
