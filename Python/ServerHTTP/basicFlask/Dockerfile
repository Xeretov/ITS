FROM python:3.10-alpine
ADD server.py .
ADD requirements.txt .
RUN mkdir ./templates
ADD templates ./templates
RUN pip install -r requirements.txt
CMD ["python","./server.py"]