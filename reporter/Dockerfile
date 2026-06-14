FROM node:20-alpine
WORKDIR /reporter
COPY package.json .
RUN npm install
COPY report.js .
CMD ["node", "report.js"]