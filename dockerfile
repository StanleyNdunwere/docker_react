#this phase is different and i'll explain:
#in react applications, the jsx and react dom are not valid html and javascript files THAT BROWSERS CAN UNDERSTAND. They have to be compiled into the regular html and css and javascript that browsers use. This compilation phase happens when you run "npm run build"
#npm run build converts the jsx files to proper javascript, css and html and spits them out into a single page application with different pages.Now 
#these files are what we can serve as static content to our users via a web server such as apache and nginx. we'll use nginx in this build. 
#but unlike the previous build scripts we first have to run a build process where we essentially take our raw react app and then build the static files from it first, then copy over those static files from our node:alpine image to an nginx image for serving to the public. This is why our node alpine images is aliased builder.
FROM node:alpine as builder

WORKDIR /usr/app/
COPY ./package.json ./
RUN npm run build
COPY ./ ./

#HERE WE INTRODUCE OUR FINAL CONTAINER -NGINX
FROM nginx
#Expose port 80
EXPOSE 80
#copy the file into the nginx specific folder
COPY --from=builder ./app/builder ./usr/share/nginx/html/


