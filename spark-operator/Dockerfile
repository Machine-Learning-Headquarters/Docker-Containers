FROM apache/spark:v3.4.0

USER 185

WORKDIR /

USER 0

RUN apt-get update && apt install -y python3 python3-pip &&  pip3 install --upgrade pip setuptools && rm -r /root/.cache && rm -rf /var/cache/apt/* 

RUN pip3 install pyspark==3.4.0

WORKDIR /opt/spark/work-dir

ENTRYPOINT ["/opt/entrypoint.sh"]

ARG spark_uid=185

USER 185
