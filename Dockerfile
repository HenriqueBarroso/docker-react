FROM node:alpine
WORKDIR '/app'

# AWS sometimes doesnt like . so we use ./
COPY package*.json ./

RUN npm install
COPY . .
RUN npm run build

FROM nginx

# To expose the port to AWS, this doesnt work local env
EXPOSE 80

# --from=0 because AWS, otherwise --from=builder
COPY --from=0 /app/build /usr/share/nginx/html
