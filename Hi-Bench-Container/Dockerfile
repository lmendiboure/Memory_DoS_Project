# Distribution usually used with HiBench

FROM ubuntu:18.04 

# Define required environment variables 
ENV MAVEN_HOME="/opt/apache-maven-3.2.5"
ENV JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
ENV HADOOP_HOME="/opt/hadoop-3.2.4"

# Required for HDFS
ENV HDFS_NAMENODE_USER="root"
ENV HDFS_DATANODE_USER="root" 
ENV HDFS_SECONDARYNAMENODE_USER="root"
ENV YARN_RESOURCEMANAGER_USER="root"
ENV YARN_NODEMANAGER_USER="root"

# Copy required Files

ADD installs.sh /root/installs.sh
ADD run_dfs.sh /root/run_dfs.sh
ADD conf/hibench.conf /root/hibench.conf
ADD conf/hadoop.conf /root/hadoop.conf

# Enable Files Execution
RUN chmod 777 /root/installs.sh
RUN chmod 777 /root/run_dfs.sh

# Run Basic Install
RUN /root/installs.sh

# Run 1) ssh server, 2) Hadoop

ENTRYPOINT ["sh", "-c", "service ssh restart; /root/run_dfs.sh; /bin/bash"]
