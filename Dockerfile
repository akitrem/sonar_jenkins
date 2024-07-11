FROM ubuntu

RUN apt update
RUN apt install -y openjdk-8-jdk
RUN apt install -y default-jre
RUN apt install curl -y
RUN curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
RUN sh -c 'echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | tee /etc/apt/sources.list.d/jenkins.list > /dev/null'
RUN apt update
RUN apt install jenkins -y
EXPOSE 8080

# Install ddependencies for Terraform.
RUN apt update \
    && apt install -y wget \
    && apt install -y unzip \
    && apt install -y vim \
    && apt install -y openssh-client

# Download the latest version of Terraform from the official website
RUN wget https://releases.hashicorp.com/terraform/1.9.0/terraform_1.9.0_linux_amd64.zip

# Unzip the downloaded file:
RUN unzip terraform_1.9.0_linux_amd64.zip

# Move the terraform binary to a directory in your system's PATH.
RUN mv terraform /usr/local/bin/

# Verify that Terraform is installed by checking its version:
RUN terraform version
