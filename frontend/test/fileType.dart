import 'package:maating/utils/filetype.dart';
import 'package:test/test.dart';

void main() {
  test('get file extension', () {
    expect(getFileExtension('test.png'), 'png');
    expect(getFileExtension('test.png.jpg'), 'jpg');
    expect(getFileExtension('test'), 'test');
    expect(getFileExtension('test.'), '');
  });
}
