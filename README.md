# dis-vm-daemon

A GitHub Action for downloading, installing, and running vm-daemon - a persistent daemon ecosystem where there are no files, only persistent daemons.

## Usage

### Basic Usage

To use this action in your workflow, add the following step:

```yaml
- name: Setup VM Daemon
  uses: o9nn/dis-vm-daemon/.github/actions/setup-vm-daemon@main
  with:
    version: 'latest'
    install-vscode: 'true'
```

### Inputs

- `version` (optional): Version of vm-daemon to install. Default: `latest`
- `download-url` (optional): Custom download URL for vm-daemon.tar.gz
- `install-vscode` (optional): Whether to ensure VSCode is installed. Default: `true`

### Outputs

- `daemon-path`: Path to the installed vm-daemon
- `process-id`: Process ID of the running vm-daemon
- `vscode-path`: Path to VSCode installation

### Example Workflow

```yaml
name: VM Daemon Setup

on:
  push:
    branches: [ main ]
  workflow_dispatch:

jobs:
  setup-vm-daemon:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4
      
      - name: Setup VM Daemon
        uses: o9nn/dis-vm-daemon/.github/actions/setup-vm-daemon@main
        with:
          version: 'latest'
          install-vscode: 'true'
      
      - name: Verify installation
        run: |
          echo "✓ vm-daemon is ready"
```

## What It Does

The action performs the following steps:

1. **Download vm-daemon**: Downloads the vm-daemon binary
2. **Verify vm-daemon.tar.gz**: Verifies the integrity of the downloaded file
3. **Run 'vm-daemon install' command**: Installs vm-daemon to `~/.vm-daemon/bin`
4. **Ensure VSCode is installed**: Checks and prepares VSCode environment
5. **Start vm-daemon**: Starts the daemon service

## Output Example

```
Download vm-daemon
✓ Download completed

Verify vm-daemon.tar.gz: OK
✓ vm-daemon.tar.gz: OK

Run 'vm-daemon install' command...
│ service: vm-daemon
│ process_id: 338

Ensuring VSCode is installed...
│ component: ensureVSCodeInstalled
│ vscodePath: /home/{os}/.vm-daemon/bin/vm-daemon-*

⣯ ... (animated)

Startup completed
[Status] Starting vm-daemon...

│ service: vm-daemon
│ status: running
│ process_id: 338

✓ vm-daemon is ready and running
```

## Testing Locally

You can test the vm-daemon installation process locally using the provided test script:

```bash
./test-vm-daemon.sh latest
```

This will simulate the entire installation process and create the necessary directories under `~/.vm-daemon/bin/`.

## Development

### Directory Structure

```
.github/
├── actions/
│   └── setup-vm-daemon/
│       └── action.yml          # Reusable composite action
└── workflows/
    ├── vm-daemon.yml           # Main workflow
    └── example-usage.yml       # Example usage patterns
```

### Files

- **action.yml**: The composite action that can be reused in any workflow
- **vm-daemon.yml**: The main workflow that runs on push/PR
- **example-usage.yml**: Examples of different usage patterns
- **test-vm-daemon.sh**: Local testing script to simulate installation

## License

See [LICENSE](LICENSE) file for details.