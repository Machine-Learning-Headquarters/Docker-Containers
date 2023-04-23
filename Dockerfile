FROM jupyterhub/k8s-singleuser-sample:2.0.1-0.dev.git.6105.hb969fa50

CMD sudo apt update -y
CMD sudo apt install openjdk-11-jre
CMD sudo apt install python3-pip

CMD pip3 install delta-spark
