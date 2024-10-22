FROM python:3.10-alpine
ADD server.py .
ADD client.py .
ADD requirements.txt .
RUN pip install -r requirements.txt
CMD ["python","./server.py"]