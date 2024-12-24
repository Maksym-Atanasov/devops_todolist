ARG version=3.8
FROM python:${version} AS base  
WORKDIR /app

COPY . .

FROM python:${version}-slim
WORKDIR /app

ENV PYTHONUNBUFFERED=1

COPY --from=base /app .
RUN pip install --upgrade pip && \
  pip install -r requirements.txt && \
  python manage.py migrate

EXPOSE 8000

CMD [ "python", "manage.py", "runserver" ]