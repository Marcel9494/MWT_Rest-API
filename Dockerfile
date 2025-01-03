# Verwende das Flutter SDK, um die Web-Anwendung zu bauen
FROM cirrusci/flutter:latest AS build

# Arbeitsverzeichnis setzen
WORKDIR /app

# Kopiere die Flutter-Anwendung in das Arbeitsverzeichnis
COPY . .

# Baue die Flutter Web-Anwendung
#RUN flutter build web

# Nginx verwenden, um die gebaute Anwendung zu bedienen
FROM nginx:latest

# Kopiere den gebauten Inhalt in den Nginx-Ordner
COPY --from=build /app/build/web /usr/share/nginx/html

# Exponiere den Standardport von Nginx
EXPOSE 80

# Starte Nginx
CMD ["nginx", "-g", "daemon off;"]
