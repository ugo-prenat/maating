const User = require('../models/users.models');

const updateUserPersonalRating = async (comment) => {
  const user = await User.findById(comment.user);
  const newRating =
    (user.personal_rating * user.rating_nb + comment.note) /
    (user.rating_nb + 1);

  user.personal_rating = newRating;
  user.rating_nb += 1;
  await user.save();
};

module.exports = {
  updateUserPersonalRating
};
