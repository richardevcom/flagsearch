#!/bin/bash

# ===================================================================
# Flag Search Script
# Author: @richardevcom
# Version: v1.1.0
#
# Description: Searches for CTF flags in files or directories.
# Usage: ./flagsearch.sh -f <flag_pattern> -i <input_path> [-d]
# ===================================================================

# -------------------- ANSI Color Definitions --------------------
readonly GREEN="\e[32m"
readonly GRAY="\e[37m"
readonly LIGHTBLUE="\e[94m"
readonly RED="\e[31m"
readonly RESET="\e[0m"
readonly DARK_RED="\e[38;2;180;60;60m"
readonly WHITE="\e[38;2;255;255;255m"

# -------------------- Banner Function --------------------
# Prints a stylish banner with gradient colors
print_banner() {    
    # Banner lines with gradient coloring
    local lines=(
    "                                                           "
    "  ░▒▓████████▓▒░░▒▓█▓▒░        ░▒▓██████▓▒░  ░▒▓██████▓▒░  "
    "  ░▒▓█▓▒░       ░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ "
    "  ░▒▓█▓▒░       ░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░        "
    "  ░▒▓██████▓▒░  ░▒▓█▓▒░       ░▒▓████████▓▒░░▒▓█▓▒▒▓███▓▒░ "
    "  ░▒▓█▓▒░       ░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ "
    "  ░▒▓█▓▒░       ░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ "
    "  ░▒▓█▓▒░       ░▒▓████████▓▒░░▒▓█▓▒░░▒▓█▓▒░ ░▒▓██████▓▒░  "    
    "                                    @richardevcom | v1.1.0 "                                     
    )
    
    # Calculate gradient sections
    local num_lines=${#lines[@]}
    local section_size=$(( (num_lines + 2) / 3 ))
    
    # Print with color gradient
    for ((i=0; i<num_lines; i++)); do
        local color="${DARK_RED}"
        if [ $i -ge $section_size ] && [ $i -lt $(( 2 * section_size )) ]; then
            color="${WHITE}"
        fi
        echo -e "${color}${lines[$i]}${RESET}"
    done
    echo ""
}

# -------------------- Display Usage --------------------
# Shows how to use this script with examples
usage() {
    echo -e "Usage: ${LIGHTBLUE}$0 -f <flag_string> -i <input_file_or_directory> [-d]${RESET}"
    echo -e "${LIGHTBLUE}  -f  ${GRAY}Flag string to search for${RESET}"
    echo -e "${LIGHTBLUE}  -i  ${GRAY}Input file or directory to search in${RESET}"
    echo -e "${LIGHTBLUE}  -d  ${GRAY}(Optional) Deep search - search inside file contents recursively (only applicable with directory input)${RESET}"
    echo
    echo -e "${GRAY}Examples:${RESET}"
    echo -e "  ${LIGHTBLUE} $0 -f flag -i /path/to/directory  ${GRAY}# Search for files with 'flag' in the name${RESET}"
    echo -e "  ${LIGHTBLUE} $0 -f flag -i /path/to/directory -d  ${GRAY}# Also search file contents${RESET}"
    echo -e "  ${LIGHTBLUE} $0 -f flag -i /path/to/file.txt  ${GRAY}# Search for 'flag' in the file${RESET}"
    exit 1
}

# -------------------- Search Functions --------------------
# Common function to print and count found flags
# Args: $1 - type (file or content), $2 - file path
log_flag_found() {
    local type="$1"
    local file="$2"
    local abs_path
    abs_path=$(realpath "$file")
    
    if [ "$type" = "file" ]; then
        echo -e "${GREEN}[+] Found file: $abs_path${RESET}"
    else
        echo -e "${GREEN}[+] Found flag '$flag_string' in file: $abs_path${RESET}"
    fi
    
    flags_found=$((flags_found+1))
}

# Search for flag string in a file
# Args: $1 - file path
search_in_file() {
    local file="$1"
    
    # Skip non-regular files and those we can't read
    if [[ ! -f "$file" || ! -r "$file" ]]; then
        return
    fi
    
    # Use grep with quiet mode to check for matches
    if grep -q "$flag_string" "$file" 2>/dev/null; then
        log_flag_found "content" "$file"
    fi
}

# Search for files with matching names
# Args: $1 - directory path
search_filenames() {
    local dir="$1"
    echo -e "${GRAY}Searching for files containing '$flag_string' in their names within '$(realpath "$dir")'...${RESET}"
    
    # Find files and process them without subshell variable scope issues
    local file
    while IFS= read -r -d $'\0' file; do
        log_flag_found "file" "$file"
    done < <(find "$dir" -type f -name "*$flag_string*" -print0 2>/dev/null)
}

# Perform deep search through file contents
# Args: $1 - directory path
deep_search() {
    local dir="$1"
    echo -e "${GRAY}Performing deep search for '$flag_string' within file contents in '$(realpath "$dir")'...${RESET}"
    
    # Find all files and search through content without subshell issues
    local file
    while IFS= read -r -d $'\0' file; do
        search_in_file "$file"
    done < <(find "$dir" -type f -not -path "*/\.*" -print0 2>/dev/null)
}

# -------------------- Main Script --------------------
main() {
    # Print the banner
    print_banner
    
    # Initialize variables
    local flag_string=""
    local input_path=""
    local deep_search_enabled=false
    local flags_found=0
    
    # Parse command line arguments
    while getopts "f:i:d" opt; do
        case ${opt} in
            f) flag_string="$OPTARG" ;;
            i) input_path="$OPTARG" ;;
            d) deep_search_enabled=true ;;
            *) usage ;;
        esac
    done
    
    # Validate required arguments
    if [ -z "$flag_string" ] || [ -z "$input_path" ]; then
        echo -e "${RED}[x] Error: Flag string (-f) and input path (-i) are required.${RESET}\n"
        usage
    fi
    
    # Check if input path exists
    if [ ! -e "$input_path" ]; then
        echo -e "${RED}[x] Error: Input path '$input_path' does not exist.${RESET}"
        exit 1
    fi
    
    # Execute appropriate search based on input type
    if [ -f "$input_path" ]; then
        # Single file search
        echo -e "${GRAY}Searching for '$flag_string' in file '$(realpath "$input_path")'...${RESET}"
        search_in_file "$input_path"
    elif [ -d "$input_path" ]; then
        # Directory search
        search_filenames "$input_path"
        
        # If deep search is enabled
        if [ "$deep_search_enabled" = true ]; then
            deep_search "$input_path"
        fi
    else
        echo -e "${RED}[x] Error: Input path '$input_path' is neither a file nor a directory.${RESET}"
        exit 1
    fi
    
    # Display completion message based on flags found
    if [ $flags_found -eq 0 ]; then
        echo -e "${GRAY}Search completed: ${RED}no flags found${RESET}"
    else
        echo -e "${GRAY}Search completed: ${GREEN}$flags_found flags found.${RESET}"
    fi
}

# Execute main function
main "$@"
