# sapidevenv
Sapientia Dev Environment

# Start
docker compose up --build

# Connect to the console
docker compose exec dev-env-gui bash

# Start eclipse

eclipse &

# Start VSCode

code .

# Stop

docker compose down -v