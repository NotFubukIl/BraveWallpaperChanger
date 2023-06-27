# Brave Wallpaper Changer

This Dart script is designed to process images and generate a JSON file containing information about those images. It performs the following actions:

1. Checks if the "./images" directory exists. If it doesn't exist, it creates the directory and displays a message asking to place the images in that directory.
3. Checks if the "./oldbackgrounds" directory exists. If it doesn't exist, it creates the directory.
4. Moves all files with the ".jpg" extension from the `bravePNGPath` directory to the "./oldbackgrounds" directory.


## Requirements

- Dart SDK (version X.X.X)

## Usage

1. Place the images you want to process in the "./images" directory.
2. Run the Dart script using the following command:
dart bin/dart.dart or run the exe on the releases

## Notes

- Make sure you have the necessary permissions to access and modify the mentioned directories and files.
- The images should be in JPG or PNG format to be recognized by the script.
- Information such as image name, source, dimensions, author, link, original URL, and license is added to the generated JSON data.

## Author

This script was developed by NotFubukii.

## License

If you use / skid let my name in the script.

For more information, please visit [Github Link](https://github.com/NotFubukil).
