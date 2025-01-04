# 构建阶段
FROM node:alpine AS builder

WORKDIR /app

RUN apk add git && \
git clone https://github.com/ShouChenICU/FastSend fs && \
cd fs && \
yarn install && \
yarn build

# 生产阶段
FROM node:alpine

WORKDIR /app

# 从构建阶段复制构建后的文件
COPY --from=builder /app/fs/.output /app

# 暴露端口
EXPOSE 3000

# 启动应用
CMD ["node", "server/index.mjs"]
