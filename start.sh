#!/bin/bash

export OLLAMA_HOST=0.0.0.0
export OLLAMA_PORT=11434
export OLLAMA_ORIGINS="*"

mkdir -p ~/.ollama

echo "Starting Ollama server..."
ollama serve &

echo "Waiting for Ollama to be ready..."
timeout=60
counter=0
while ! curl -s http://localhost:11434/api/tags >/dev/null 2>&1; do
    if [ $counter -ge $timeout ]; then
        echo "Timeout waiting for Ollama to start"
        exit 1
    fi
    sleep 2
    counter=$((counter + 2))
    echo "Waiting... ($counter seconds)"
done

echo "Ollama is ready! Downloading GPT-OSS model..."

MODEL_SIZE=${GPT_OSS_MODEL:-"gpt-oss:20b"}
echo "Downloading model: $MODEL_SIZE"

if ollama pull "$MODEL_SIZE"; then
    echo "Model downloaded successfully!"
else
    echo "Failed to download model"
    exit 1
fi

echo "Setup complete. Ollama with GPT-OSS is ready to use!"
echo "API available at: http://0.0.0.0:11434"

wait