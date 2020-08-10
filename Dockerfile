 
#Specify a base image
FROM node:alpine

#Specify a working directory
WORKDIR '/app'

#Copy the dependencies file
COPY package*.json ./

#Install dependencies
RUN npm install

#Copy remaining files
COPY . .

#Build the project for production
RUN npm run build

#Run Stage Start
FROM nginx:alpine

#Run Stage Start
FROM nginx:alpine

#Copy production build files from builder phase to nginx
COPY --from=0 /app/build /usr/share/nginx/html

# if you are using react router 
# you need to overwrite the default nginx configurations
# remove default nginx configuration file
RUN rm /etc/nginx/conf.d/default.conf
# replace with custom one
COPY nginx/nginx.conf /etc/nginx/conf.d
# --------- /only for those using react router ----------
# expose port 80 to the outer world
EXPOSE 80
# start nginx 
CMD ["nginx", "-g", "daemon off;"]