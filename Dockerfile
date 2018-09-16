FROM node:carbon
WORKDIR /nodeapp
COPY package*.json ./
RUN npm install
COPY . ./
EXPOSE 8080
CMD ["npm","start"]
