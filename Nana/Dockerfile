FROM node:23-alpine

RUN mkdir -p /home/app

COPY ./app /home/app

# Set default dir so that next commands executes in /home/app dir
WORKDIR /home/app

# Will execute npm install in /home/app becaus of WORKDIR
RUN npm install

# No need for /home/app/server.js because of WORKDIR
CMD ["node", "server.js"]
