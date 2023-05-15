# Use an openjdk image as the base image
FROM openjdk:11-jdk

# Define environment variables
ENV SPARK_VERSION=3.2.4
ENV HADOOP_VERSION=3.2
ENV SCALA_VERSION=2.13
ENV DELTA_LAKE_VERSION=2.0.1

ENV HADOOP_HOME=/usr/hadoop-${HADOOP_VERSION}
ENV PATH $PATH:${SPARK_HOME}/bin
ENV SPARK_PACKAGE=spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}-scala${SCALA_VERSION}
ENV SPARK_HOME=/usr/${SPARK_PACKAGE}

# Install necessary packages
RUN apt-get update && \
    apt-get install -y wget vim

# Download and install Spark
RUN wget -O /tmp/${SPARK_PACKAGE}.tgz https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/${SPARK_PACKAGE}.tgz && \
    tar -xvf /tmp/${SPARK_PACKAGE}.tgz -C /usr/ && \
    rm /tmp/${SPARK_PACKAGE}.tgz

# Download and copy Delta Lake JAR file to the Spark jars directory
RUN wget -O /tmp/delta-lake-${DELTA_LAKE_VERSION}.jar https://repo1.maven.org/maven2/io/delta/delta-core_${SCALA_VERSION}/${DELTA_LAKE_VERSION}/delta-core_${SCALA_VERSION}-${DELTA_LAKE_VERSION}.jar && \
    mv /tmp/delta-lake-${DELTA_LAKE_VERSION}.jar ${SPARK_HOME}/jars

# Download and copy AWS SDK and Hadoop AWS JAR files to the Spark jars directory
RUN wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/${SPARK_VERSION}/hadoop-aws-${SPARK_VERSION}.jar -P ${SPARK_HOME}/jars/ && \
    wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.375/aws-java-sdk-bundle-1.11.375.jar -P ${SPARK_HOME}/jars/

RUN apt-get update && apt install -y python3 python3-pip &&  pip3 install --upgrade pip setuptools && rm -r /root/.cache && rm -rf /var/cache/apt/* 

RUN apt-get update --allow-releaseinfo-change \
    && apt-get update \
    && apt-get install -y openssl curl tini \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install pyspark==${SPARK_VERSION}

RUN pip3 install delta-spark==${DELTA_LAKE_VERSION}

WORKDIR /opt/spark/work-dir

COPY spark-operator/hack/gencerts.sh /usr/bin/

RUN chmod +x /usr/bin/gencerts.sh

# Expose Spark UI ports
EXPOSE 4040 8080 8081

# Set working directory
WORKDIR ${SPARK_HOME}

# Command to run spark-shell
ENTRYPOINT ["/opt/entrypoint.sh"]
