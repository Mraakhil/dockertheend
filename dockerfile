FROM openjdk:8
WORKDIR /tmp
RUN wget https://github.com/macagua/example.java.helloworld/archive/refs/heads/master.zip
RUN unzip master.zip
WORKDIR /tmp/example.java.helloworld-master
RUN javac HelloWorld/Main.java
RUN java -cp . HelloWorld.Main
RUN jar cfme Main.jar Manifest.txt HelloWorld.Main HelloWorld/Main.class
ENTRYPOINT ["java","-jar","Main.jar"] 
EXPOSE 8082   

