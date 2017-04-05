FROM nexus.prod.uci.cu:1959/ubuntu:16.04
RUN /bin/bash -c 'echo "deb http://ubuntu.uci.cu/ubuntu xenial main restricted universe multiverse" > /etc/apt/sources.list'
RUN /bin/bash -c 'echo "deb http://ubuntu.uci.cu/ubuntu xenial-security main restricted universe multiverse" >> /etc/apt/sources.list'
RUN /bin/bash -c 'echo "deb http://ubuntu.uci.cu/ubuntu xenial-updates main restricted universe multiverse" >> /etc/apt/sources.list'
RUN /bin/bash -c 'echo "deb http://ubuntu.uci.cu/ubuntu xenial-proposed main restricted universe multiverse" >> /etc/apt/sources.list'
RUN /bin/bash -c 'echo "deb http://ubuntu.uci.cu/ubuntu xenial-backports main restricted universe multiverse" >> /etc/apt/sources.list'

RUN apt-get update
RUN apt-get install -y nano \
virtualenv \
python-pip \
python3-dev

# configurar pypi de la uci
RUN /bin/bash -c 'echo "[global]" > /etc/pip.conf'
RUN /bin/bash -c 'echo "timeout = 120" >> /etc/pip.conf'
RUN /bin/bash -c 'echo "index = http://nexus.prod.uci.cu/repository/pypi-all/pypi" >> /etc/pip.conf'
RUN /bin/bash -c 'echo "index-url = http://nexus.prod.uci.cu/repository/pypi-all/simple" >> /etc/pip.conf'
RUN /bin/bash -c 'echo "[install]" >> /etc/pip.conf'
RUN /bin/bash -c 'echo "trusted-host = nexus.prod.uci.cu" >> /etc/pip.conf'

# actualizar version del pip
RUN pip install -U pip

# copy virtualenv
RUN mkdir /code
WORKDIR /code
ADD requirements.txt /code/

# pip install requirements
RUN pip install -r requirements.txt
ADD . /code/


# lanzar el gunicorn
