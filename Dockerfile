FROM alpine:3.7
#RUN apt-get update && apt-get install -y --no-install-recommends python3 python3-virtualenv
RUN apk update
RUN apk add --no-cache build-base
RUN apk add --no-cache python3 python3-dev
RUN pip3 install virtualenv

RUN mkdir -p /opt/venv
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m virtualenv --python=/usr/bin/python3 $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install dependencies:
COPY requirements.txt .
RUN pip install -r requirements.txt

# Run the application:
COPY server.py .
EXPOSE 5000
ENV FLASK_APP="server.py"
CMD ["python", "-m","flask","run","--host=0.0.0.0"]
