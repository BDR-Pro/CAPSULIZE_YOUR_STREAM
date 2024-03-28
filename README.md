# CAPSULIZE YOUR STREAM

## Introduction

The "Capsulize Your Stream" script aims to simplify the video compression process, making it more accessible for individuals looking to prepare their videos for web-based streaming services. By automating the compression and resizing tasks, this script ensures that videos are optimized for streaming without sacrificing quality, enabling a smoother and more efficient streaming experience.

## Features

- **Easy Compression**: Automatically compress videos to make them suitable for web streaming.
- **Adaptive Resizing**: Dynamically resizes videos to multiple resolutions (2160p, 1440p, 1080p, 720p, 360p) based on the original video's width, ensuring compatibility across different devices and network speeds.
- **FFmpeg Dependency Check**: Verifies the installation of `ffmpeg`, a powerful multimedia framework essential for video processing tasks.
- **Optional Original File Deletion**: Offers the option to delete the original video file after processing, conserving disk space.
- **Custom CRF Values**: Allows users to specify the Constant Rate Factor (CRF) value for encoding, balancing between quality and file size.

## Getting Started

### Prerequisites

Ensure `ffmpeg` is installed on your system. If it's not installed, the accompanying `install.sh` script can automatically handle the installation for you on macOS and most Linux distributions. Windows users are advised to install `ffmpeg` manually.

### Installation

1. Clone or download the repository containing the script.
2. Run the `install.sh` script to automatically check for `ffmpeg` and install it if necessary. This script will also place the "Capsulize Your Stream" script in your system's PATH, making it accessible from anywhere.

   ```bash
   git clone github.com/bdr-pro/CAPSULIZE_YOUR_STREAM.git
   cd CAPSULIZE_YOUR_STREAM
   bash install.sh
   ```

3. Once installed, you can start using the script immediately.

### Usage

To use the "Capsulize Your Stream" script, follow these simple steps:

```bash
make_my_video [options] input_file
```

Options:

- `-del`: Delete the original file after processing.
- `-crf value`: Set the CRF value for encoding. The default value is 28.
- `input_file`: Specify the path to the input video file.

Example:

```bash
make_my_video -del -crf 23 example_video.mp4
```

This command will process `example_video.mp4`, delete the original file after processing, and set the CRF value to 23.

## Support

For issues, suggestions, or contributions, please open an issue or pull request in the repository. Your feedback is invaluable in improving this script.

## License

This project is open-sourced under the MIT License. Feel free to use, modify, and distribute it as per the license terms.

---
