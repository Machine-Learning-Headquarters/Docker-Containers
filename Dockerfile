From jupyterhub/k8s-hub

CMD sudo apt update -y
CMD sudo apt install openjdk-11-jre
CMD sudo apt install python3-pip

CMD pip3 install delta-spark
