const encodeOriginalname = (filename) => {
  return encodeURIComponent(
    filename.replaceAll(' ', '-').replaceAll("'", '-').toLowerCase()
  );
};

module.exports = {
  encodeOriginalname
};
