# Etapa 1: build
FROM node:23-alpine as build

ARG VITE_API_URL
ENV VITE_API_URL=$VITE_API_URL

WORKDIR /app
COPY . .

RUN npm install && npm run build

# Etapa 2: NGINX para servir os arquivos estáticos
FROM nginx:alpine

COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]