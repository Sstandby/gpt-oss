#!/bin/bash

export OLLAMA_HOST=0.0.0.0
export OLLAMA_PORT=11434
export OLLAMA_ORIGINS="*"

echo "🚀 Starting Ollama server..."
ollama serve &

echo "⏳ Waiting for Ollama to start..."
timeout=60
counter=0
while ! curl -s http://localhost:11434 >/dev/null; do
    sleep 2
    counter=$((counter + 2))
    echo "Waiting... ($counter seconds)"
    if [ $counter -ge $timeout ]; then
        echo "❌ Timeout: Ollama server did not start"
        exit 1
    fi
done

echo "🔍 Verifying model..."
if ! ollama list | grep -q "gpt-oss:20b"; then
    echo "📥 Downloading model..."
    ollama pull gpt-oss:20b || {
        echo "❌ Failed to download model"
        exit 1
    }
fi

echo "✅ Ready! Model 'gpt-oss:20b' is available."
wait  