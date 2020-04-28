#----------------------
### STAGE 1: BUILD ###
#---------------------

# Building node from LTS version
FROM node:12.16.2-alpine as builder

# Copying all necessary files required for npm install

COPY package.json tsconfig.json tslint.json ./

# Install npm dependencies in a different folder to optimize container build process

RUN npm install

# Create application directory and copy node modules to it
RUN mkdir /AngularAppWithNginxDocker
RUN cp -R ./node_modules ./AngularAppWithNginxDocker

# Setting application directory as work directory
WORKDIR /AngularAppWithNginxDocker

# Copying application code to container application directory
COPY . .

# Building the angular app
RUN npm run build

#--------------------------------------------------
### STAGE 2: Setup nginx and Deploy application ###
#--------------------------------------------------
FROM nginx:latest

## Copy defualt nginx configuration file>

COPY .nginx/default.conf /etc/nginx/conf.d

# Copy dist folder from  the builder to nginx public folder(STAGE 1)

COPY --from=builder /AngularAppWithNginxDocker/dist/AngularAppWithNginxDocker /usr/share/nginx/html

CMD ["nginx","-g","daemon off;"]
