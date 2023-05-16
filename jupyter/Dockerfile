FROM jupyter/base-notebook:latest

USER root

# Define environment variables
ENV SPARK_VERSION=3.3.0
ENV HADOOP_VERSION=3
ENV SCALA_VERSION=2.13
ENV DELTA_LAKE_VERSION=2.3.0

ENV HADOOP_HOME=/usr/hadoop-${HADOOP_VERSION}
ENV SPARK_PACKAGE=spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}-scala${SCALA_VERSION}
ENV SPARK_HOME=/usr/${SPARK_PACKAGE}
ENV PATH $PATH:${SPARK_HOME}/bin

# Install necessary packages
RUN apt-get update && \
    apt-get install -y wget vim openjdk-11-jdk

# Download and install Spark
RUN wget -O /tmp/${SPARK_PACKAGE}.tgz https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/${SPARK_PACKAGE}.tgz && \
    tar -xvf /tmp/${SPARK_PACKAGE}.tgz -C /usr/ && \
    rm /tmp/${SPARK_PACKAGE}.tgz

# Download and copy Delta Lake JAR file to the Spark jars directory
RUN wget -O /tmp/delta-lake-${DELTA_LAKE_VERSION}.jar https://repo1.maven.org/maven2/io/delta/delta-core_${SCALA_VERSION}/${DELTA_LAKE_VERSION}/delta-core_${SCALA_VERSION}-${DELTA_LAKE_VERSION}.jar && \
    mv /tmp/delta-lake-${DELTA_LAKE_VERSION}.jar ${SPARK_HOME}/jars
    
# Download and copy Delta Lake JAR file to the Spark jars directory
# https://repo1.maven.org/maven2/io/delta/delta-contribs_2.13/2.0.2/delta-contribs_2.13-2.0.2.jar
RUN wget -O /tmp/delta-contribs-${DELTA_LAKE_VERSION}.jar https://repo1.maven.org/maven2/io/delta/delta-contribs_${SCALA_VERSION}/${DELTA_LAKE_VERSION}/delta-contribs_${SCALA_VERSION}-${DELTA_LAKE_VERSION}.jar && \
    mv /tmp/delta-contribs-${DELTA_LAKE_VERSION}.jar ${SPARK_HOME}/jars
    
# Download and copy Delta Lake JAR file to the Spark jars directory
# https://repo1.maven.org/maven2/io/delta/delta-storage-s3-dynamodb/2.0.2/delta-storage-s3-dynamodb-2.0.2.jar
RUN wget -O /tmp/delta-storage-${DELTA_LAKE_VERSION}.jar https://repo1.maven.org/maven2/io/delta/delta-storage-s3-dynamodb/${DELTA_LAKE_VERSION}/delta-storage-s3-dynamodb-${DELTA_LAKE_VERSION}.jar && \
    mv /tmp/delta-storage-${DELTA_LAKE_VERSION}.jar ${SPARK_HOME}/jars

# Download and copy AWS SDK and Hadoop AWS JAR files to the Spark jars directory
RUN wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/${SPARK_VERSION}/hadoop-aws-${SPARK_VERSION}.jar -P ${SPARK_HOME}/jars/ && \
    wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.375/aws-java-sdk-bundle-1.11.375.jar -P ${SPARK_HOME}/jars/

RUN apt-get update && apt install -y python3 python3-pip &&  pip3 install --upgrade pip setuptools

RUN pip3 install pyspark==${SPARK_VERSION}

RUN pip3 install delta-spark==${DELTA_LAKE_VERSION}
    
USER ${NB_UID}
