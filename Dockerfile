FROM python:3.5.2

WORKDIR /var/python

RUN pip install \
        ipython \
	numpy \
	matplotlib

CMD ["ipython"]

