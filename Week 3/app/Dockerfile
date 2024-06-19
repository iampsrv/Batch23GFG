FROM python:latest
COPY . /application
WORKDIR /application
# COPY requirements.txt .
RUN pip install -r requirements.txt
EXPOSE 8080
CMD ["python", "app.py"]