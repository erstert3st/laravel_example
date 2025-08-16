import os
import asyncio
import logging
import time
import aiohttp
import json
from prometheus_client import start_http_server, Gauge, Summary

# Env variable ENDPOINTS="http://service1/health,http://service2/health"
ENDPOINTS = os.getenv("ENDPOINTS", "").split(",")
if not ENDPOINTS or ENDPOINTS == [""]:
    ENDPOINTS = ["http://localhost:8080/health"]

POLL_INTERVAL = int(os.getenv("POLL_INTERVAL", "30"))
PORT = int(os.getenv("PORT", "8000"))
TIMEOUT = int(os.getenv("TIMEOUT", "5"))
LOG_LEVEL = os.getenv("LOG_LEVEL", "INFO").upper()

# Setup logging
logging.basicConfig(
    level=getattr(logging, LOG_LEVEL),
    format="%(asctime)s - %(name)s - %(levelname)s - %(message)s"
)
logger = logging.getLogger("health-exporter")

# Define metrics
api_status = Gauge('api_health_status', 'HTTP status code of API endpoints', ['endpoint'])
api_response_time = Summary('api_response_time_seconds', 'Response time in seconds', ['endpoint'])
api_content_valid = Gauge('api_content_valid', 'Whether response content is valid JSON and contains status', ['endpoint'])
api_up = Gauge('api_up', 'Whether the endpoint is reachable', ['endpoint'])


api_status = Gauge('api_health_status', 'HTTP status code of API endpoints', ['endpoint'])

async def fetch_status(session, url):
    """Check health of a single endpoint with detailed metrics."""
    start_time = time.time()
    try:
        async with session.get(url, timeout=TIMEOUT) as resp:
            duration = time.time() - start_time
            api_response_time.labels(endpoint=url).observe(duration)
            api_status.labels(endpoint=url).set(resp.status)
            api_up.labels(endpoint=url).set(1)
            
            # Check if content is valid JSON with a status field
            try:
                text = await resp.text()
                data = json.loads(text)
                is_valid = isinstance(data, dict) and "status" in data
                api_content_valid.labels(endpoint=url).set(1 if is_valid else 0)
                logger.debug(f"Endpoint {url} returned status {resp.status} with valid JSON: {is_valid}")
            except (json.JSONDecodeError, UnicodeDecodeError):
                api_content_valid.labels(endpoint=url).set(0)
                logger.warning(f"Endpoint {url} returned non-JSON response")
    except asyncio.TimeoutError:
        logger.warning(f"Timeout while connecting to {url}")
        api_up.labels(endpoint=url).set(0)
        api_status.labels(endpoint=url).set(0)
        api_content_valid.labels(endpoint=url).set(0)
    except aiohttp.ClientError as e:
        logger.error(f"Error connecting to {url}: {e}")
        api_up.labels(endpoint=url).set(0)
        api_status.labels(endpoint=url).set(0)
        api_content_valid.labels(endpoint=url).set(0)
    except Exception as e:
        logger.exception(f"Unexpected error checking {url}: {e}")
        api_up.labels(endpoint=url).set(0)
        api_status.labels(endpoint=url).set(0)
        api_content_valid.labels(endpoint=url).set(0)


async def poll_endpoints():
    """Poll all configured endpoints concurrently."""
    logger.info(f"Polling {len(ENDPOINTS)} endpoints")
    connector = aiohttp.TCPConnector(limit=10)  # Limit concurrent connections
    
    async with aiohttp.ClientSession(connector=connector) as session:
        tasks = [fetch_status(session, url) for url in ENDPOINTS if url]
        await asyncio.gather(*tasks)

async def main():
    """Main application entry point."""
    logger.info(f"Starting health exporter on port {PORT}")
    logger.info(f"Monitoring endpoints: {ENDPOINTS}")
    logger.info(f"Poll interval: {POLL_INTERVAL}s")
    
    # Start Prometheus HTTP server
    start_http_server(PORT)
    
    while True:
        try:
            await poll_endpoints()
        except Exception as e:
            logger.exception(f"Error in polling cycle: {e}")
        
        await asyncio.sleep(POLL_INTERVAL)

if __name__ == "__main__":
    asyncio.run(main())