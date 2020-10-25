# docker-json-server

[JSON Server](https://github.com/typicode/json-server) provides REST API mocking based on plain JSON.
This is a [docker](https://www.docker.io) image that eases setup.

## Usage

This docker image is available as a [trusted build on the docker index](https://index.docker.io/u/boogie00/json-server/),
so there's no setup required.
Using this image for the first time will start a download automatically.
Further, runs will be immediate, as the image will be cached locally.

The recommended way to run this container looks like this:

```bash
$ docker run -d -p 80:80 -v /home/user/articles.json:/data/db.json boogie00/json-server
```

Or if oyu want to use the example data supply with the image , then you don't need to 
mount any volumnes and add a finalparameter -d <route of json/js file>.
Please refer to [data examples](#data-examples) for more info on how to use data examples served in this distribution.

```bash
 docker run  --name jserver -it -p 80:80  --rm boogie00/json-server -d todo/db.json
```

The above example exposes the JSON Server REST API on port 80, so that you can now browse to:

```
http://localhost/
```

This is a rather common setup following docker's conventions:

* `-d` will run a detached instance in the background
* `-p {OutsidePort}:80` will bind the webserver to the given outside port
* `-v {AbsolutePathToJsonFile}:/data/db.json` should be passed to mount the given JSON file into the container
* `boogie00/json-server` the name of this docker image

### Help

You can supply any number of JSON Server arguments that will be passed through unmodified.

For example if you need to pass routes to the server you can mount the file to be pass and then
adding the argument at the end
```bash
$ docker run -it --rm clue/json-server --help
$ docker run -it -p 80:80 --name jserver -v ${PWD}/data/todo/db.json:/data/db.json -v ${PWD}/data/todo/routes.json:/data/routes.json --rm boogie00/json-server -r routes.json
```
* `-i` interactive        
* `-t` opens TTY
* `-p {OutsidePort}:80` will bind the webserver to the given outside port
* `--name` name of the container to easily find it
* `-v {AbsolutePathToJsonFile}:/data/db.json` should be passed to mount the given JSON file into the container
* `-v {AbsolutePathToJsonFile}:/data/routes.json` should be passed to mount the given JSON file into the container and use as routes
* `--rm` Remove container onces stops
* `boogie00/json-server` the name of this docker image
* `-r` Json-server parameter for telling server the name of the routes file



### JSON source

If you mount a file to `/data/db.json` (as in the above example),
it will automatically be used as the plain JSON data source file.

A sample file could look like this:

```json
{
  "posts": [
    { "id": 1, "body": "foo" },
    { "id": 2, "body": "bar" }
  ],
  "comments": [
    { "id": 1, "body": "baz", "postId": 1 },
    { "id": 2, "body": "qux", "postId": 2 }
  ]
}
```

### JS seed file

If you mount a file to `/data/file.js`,
it will automatically be used as a JS seed file.

JSON Server expects JS files to export a function that returns an object.
Seed files are useful if you need to programmatically create a lot of data.

A sample file could look like this:

```javascript
module.exports = function() {
  var data = {};

  data.posts = [];
  data.posts.push({ id: 1, body: 'foo' });
  //...

  return data;
}
```

### Extras
This distribution has also added support for [faker.js](https://github.com/marak/Faker.js/),
so in case you want to add a db.js that uses faker.

An example could be something like this:
```javascript

const faker = require('faker');

const createUser = id => ({
  id,
  ...faker.helpers.createCard(),
  avatar: faker.image.avatar(),
  registrationDate: faker.date.past()
})

module.exports = () =>({"users": [...Array(200).keys()].map(i => createUser(i))})
```

### <a name="data-examples">Data examples<a>

You can use data that are been shipped with this docker image

To do so, you don't need to mount any additional file to the image since the image has all the required data

Although you will need to pass the route tot eh file alocated in the image with an aditional parameter `-d`
 
#### Todo
```bash
$ docker run -it -p 80:80 --name jserver --rm boogie00/json-server -d todo/db.json
```

#### faker
```bash
$ docker run -it -p 80:80 --name jserver --rm boogie00/json-server -d faker/db.js
```

#### StarWars
```bash
$ docker run -it -p 80:80 --name jserver --rm boogie00/json-server -d starwars/db.json
```




