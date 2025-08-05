# Focus

A simple command-line focus timer that helps you focus on work. It does exactly one thing: count down from a specified time and play a sound when finished.

## Features

- **Simple**: Just counts down and plays a sound
- **Flexible timing**: Support for work sessions, breaks, and custom durations
- **Visual feedback**: Live countdown display in your terminal
- **Audio notification**: Plays system sound 3 times when timer expires (cross-platform)
- **Standalone executable**: Single file you can run anywhere

## Usage

```bash
# Start a 25-minute work session (default)
./focus

# Start a 25-minute work session (explicit)
./focus work

# Start a 5-minute break
./focus break

# Start a custom timer (1-120 minutes)
./focus 15
./focus 45
```

The timer displays a live countdown in MM:SS format and plays a notification sound when it reaches zero. Press Ctrl+C to exit early.

## Installation

### Prerequisites

- Elixir 1.18+ with OTP 27
- Erlang 27+
- macOS (for sound notifications)

### Building from source

1. Clone the repository
2. Install dependencies:
   ```bash
   mix deps.get
   ```
3. Build the executable:
   ```bash
   mix escript.build
   ```
4. Run the timer:
   ```bash
   ./focus
   ```

## Requirements

- **Time range**: Custom times must be between 1 and 120 minutes
- **Platform**: Cross-platform (macOS, Linux, Windows)
- **Sound**: Uses platform-appropriate system sounds

