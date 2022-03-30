FROM python:3.10-slim as build
RUN apt-get update
RUN apt-get install -y --no-install-recommends build-essential gcc git

WORKDIR /app
#ENV PATH="/app/venv/bin:$PATH"
ENV PATH=/root/.local/bin:$PATH

COPY requirements.txt .
RUN pip3 install --user -r requirements.txt


FROM python:3.10-slim
WORKDIR /app
COPY --from=build /root/.local /root/.local
COPY . .

#ENV PATH="/usr/app/venv/bin:$PATH"
ENV PATH=/root/.local/bin:$PATH
CMD [ "python", "-m", "tsd_moonraker.app", "-c", "/app/config.ini", "-l", "tsd_moonraker.log" ]
