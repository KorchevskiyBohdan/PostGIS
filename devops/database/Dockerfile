FROM liquibase/liquibase:4.16.1

WORKDIR /liquibase
 
ENV LIQBASE_CLASSPATH=/liquibase/changelog
ENV LIQBASE_CHANGELOG_POSTGRESQL=postgresql.changelog.xml

COPY changelog/ /liquibase/changelog/   

CMD ["sh", "-c", "docker-entrypoint.sh --url=${LIQBASE_URL_POSTGRESQL} --changeLogFile=${LIQBASE_CHANGELOG_POSTGRESQL} update --log-level=info"]

