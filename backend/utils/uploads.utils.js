const encodeOriginalname = (filename) => {
  // make filename url friendly
  return encodeURIComponent(
    filename.replaceAll(' ', '-').replaceAll("'", '-').toLowerCase()
  );
};

module.exports = {
  encodeOriginalname
};
