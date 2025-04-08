# Homebrew Tap for TextCleaner

This repository contains the Homebrew formula for TextCleaner, a comprehensive text preprocessing tool for Large Language Models.

## Installation

```bash
# Add this tap to your Homebrew
brew tap emil7051/textcleaner

# Install TextCleaner
brew install textcleaner
```

## Usage

Once installed, you can use the `textcleaner` command to process documents:

```bash
# Process a single file
textcleaner process document.pdf

# Process a directory of files
textcleaner process ~/Documents/my_files/

# Process with specific output format
textcleaner process --format markdown ~/Documents/my_files/

# Process recursively (including subdirectories)
textcleaner process --recursive ~/Documents/my_files/
```

## Features

TextCleaner handles multiple file formats including:
- HTML/XML documents
- Markdown files
- Plain text files
- PDF documents
- Office documents (Word, Excel, PowerPoint)

## Docker Support

TextCleaner is also available as a Docker container:

```bash
# Pull the Docker image
docker pull emil7051/textcleaner

# Process files using the Docker container
docker run -v $(pwd)/data:/app/data emil7051/textcleaner process /app/data/input /app/data/output
```

## License

MIT License
