FROM python:3.11-alpine
COPY . /application
WORKDIR /application
COPY req.txt .
RUN pip install -r req.txt
EXPOSE 8080
CMD ["python", "app.py"]