String getFileExtension(String filePath) {
  try {
    int index = filePath.lastIndexOf('.');
    return filePath.substring(index + 1);
  } catch (e) {
    return '';
  }
}
