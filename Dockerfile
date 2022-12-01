FROM secoresearch/fuseki:4.6.1

USER root
RUN apk add --update curl && rm -rf /var/cache/apk/*
USER 9008
 
ENV ASSEMBLER $FUSEKI_BASE/configuration/model-catalog.ttl
ENV JAVA_CMD java -cp "$FUSEKI_HOME/fuseki-server.jar:/javalibs/*"
ENV TDBLOADER $JAVA_CMD tdb.tdbloader --desc=$ASSEMBLER
ENV TDBLOADER2 $JENA_BIN/tdbloader2 --loc=$FUSEKI_BASE/databases/tdb
ENV TDB2TDBLOADER $JAVA_CMD tdb2.tdbloader --desc=$ASSEMBLER
ENV TEXTINDEXER $JAVA_CMD jena.textindexer --desc=$ASSEMBLER
ENV TDBSTATS $JAVA_CMD tdb.tdbstats --desc=$ASSEMBLER
ENV TDB2TDBSTATS $JAVA_CMD tdb2.tdbstats --desc=$ASSEMBLER

RUN mkdir $FUSEKI_BASE/seeds
COPY data $FUSEKI_BASE/seeds
