From FROM jupyterhub/k8s-hub:3.0.0-0.dev.git.6136.h50fe018a

CMD sudo apt update -y
CMD sudo apt install openjdk-11-jre
CMD sudo apt install python3-pip

CMD pip3 install delta-spark
