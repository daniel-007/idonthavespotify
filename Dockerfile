FROM oven/bun:1-alpine

EXPOSE 3000/tcp

WORKDIR /usr/src/app

RUN apk update && apk add --no-cache nodejs python3

COPY package.json bun.lock .
RUN bun install --frozen-lockfile

COPY src src

COPY tsconfig.json .
COPY tailwind.config.js .
COPY postcss.config.js .
COPY vite.config.js .

RUN bun run build

COPY public public

ENV NODE_ENV production

CMD ["bun", "src/index.ts"]
