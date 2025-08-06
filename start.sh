#!/bin/bash

ollama serve &
echo "Waiting for Ollama to be ready..."
while ! curl -f http://localhost:11434/api/tags >/dev/null 2>&1; do
    sleep 2
done

echo "Ollama is ready. Downloading GPT-OSS model..."

MODEL_SIZE=${GPT_OSS_MODEL:-"gpt-oss:20b"}
echo "Downloading model: $MODEL_SIZE"
ollama pull $MODEL_SIZE

echo "Model downloaded successfully. Ollama is ready to use."

wait