FROM ollama/ollama:latest

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/.ollama

EXPOSE 11434

ENV OLLAMA_HOST=0.0.0.0
ENV OLLAMA_PORT=11434

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]