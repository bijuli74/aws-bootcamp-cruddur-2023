# FROM python:3.10-slim-buster
FROM 404100009949.dkr.ecr.eu-west-1.amazonaws.com/cruddur-python:3.10-slim-buster

WORKDIR /backend-flask

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY . .

ENV FLASK_ENV=development

EXPOSE ${PORT}

ENV PYTHONUNBUFFERED=1

CMD [ "python3", "-m" , "flask", "--debug", "run", "--host=0.0.0.0", "--port=4567"]