from fastapi import FastAPI
from dotenv import load_dotenv
import os
from fastapi.staticfiles import StaticFiles
from fastapi.websockets import WebSocket

load_dotenv()
app = FastAPI()

TEST_API_KEY = os.getenv("TEST_API_KEY")


# Add your API routes here
@app.get("/api/hello")
def hello_world():
    return {"Hello": f"World_{TEST_API_KEY}"}


# Add your websocket routes here
@app.websocket("/ws/test")
async def websocket_endpoint(websocket: WebSocket):
    await websocket.accept()
    while True:
        data = await websocket.receive_text()
        await websocket.send_text(f"Message text was: {data}")


# Path to the flutter build directory
app.mount("/", StaticFiles(directory="frontend/build/web", html=True), name="static")
