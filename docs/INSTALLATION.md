# Installation Guide

This document provides detailed instructions for installing and setting up the Flag Search Tool.

## Prerequisites

Before installing, ensure your system meets these requirements:

- Bash 4.0 or later
- Standard Unix utilities (`grep`, `find`, etc.)
- Git (for cloning the repository)
- Sufficient permissions to make files executable

## Basic Installation

### Step 1: Clone the Repository

```bash
git clone https://github.com/richardevcom/flagsearch.git
cd flagsearch
```

### Step 2: Make the Script Executable

```bash
chmod +x tools/flagsearch.sh
```

Now you can run the script using:

```bash
./tools/flagsearch.sh -f <flag_pattern> -i <input_path> [-d]
```

## System-Wide Installation

To make the tool available system-wide:

### Option 1: Create a Symbolic Link

```bash
sudo ln -s $(pwd)/tools/flagsearch.sh /usr/local/bin/flagsearch
```

After creating the link, you can use the tool from anywhere by typing:

```bash
flagsearch -f <flag_pattern> -i <input_path> [-d]
```

### Option 2: Copy to a Directory in PATH

Alternatively, you can copy the script to a directory in your PATH:

```bash
sudo cp tools/flagsearch.sh /usr/local/bin/flagsearch
sudo chmod +x /usr/local/bin/flagsearch
```

## Verification

Verify your installation by checking the version:

```bash
./tools/flagsearch.sh -v
```

or if installed system-wide:

```bash
flagsearch -v
```

## Troubleshooting

If you encounter any issues during installation:

1. Ensure you have proper permissions
2. Check that all prerequisites are installed
3. Verify that the script has execute permissions

For more help, please open an issue on our [GitHub repository](https://github.com/richardevcom/flagsearch/issues).