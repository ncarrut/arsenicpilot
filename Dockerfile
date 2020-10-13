FROM jupyter/r-notebook:latest

LABEL maintainer="carruthers@wayne.edu"

# Copy selected data
COPY ./premadeOutput/AllProteinGroups.tsv /home/jovyan/work/AllProteinGroups.tsv
COPY ./tasks /home/jovyan/work/tasks
COPY ./Analysis.ipynb /home/jovyan/work/Analysis.ipynb

USER root

# Install dotnet
RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN sudo dpkg -i packages-microsoft-prod.deb

RUN sudo apt-get update; \
  sudo apt-get install -y apt-transport-https && \
  sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-3.1

# Install MetaMorpheus
RUN wget "https://github.com/smith-chem-wisc/MetaMorpheus/releases/download/0.0.311/MetaMorpheus_CommandLine.zip"
RUN unzip MetaMorpheus_CommandLine.zip -d /MetaMorpheus_CommandLine
#RUN dotnet /MetaMorpheus_CommandLine/CMD.dll --help

RUN mkdir /MetaMorpheus_CommandLine/CustomAminoAcids
RUN chmod -R +r /MetaMorpheus_CommandLine 

# Set the default directory where CMD will execute
#WORKDIR /notebook

# Set environment variable
#ENV HOME /notebook