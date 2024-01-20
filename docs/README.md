<p align="center">
  <a href="http://nestjs.com/" target="blank"><img src="https://nestjs.com/img/logo-small.svg" width="200" alt="Nest Logo" /></a>
</p>

[circleci-image]: https://img.shields.io/circleci/build/github/nestjs/nest/master?token=abc123def456
[circleci-url]: https://circleci.com/gh/nestjs/nest

  <p align="center">A progressive <a href="http://nodejs.org" target="_blank">Node.js</a> framework for building efficient and scalable server-side applications.</p>
    <p align="center">
<a href="https://www.npmjs.com/~nestjscore" target="_blank"><img src="https://img.shields.io/npm/v/@nestjs/core.svg" alt="NPM Version" /></a>
<a href="https://www.npmjs.com/~nestjscore" target="_blank"><img src="https://img.shields.io/npm/l/@nestjs/core.svg" alt="Package License" /></a>
<a href="https://www.npmjs.com/~nestjscore" target="_blank"><img src="https://img.shields.io/npm/dm/@nestjs/common.svg" alt="NPM Downloads" /></a>
<a href="https://circleci.com/gh/nestjs/nest" target="_blank"><img src="https://img.shields.io/circleci/build/github/nestjs/nest/master" alt="CircleCI" /></a>
<a href="https://coveralls.io/github/nestjs/nest?branch=master" target="_blank"><img src="https://coveralls.io/repos/github/nestjs/nest/badge.svg?branch=master#9" alt="Coverage" /></a>
<a href="https://discord.gg/G7Qnnhy" target="_blank"><img src="https://img.shields.io/badge/discord-online-brightgreen.svg" alt="Discord"/></a>
<a href="https://opencollective.com/nest#backer" target="_blank"><img src="https://opencollective.com/nest/backers/badge.svg" alt="Backers on Open Collective" /></a>
<a href="https://opencollective.com/nest#sponsor" target="_blank"><img src="https://opencollective.com/nest/sponsors/badge.svg" alt="Sponsors on Open Collective" /></a>
  <a href="https://paypal.me/kamilmysliwiec" target="_blank"><img src="https://img.shields.io/badge/Donate-PayPal-ff3f59.svg"/></a>
    <a href="https://opencollective.com/nest#sponsor"  target="_blank"><img src="https://img.shields.io/badge/Support%20us-Open%20Collective-41B883.svg" alt="Support us"></a>
  <a href="https://twitter.com/nestframework" target="_blank"><img src="https://img.shields.io/twitter/follow/nestframework.svg?style=social&label=Follow"></a>
</p>
  <!--[![Backers on Open Collective](https://opencollective.com/nest/backers/badge.svg)](https://opencollective.com/nest#backer)
  [![Sponsors on Open Collective](https://opencollective.com/nest/sponsors/badge.svg)](https://opencollective.com/nest#sponsor)-->

## Description

[Nest](https://github.com/nestjs/nest) framework TypeScript starter repository.

## Installation

```bash
$ npm install
```

## Running the app

```bash
# development
$ npm run start

# watch mode
$ npm run start:dev

# production mode
$ npm run start:prod
```

## Test

```bash
# unit tests
$ npm run test

# e2e tests
$ npm run test:e2e

# test coverage
$ npm run test:cov
```

## Support

Nest is an MIT-licensed open source project. It can grow thanks to the sponsors and support by the amazing backers. If you'd like to join them, please [read more here](https://docs.nestjs.com/support).

## Stay in touch

- Author - [Kamil Myśliwiec](https://kamilmysliwiec.com)
- Website - [https://nestjs.com](https://nestjs.com/)
- Twitter - [@nestframework](https://twitter.com/nestframework)

## License

Nest is [MIT licensed](LICENSE).


## To Dockerize the app

first create a dockerfile in the root directory of the project

```bash
touch Dockerfile
```

then create the docker ignore file

```bash
touch .dockerignore
```

```Dockerfile
FROM node:21

WORKDIR /user/src/app

COPY . .

RUN npm install

CMD [ "npm", "run","start:dev" ]
```

```dockerignore
node_modules
test
.gitignore
.git
.prettierrc
Dockerfile
README.md 
```

let's build the image

```bash
docker build -t nestjs-docker .
```

![Alt text](image.png)

it will create an image with the name nestjs-docker


let's run the image

```bash
docker run nestjs-docker
```
![Alt text](image-1.png)

![Alt text](image-2.png)

let's make a request to the app

![Alt text](image-3.png)

we can see that the app is running on the docker container
but we can't access it from the browser because it's running on the docker container

let's remove the running container

```bash
docker rm -f <container id>
```

then let's run the container again but this time we will map the port 3000 of the container to the port 3000 of the host machine

```bash
docker run -p 3000:3000 nestjs-docker
```

![Alt text](image-4.png)

now when we change the code in the app it will not be reflected in the container because we are not mounting the code to the container.

let's create a prod docker file

```Dockerfile
FROM node:21

WORKDIR /user/src/app

COPY . .

RUN npm install

RUN npm run build

RUN rm -rf .src

EXPOSE 3000

CMD [ "npm", "run","start:prod" ]
```

```bash
docker image build -t nestjs-prod -f Dockerfile.prod .
```

![Alt text](image-5.png)

let's run the image

```bash
docker run -p 3000:3000 nestjs-prod
```