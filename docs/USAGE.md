# Usage Guide

This document provides detailed instructions on how to use the Flag Search Tool effectively.

## Basic Command Syntax

```bash
./tools/flagsearch.sh -f <flag_pattern> -i <input_path> [-d]
```

If installed system-wide:
```bash
flagsearch -f <flag_pattern> -i <input_path> [-d]
```

## Command Parameters

| Parameter | Description | Required |
|-----------|-------------|----------|
| `-f` | Flag pattern to search for | Yes |
| `-i` | Input file or directory to search in | Yes |
| `-d` | Deep search (search within file contents) | No |

## Search Examples

### 1. Search for Files with Flag in the Name

To find all files that have "flag" in their filename:

```bash
./tools/flagsearch.sh -f flag -i /path/to/ctf/directory
```

This will search recursively through the directory and list all files that contain "flag" in their name.

### 2. Deep Search for Flags in File Contents

To search for "flag{" pattern within the contents of all files:

```bash
./tools/flagsearch.sh -f flag{ -i /path/to/ctf/directory -d
```

The `-d` flag enables deep search, which looks inside each file for the specified pattern.

### 3. Search in a Single File

To search for a specific flag format within a single file:

```bash
./tools/flagsearch.sh -f "flag{[A-Za-z0-9]+" -i suspicious_file.txt
```

## Advanced Usage

### Regular Expressions

The tool supports grep-compatible patterns. Some examples:

```bash
# Search for flags with specific format
./tools/flagsearch.sh -f "flag{[A-Z0-9]{4,8}}" -i /path/to/directory -d

# Search for a case-insensitive pattern
./tools/flagsearch.sh -f "[fF][lL][aA][gG]" -i /path/to/directory -d
```

### Combining with Other Tools

The output can be piped to other tools:

```bash
# Save results to a file
./tools/flagsearch.sh -f flag -i /path/to/directory -d > found_flags.txt

# Count found flags
./tools/flagsearch.sh -f flag -i /path/to/directory -d | grep "\[+\]" | wc -l
```

## Handling Large Directories

When working with large directories, the deep search might take considerable time. Consider using more specific search patterns or targeting specific subdirectories.

## Output Interpretation

The tool's output is color-coded:
- Green: Found flags/files
- Gray: Informational messages
- Red: Errors or alerts

Example output:
```
[+] Found file: /path/to/directory/flag.txt
[+] Found flag 'flag{abc123}' in file: /path/to/directory/secret.txt
Search completed: 2 flags found.
```