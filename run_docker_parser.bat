@echo off
REM Step 1: Build the Docker image
docker build -f Dockerfile_JModelica -t jmodelica_debug_image .

REM Step 2: Run the Docker container without --rm to keep it alive
docker run -d -p 5679:5679 -v C:\Github\project1-boptest\parsing:/workspace -v C:\Github\project1-boptest\data:/workspace/data --name jmodelica_debug jmodelica_debug_image tail -f /dev/null

REM Step 3: Checkout to workspace and run the script inside the container
docker exec -it jmodelica_debug bash -c "cd /workspace && python parser.py"