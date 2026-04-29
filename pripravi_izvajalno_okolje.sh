#!/bin/bash

folder_name=$(echo $(basename $1) | cut -d '.' -f 1);

if [ -d "$folder_name" ]; then
    rm -rf $folder_name;
fi

git clone $1

cd $folder_name;

##tempppp for testing
if [ -e Dockerfile ]; then
    rm Dockerfile;
fi
#####

touch Dockerfile;

start="";

if ([ -f run.py ]  && [ -f run.sh ]) || [ -f run.py ]; then
	start="run.py";
	echo "FROM python:3.8" >> Dockerfile;
        echo "WORKDIR /usr/src/app" >> Dockerfile;
        echo "COPY . ." >> Dockerfile;
        if [ -f requirements.txt ]; then
            echo "RUN pip install -r requirements.txt" >> Dockerfile;
        fi
        echo "ENTRYPOINT [\"python\",\"run.py\"]" >> Dockerfile;
elif [ -f run.sh ]; then
	start="run.sh";
	echo "FROM ubuntu" >> Dockerfile;
        echo "WORKDIR /usr/src/app" >> Dockerfile;
        echo "COPY . ." >> Dockerfile;
        echo "RUN chmod +x run.sh" >> Dockerfile;
        echo "ENTRYPOINT [\"./run.sh\"]" >> Dockerfile;
else
	start=".unknown"
	echo "FROM ubuntu" >> Dockerfile;
	echo "CMD [\"sleep\",\"infinity\"]" >> Dockerfile;
fi

docker build -t $(whoami)/$(echo $folder_name | awk '{print tolower($0)}')_$(echo $start | cut -d '.' -f 2) .
docker run $(whoami)/$(echo $folder_name | awk '{print tolower($0)}')_$(echo $start | cut -d '.' -f 2)

