FROM python:3.5.2

WORKDIR /var/python

RUN pip install \
        ipython \
        numpy \
        matplotlib \
        pep8

ADD ./resources/ipython_config.py /root/.ipython/profile_default/

CMD ["ipython"]

