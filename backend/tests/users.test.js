const {
  isObjectEmpty,
  hashPassword,
  isCorrectPassword
} = require('../utils/users.utils');

describe('Users', () => {
  it('Checks if object is empty', () => {
    expect(isObjectEmpty({})).toEqual(true);
    expect(isObjectEmpty({ empty: false })).toEqual(false);
  });
  it('Hashes password', () => {
    expect(hashPassword('password')).not.toEqual('password');
  });
  it('Checks if password is correct', () => {
    const password = 'password';
    const hash = hashPassword(password);

    expect(isCorrectPassword(password, hash)).toBe(true);
    expect(isCorrectPassword('wrong', hash)).toBe(false);
  });
});
