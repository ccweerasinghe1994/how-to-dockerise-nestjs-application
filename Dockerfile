FROM node:21

WORKDIR /user/src/app

COPY . .

RUN npm install

CMD [ "npm", "run","start:dev" ]