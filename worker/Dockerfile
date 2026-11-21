FROM python:3.12-slim
RUN useradd --create-home --uid 10001 worker
WORKDIR /app
COPY worker.py .
USER worker
CMD ["python", "worker.py"]
