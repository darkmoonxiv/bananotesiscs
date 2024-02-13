FROM node:latest

WORKDIR /src

COPY package*.json ./

RUN npm install
COPY . .

EXPOSE 4041

VOLUME [ "/app/node_modules" ]

CMD [ "npm", "start" ]
