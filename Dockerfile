FROM ubuntu:trusty

RUN apt-get update
RUN apt-get install -qq wget apt-transport-https
RUN sh -c "echo 'deb http://dev.monetdb.org/downloads/deb/ precise monetdb' > /etc/apt/sources.list.d/monetdb.list"
RUN wget --output-document=- http://dev.monetdb.org/downloads/MonetDB-GPG-KEY | apt-key add -
RUN apt-get update -qq
RUN apt-get install -qq monetdb5-sql monetdb-client
RUN monetdbd create /tmp/monetdb
RUN monetdbd start /tmp/monetdb
RUN monetdb create test
RUN monetdb release test
RUN echo -e "user=monetdb\npassword=monetdb\n" > ~/.monetdb
RUN echo "create schema test_schema;" | mclient test
RUN echo "create schema test_schema2;" | mclient test
RUN echo "alter user monetdb set schema test_schema2;" | mclient test
