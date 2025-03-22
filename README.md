# Flag Search Tool

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version: 1.1.0](https://img.shields.io/badge/Version-1.1.0-blue.svg)](https://github.com/richardevcom/flagsearch)

A powerful command-line tool designed to help CTF participants and security professionals search for flags within files and directories. This tool can search both file names and file contents for specified flag patterns.

## 🚀 Features

- Search for flags in filenames
- Deep search within file content
- Color-coded output for better readability
- Clean and intuitive user interface
- Works with single files or entire directories

## 📋 Requirements

- Bash 4.0 or later
- Standard Unix utilities (`grep`, `find`, etc.)
- Read permissions to files you want to search

## 🔧 Installation

1. Clone the repository:
```bash
git clone https://github.com/richardevcom/flagsearch.git
cd flagsearch
```

2. Make the script executable:
```bash
chmod +x flagsearch.sh
```

3. Optionally, create a symbolic link to use the tool from anywhere:
```bash
sudo ln -s $(pwd)/flagsearch.sh /usr/local/bin/flagsearch
```

## 🔎 Usage

Basic syntax:
```bash
flagsearch.sh -f <flag_pattern> -i <input_path> [-d]
```

### Parameters:
- `-f` - Pattern to search for (required)
- `-i` - Input file or directory to search in (required)
- `-d` - Enable deep search (search within file contents - optional, only applicable with directory input)

### Examples:

1. Search for files with "flag" in the filename:
```bash
flagsearch.sh -f flag -i /path/to/ctf/files
```

2. Search for files containing "flag{" in their content:
```bash
flagsearch.sh -f flag{ -i /path/to/ctf/files -d
```

3. Search for a specific flag format in a single file:
```bash
flagsearch.sh -f "flag{[A-Za-z0-9]+" -i suspicious_file.txt
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ✉️ Follow

Twitter - [@richardevcom](https://twitter.com/richardevcom)
Project Link: [https://github.com/richardevcom/flagsearch](https://github.com/richardevcom/flagsearch)
