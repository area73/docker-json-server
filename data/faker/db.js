const faker = require('faker');
faker.locale = "es";

const createUser = id =>
  Object.assign(
    {},
    faker.helpers.createCard(),
  {
  id,
  avatar: faker.image.avatar(),
  registrationDate: faker.date.past()
});

module.exports = () =>({"users": [...Array(50).keys()].map(i => createUser(i))})
