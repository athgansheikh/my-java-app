FROM tomcat:9.0-jdk17-temurin

# Remove default Tomcat applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy JSP, HTML, CSS, JS, images and WEB-INF
COPY src/main/webapp/ /usr/local/tomcat/webapps/ROOT/

# Copy Java source code
COPY src/main/java/ /tmp/sewa-src/

# Create classes directory and compile Java source
RUN mkdir -p /usr/local/tomcat/webapps/ROOT/WEB-INF/classes \
    && javac \
       -cp "/usr/local/tomcat/lib/*:/usr/local/tomcat/webapps/ROOT/WEB-INF/lib/*" \
       -d /usr/local/tomcat/webapps/ROOT/WEB-INF/classes \
       $(find /tmp/sewa-src -name "*.java")

# Railway/Tomcat application port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]