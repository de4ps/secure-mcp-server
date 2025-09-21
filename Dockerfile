FROM ghcr.io/sparfenyuk/mcp-proxy:latest

RUN apk add --no-cache nodejs npm uv

EXPOSE 8080

ENV PORT=8080

ENTRYPOINT ["mcp-proxy"]

CMD ["uvx", "mcp-server-fetch", "--debug", "--host", "0.0.0.0", "--port", "8080", "--pass-environment"]
