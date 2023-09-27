FROM node:10.8-stretch as builder

COPY ./app /app

WORKDIR /app

RUN npm install

RUN npm run build

FROM node:10.8-slim as runner

COPY --from=builder /app/dist /app

RUN npm install pm2 -g

WORKDIR /app

CMD ["pm2-runtime", "index.js"]