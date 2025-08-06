#!/bin/bash

export OLLAMA_HOST=0.0.0.0
export OLLAMA_PORT=11434
export OLLAMA_ORIGINS="*"

# Descarga el modelo (si no existe)
echo "🔍 Verifying model..."
if ! ollama list | grep -q "gpt-oss:20b"; then
  echo "📥 Downloading model..."
  ollama pull gpt-oss:20b || {
    echo "❌ Failed to download model";
    exit 1;
  }
fi

# Inicia el servidor
echo "🚀 Starting Ollama..."
ollama serve