FROM node:20.17.0-alpine

WORKDIR /tabbik-backend

COPY package*.json /

RUN npm install 

COPY . .

EXPOSE 3000

CMD [ "npm", "run", "dev" ]
