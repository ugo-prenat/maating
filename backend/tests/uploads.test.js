const { encodeOriginalname } = require('../utils/uploads.utils');

describe('Uploads', () => {
  it('Encodes image original name', () => {
    const originalName = "a b c'd'e.png";
    const encodedName = 'a-b-c-d-e.png';

    expect(encodeOriginalname(originalName)).toEqual(encodedName);
  });
});
