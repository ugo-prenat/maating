const User = require('../models/users.models');

const updateUserPersonalRating = async (comment) => {
  const user = await User.findById(comment.user);
  // calculate the new rating
  const newRating =
    (user.personal_rating * user.rating_nb + comment.note) /
    (user.rating_nb + 1);

  user.personal_rating = newRating; // update the rating
  user.rating_nb += 1; // update the number of ratings
  await user.save(); // save the user
};

module.exports = {
  updateUserPersonalRating
};
