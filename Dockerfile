FROM tomcat:9.0-jdk15
LABEL maintainer="svajjha@gmu.edu"
COPY SurveyForm.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]